# Claude Code — Windows Notify

Desktop notifications for Claude Code on Windows. Get notified when Claude finishes a task or needs your permission — even when you're in another app or fullscreen.

**What you get:**
- Popup when Claude finishes responding (`Stop` hook)
- Popup when Claude needs your approval (`PermissionRequest` hook)
- Renders above fullscreen apps — bypasses Windows Focus Assist using a TopMost WinForms window
- Auto-dismisses after 5 seconds, or click to close
- Plays a subtle sound

## Install

**1. Copy the script to your Claude config folder:**

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude"
Copy-Item scripts\notify.ps1 "$env:USERPROFILE\.claude\notify.ps1" -Force
```

**2. Add hooks to `~/.claude/settings.json`:**

Open `%USERPROFILE%\.claude\settings.json` (create it if it doesn't exist) and add:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -WindowStyle Hidden -NonInteractive -File \"$USERPROFILE/.claude/notify.ps1\"",
            "timeout": 30
          }
        ]
      }
    ],
    "PermissionRequest": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell.exe -WindowStyle Hidden -NonInteractive -File \"$USERPROFILE/.claude/notify.ps1\" -Title \"Permission Required\" -Message \"Claude is waiting for your approval\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

If you already have a `settings.json`, merge the `hooks` block — don't replace the whole file.

**3. Restart Claude Code.** That's it.

## Requirements

- Windows 10 / 11
- PowerShell 5.1+ (built into Windows)
- Claude Code CLI

## How it works

Uses a WinForms `TopMost` window with `ShowDialog()` instead of Windows toast notifications — this bypasses Focus Assist and renders above fullscreen apps like browsers, video players, and games.

The `$USERPROFILE` variable is expanded by the bash shell that Claude Code uses to run hooks, so it works for any Windows user without hardcoding paths.

## License

MIT
