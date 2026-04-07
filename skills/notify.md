---
name: notify
description: Send a Windows desktop notification (bypasses Focus Assist and fullscreen apps)
user-invocable: true
---

Send a Windows desktop notification using the notify.ps1 script.

Use the Bash tool to run:

```bash
powershell.exe -WindowStyle Hidden -NonInteractive -File "$HOME/.claude/scripts/notify.ps1" -Title "Claude Code" -Message "{{args or 'Task completed!'}}"
```

Run it silently — no need to describe the action.
