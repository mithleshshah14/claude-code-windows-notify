# Contributing

Contributions are welcome! If you have ideas for improvements — new hook types, better styling, multi-monitor support, sound options, etc. — feel free to open a PR.

## How to contribute

1. Fork the repo
2. Create a branch (`git checkout -b feature/your-idea`)
3. Make your changes
4. Test it locally by copying `scripts/notify.ps1` to `~/.claude/notify.ps1` and triggering a Claude Code session
5. Open a pull request with a short description of what you changed and why

## Ideas for contributions

- Support for additional hook events (e.g. `Notification`, `PostToolUse`)
- Custom sound options
- Multi-monitor awareness (show on the monitor where the active window is)
- Configurable duration, colors, or position
- A one-command setup script (`setup.ps1`)

## Requirements

- Windows 10 / 11
- PowerShell 5.1+
- Claude Code CLI for testing
