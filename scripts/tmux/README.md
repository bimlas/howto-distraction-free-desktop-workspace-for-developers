# Tmux scripts

Collection of [Tmux](https://github.com/tmux/tmux) scripts to easily navigate between windows and panes.

Tested with **Tmux 3.2a**.

## Window list with fuzzy filter

Add this script to your `~/.tmux.conf` to have a searchable list of windows and panes. The script depends on [FZF](https://github.com/junegunn/fzf).

```
bind-key -T prefix Space display-popup -w 90% -E "\
  tmux list-windows -a -F '#{session_name}:#{window_index}|#{window_name}' \
  | column -s '|' -t \
  | fzf --reverse --cycle --preview-window right:75% --preview='echo {} \
    | cut -d \" \" -f 1 \
    | xargs tmux capture-pane -p -e -N -t' \
  | cut -d ' ' -f 1 \
  | xargs --no-run-if-empty tmux switch-client -t"
```
