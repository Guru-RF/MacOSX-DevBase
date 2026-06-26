# VS Code

## Zellij as the integrated terminal

This project uses [Zellij](https://zellij.dev) as the default integrated terminal, with a persistent session so your panes, tabs, working directories and scrollback survive window reloads and restarts.

### Prerequisites

Install Zellij so it is available on `PATH`:

```bash
brew install zellij
```

### Project settings

[.vscode/settings.json](.vscode/settings.json) is committed with:

```json
{
  "terminal.integrated.profiles.osx": {
    "zellij": {
      "path": ["/opt/homebrew/bin/zellij", "/usr/local/bin/zellij", "zellij"],
      "args": ["attach", "--create", "macosx-devbase"]
    }
  },
  "terminal.integrated.defaultProfile.osx": "zellij",
  "terminal.integrated.macOptionIsMeta": true
}
```

- `defaultProfile.osx` makes Zellij the terminal that opens by default.
- `attach --create macosx-devbase` attaches to a session named `macosx-devbase`, creating it the first time. The name is fixed per project, so you always return to the same workspace.
- `path` is a list of fallbacks — the first one that exists is used (Apple Silicon Homebrew, Intel Homebrew, then a bare `PATH` lookup).
- `macOptionIsMeta` makes the `Option` key send `Alt`/Meta inside the terminal — see [macOS keybindings](#macos-keybindings).

> `.vscode` is excluded by the global gitignore on this machine, so the file was force-added (`git add -f .vscode/settings.json`). Once tracked, Git follows it normally.

### Persistent ("saved") session

Zellij serializes and resurrects sessions. In `~/.config/zellij/config.kdl`:

- `session_serialization` is on by default — restores tabs, panes, cwd and the commands that were running.
- `serialize_pane_viewport true` is set so scrollback content is restored too.

Reopen VS Code (or reload the window) and the terminal reattaches to `macosx-devbase` exactly as you left it.

### Usage notes

- Use Zellij's own tabs and panes inside the single VS Code terminal. Opening additional VS Code terminals attaches them to the **same** named session, so they mirror each other.
- Reload the window after changing `.vscode/settings.json`: Cmd+Shift+P → *Developer: Reload Window*.
- Detach without killing the session with `Ctrl o` then `d`. Start fresh with `zellij delete-session macosx-devbase`.

### macOS keybindings

Zellij's default bindings use `Alt`, which macOS lacks. Inside the **VS Code integrated terminal** this is handled by `"terminal.integrated.macOptionIsMeta": true` (already in the settings above).

When running Zellij in a standalone terminal emulator instead, configure the `Option` key there:

- **iTerm2:** Settings → Profiles → Keys → *Left Option key* = **Esc+** (not `Normal`/`Meta`).
- **Ghostty:** `macos-option-as-alt = true`.
- **Terminal.app:** Profiles → Keyboard → *Use Option as Meta key*.

The `Ctrl`-based bindings work without any of this.
