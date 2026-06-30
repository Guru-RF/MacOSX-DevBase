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
      "args": ["attach", "--create", "macosx-devbase"],
      "env": { "ZELLIJ_SOCKET_DIR": "/tmp/zellij" }
    }
  },
  "terminal.integrated.defaultProfile.osx": "zellij",
  "terminal.integrated.macOptionIsMeta": true
}
```

- `defaultProfile.osx` makes Zellij the terminal that opens by default.
- `env.ZELLIJ_SOCKET_DIR` points Zellij at a short socket directory. macOS caps the Unix-domain IPC socket path at ~103 bytes; the default sits under the long `$TMPDIR` (`/var/folders/…`), so a long session name overflows the limit and the terminal fails to launch with `exit code 1`. `/tmp/zellij` keeps every session name well under the cap.
- `attach --create macosx-devbase` attaches to a session named `macosx-devbase`, creating it the first time. The name is fixed per project, so you always return to the same workspace.
- `path` is a list of fallbacks — the first one that exists is used (Apple Silicon Homebrew, Intel Homebrew, then a bare `PATH` lookup).
- `macOptionIsMeta` makes the `Option` key send `Alt`/Meta inside the terminal — see [macOS keybindings](#macos-keybindings).

> `.vscode` is excluded by the global gitignore on this machine, so the file was force-added (`git add -f .vscode/settings.json`). Once tracked, Git follows it normally.

### Using Zellij for every project (global default)

The settings above apply only to this project. To make Zellij the default integrated terminal for **every** project, add the same keys to your user `settings.json` (Cmd+Shift+P → *Preferences: Open User Settings (JSON)*), using a per-folder session name so each project gets its own persistent session:

```json
{
  "terminal.integrated.profiles.osx": {
    "zellij": {
      "path": ["/opt/homebrew/bin/zellij", "/usr/local/bin/zellij", "zellij"],
      "args": ["attach", "--create", "vscode-${workspaceFolderBasename}"],
      "env": { "ZELLIJ_SOCKET_DIR": "/tmp/zellij" }
    }
  },
  "terminal.integrated.defaultProfile.osx": "zellij",
  "terminal.integrated.macOptionIsMeta": true
}
```

- `${workspaceFolderBasename}` expands to the open folder's name, so a project in `~/Git/foo` attaches to a `vscode-foo` session — each project stays isolated and persistent.
- `env.ZELLIJ_SOCKET_DIR=/tmp/zellij` is **required** here: with the default `$TMPDIR` socket dir, a long folder name (e.g. `Analog-HotSPOT-SVXLink` → `vscode-Analog-HotSPOT-SVXLink`) pushes the IPC socket path past the macOS ~103-byte limit and the terminal fails to launch with `exit code 1`. The short dir fixes it for every project.
- This project's committed [.vscode/settings.json](.vscode/settings.json) overrides the `zellij` profile with a fixed `macosx-devbase` session name, so it takes precedence here while every other project falls back to the global `vscode-<folder>` profile.

### Persistent ("saved") session

Zellij serializes and resurrects sessions. In `~/.config/zellij/config.kdl`:

- `session_serialization` is on by default — restores tabs, panes, cwd and the commands that were running.
- `serialize_pane_viewport true` is set so scrollback content is restored too.

Reopen VS Code (or reload the window) and the terminal reattaches to `macosx-devbase` exactly as you left it.

### Theme — Solarized Dark + Powerline

The terminal uses a custom theme, [dotconfig/zellij/themes/solarized-powerline.kdl](dotconfig/zellij/themes/solarized-powerline.kdl), so Zellij's own chrome lines up with the rest of the setup:

- **Base palette stays Solarized Dark** — matches the VS Code *Better Solarized Dark Italics* color theme, so the editor and terminal share one palette.
- **Status bar adopts the Liquidprompt powerline colours** — the bright white default bottom bar is the main thing this fixes. The plain status-bar fill/label text (e.g. the session name) is muted Solarized grey (`base0` `#839496`); the mode/keybinding ribbons (`LOCK`, `PANE`, `TAB`, …) render as ribbons — the active one is dark `base03` (`#002b36`) text on powerline **orange** (`#cb4b16`, the same accent as the prompt's host segment), and inactive ones are `base1` (`#93a1a1`) on the powerline path **grey** `base01` (`#586e75`); the bar background is dark `base03` (`#002b36`).

Install and select it:

```bash
mkdir -p ~/.config/zellij/themes
cp dotconfig/zellij/themes/solarized-powerline.kdl ~/.config/zellij/themes/
```

```kdl
// ~/.config/zellij/config.kdl
theme "solarized-powerline"
```

Zellij reads the theme only when a session is **created**, so a running `macosx-devbase` keeps the old colours until you recreate it:

```bash
# in the terminal: detach with Ctrl o then d, then
zellij kill-session macosx-devbase
```

Reopen the VS Code terminal (Cmd+Shift+P → *Terminal: Kill the Active Terminal Instance*, then open a new one). It runs `attach --create` and resurrects the session — panes, cwd and scrollback restored — now with the new bar colours. To preview without touching your main session, run `zellij attach -c preview` in any terminal; detach with `Ctrl o` then `d`, and remove it with `zellij delete-session preview -f` (the `-f` is required because the detached session is still active).

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
