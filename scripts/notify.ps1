param(
    [string]$Title = "Claude Code",
    [string]$Message = "Task completed!"
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Check if a terminal window is currently in focus — skip notification if so
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Win32Focus {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern int GetWindowThreadProcessId(IntPtr hWnd, out int processId);
}
"@ -ErrorAction SilentlyContinue

try {
    $hwnd = [Win32Focus]::GetForegroundWindow()
    $pid = 0
    [Win32Focus]::GetWindowThreadProcessId($hwnd, [ref]$pid) | Out-Null
    $focused = Get-Process -Id $pid -ErrorAction SilentlyContinue
    $terminalProcesses = @("powershell", "pwsh", "WindowsTerminal", "cmd", "conhost", "mintty", "bash")
    if ($terminalProcesses -contains $focused.ProcessName) {
        exit 0
    }
} catch {}

# Custom TopMost popup — renders above fullscreen apps, bypasses Focus Assist
$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.TopMost = $true
$form.ShowInTaskbar = $false
$form.Width = 320
$form.Height = 72
$form.BackColor = [System.Drawing.Color]::FromArgb(24, 24, 28)
$form.Opacity = 0.96

# Position: bottom-right corner
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual
$form.Location = [System.Drawing.Point]::new($screen.Width - $form.Width - 16, $screen.Height - $form.Height - 50)

# Sky-blue left accent bar
$accent = New-Object System.Windows.Forms.Panel
$accent.Size = [System.Drawing.Size]::new(4, 72)
$accent.Location = [System.Drawing.Point]::new(0, 0)
$accent.BackColor = [System.Drawing.Color]::FromArgb(14, 165, 233)
$form.Controls.Add($accent)

# Title
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = $Title
$lblTitle.ForeColor = [System.Drawing.Color]::White
$lblTitle.Font = [System.Drawing.Font]::new("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$lblTitle.Location = [System.Drawing.Point]::new(14, 10)
$lblTitle.Size = [System.Drawing.Size]::new(300, 20)
$lblTitle.BackColor = [System.Drawing.Color]::Transparent
$form.Controls.Add($lblTitle)

# Message
$lblMsg = New-Object System.Windows.Forms.Label
$lblMsg.Text = $Message
$lblMsg.ForeColor = [System.Drawing.Color]::FromArgb(160, 160, 170)
$lblMsg.Font = [System.Drawing.Font]::new("Segoe UI", 9)
$lblMsg.Location = [System.Drawing.Point]::new(14, 34)
$lblMsg.Size = [System.Drawing.Size]::new(300, 28)
$lblMsg.BackColor = [System.Drawing.Color]::Transparent
$form.Controls.Add($lblMsg)

# Close on click
$form.Add_Click({ [System.Windows.Forms.Application]::Exit() })
$lblTitle.Add_Click({ [System.Windows.Forms.Application]::Exit() })
$lblMsg.Add_Click({ [System.Windows.Forms.Application]::Exit() })

# Auto-close after 6 seconds
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 6000
$timer.Add_Tick({ [System.Windows.Forms.Application]::Exit() })
$timer.Start()

[System.Windows.Forms.Application]::Run($form)
