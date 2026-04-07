# Claude Code — Windows Notify Skill

A Claude Code skill that sends a desktop notification on Windows when Claude finishes a task.

**Smart behaviour:**
- Skips the notification if you're actively in the terminal (no spam while watching)
- Fires when you've switched to another app — browser, video, game, etc.
- Renders above fullscreen apps by bypassing Windows Focus Assist with a TopMost WinForms window
- Auto-dismisses after 6 seconds, or click to close

![Notification preview — dark popup in bottom-right corner with sky-blue accent bar](preview.png)

## Install

**1. Install the skill via Claude Code:**

```
/plugin install mithleshshah14/claude-code-windows-notify
```

**2. Copy the script to your Claude config folder:**

```powershell
Copy-Item scripts\notify.ps1 "$HOME\.claude\scripts\notify.ps1" -Force
```

Or create the folder first if it doesn't exist:
```powershell
New-Item -ItemType Directory -Force "$HOME\.claude\scripts"
Copy-Item scripts\notify.ps1 "$HOME\.claude\scripts\notify.ps1"
```

**3. Add the Stop hook to `~/.claude/settings.json`:**

```json
{
  "hooks": {
    "Stop": [
      {
        "command": "powershell.exe -WindowStyle Hidden -NonInteractive -File \"%USERPROFILE%\\.claude\\scripts\\notify.ps1\"",
        "timeout": 8000
      }
    ]
  }
}
```

That's it. Now every time Claude finishes responding (and you're not in the terminal), a notification pops up.

## Manual trigger

You can also trigger it manually with `/notify` or `/notify your custom message here`.

## Requirements

- Windows 10 / 11
- PowerShell 5.1+ (built into Windows)
- Claude Code CLI

## How it works

Uses a WinForms `TopMost` window instead of the Windows toast notification API — this bypasses Focus Assist and renders above fullscreen browser windows, video players, etc.
