# Rofi scripts

Collection of Rofi scripts to easily navigate between windows.

**You have to align the scripts in `lib` directory to your environment to be able to use them!** For example you may have different terminal emulator with different flags.

Tested with **Rofi 1.7.3**.

Example `~/.config/rofi/config.rasi`:

```
@theme "Arc"

configuration {
  kb-mode-next: "Super+Tab";
  matching-negate-char: '!';

  // Create or attach to Tmux session on remote
  ssh-command: "{terminal} -T {host} -e ssh -t {host} tmux new-session -As ssh";

  show-icons: true;
  font: "mono 12";
  // Show modi list on the bottom of the window
  sidebar-mode: true;
}
```

## Window list

Show searchable window list (`Alt+Tab` with fuzzy filter), SSH hosts and project directories.

Define these hotkeys in your window manager:

- `Super+Tab`
  - `/bin/bash -c 'WINDOW_MANAGER=awesome /path/to/window-list'`

Environment variables:

- `WINDOW_MANAGER` (defaults to `awesome`)
  - The script using `lib/group-windows.${WINDOW_MANAGER}` when you press `Shift+Enter` in window list, so you may have to implement your window manager specific script first (the argument of the script will be the ID of the selected window)
- `PROJECTS_DIR` (defaults to `$HOME`)
  - The root of your projects directory, the top level directories are listed in projects list

Modify this line in `~/.config/rofi/config.rasi` to use the same binding to open window list and switch between contexts:

```
configuration {
  kb-mode-next: "Super+Tab";
}
```

## Named terminal

Create named terminal to easily find in window list.

Define these hotkeys in your window manager:

- `Super+Enter`
  - `/path/to/named-terminal`
