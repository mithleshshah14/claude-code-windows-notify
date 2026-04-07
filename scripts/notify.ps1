param(
    [string]$Title = "Claude Code",
    [string]$Message = "Task completed!"
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Play notification sound
[System.Media.SystemSounds]::Asterisk.Play()

# Custom TopMost popup — renders above fullscreen apps, bypasses Focus Assist
$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.TopMost = $true
$form.ShowInTaskbar = $false
$form.Width = 320
$form.Height = 72
$form.BackColor = [System.Drawing.Color]::FromArgb(24, 24, 28)
$form.Opacity = 0.96

# Position: bottom-right corner, above taskbar
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual
$form.Location = [System.Drawing.Point]::new($screen.Width - $form.Width - 16, $screen.Height - $form.Height - 16)

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
$form.Add_Click({ $form.Close() })
$lblTitle.Add_Click({ $form.Close() })
$lblMsg.Add_Click({ $form.Close() })

# Auto-close after 5 seconds
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 5000
$timer.Add_Tick({ $timer.Stop(); $form.Close() })
$timer.Start()

$form.ShowDialog() | Out-Null
