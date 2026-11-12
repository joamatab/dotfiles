# Herdr

Herdr's own settings live in `~/.config/herdr-app` (the app rewrites its
shipped layouts, mods and `AGENTS.md` there, so only what's ours belongs in
this folder).

- `keys.json` → `~/.config/herdr-app/keys.json`. Herdr's defaults plus `f2`
  for the jumper (below) instead of renaming a tab.
- `mods/jumper/` → `~/.config/herdr-app/mods/jumper/`: a folder picker on
  **F2**. It opens on the focused terminal's folder and lists what's in it —
  folders first, the ones you were in last first — filtered as you type.

  | key | does |
  |---|---|
  | type | filter; `/` or `~` at the start lists that path |
  | `↑` `↓`, `Ctrl-n` `Ctrl-p` | move |
  | `Tab` | fill in the chosen folder's name |
  | `→` / `←` | into a folder / up one |
  | `Enter` | go: shows the space already there, else makes one |
  | `Alt-Enter` | always a new space |
  | `Ctrl-Enter` | a new tab there; on a file, a tab running `nvim +file` |
  | `Ctrl-Space` | the system's folder picker |
  | `Esc` | close |

  The editor for file rows is `jumper.editor` in
  `~/.config/herdr-app/shared.json` (default `nvim`).
