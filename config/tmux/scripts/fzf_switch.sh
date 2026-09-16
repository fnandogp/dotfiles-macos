#!/usr/bin/env bash
# Session / window switcher in a native fzf floating pane (fzf --tmux).
# On tmux >= 3.7 the border is drawn by tmux, so fzf never repaints a frame.
#
# usage: fzf_switch.sh session|window [list]
#   list   print "<target>\t<label>" lines only (fzf reload after ctrl-x kill)
#
# Bind with TMUX_CLIENT='#{client_tty}' so the switch lands on the client that
# opened the picker, not the most recently active one.

mode="$1"
client_args=()
[[ -n "$TMUX_CLIENT" ]] && client_args=(-c "$TMUX_CLIENT")

list() {
  case "$mode" in
    session)
      current=$(tmux display-message -p "${client_args[@]}" '#S')
      tmux list-sessions -F "#S	#{p28:session_name} #{session_windows}w  #{s|$HOME|~|:session_path}" \
        | grep -v "^$current	"
      ;;
    window)
      current=$(tmux display-message -p "${client_args[@]}" '#S:#I')
      tmux list-windows -a -F '#S:#I	#{p22:session_name} #{p2:window_index} #{p16:window_name} #{pane_current_command}' \
        | grep -v "^$current	"
      ;;
  esac
}

[[ "$2" == list ]] && { list; exit; }

# Palette from the active tmux theme (@theme_* options set in themes/*.conf)
theme() { tmux show -gqv "@theme_$1"; }
fg=$(theme fg); surface=$(theme surface); muted=$(theme muted)
accent=$(theme session); pointer=$(theme prefix)

target=$(list | fzf --tmux center,62%,38% \
  --delimiter $'\t' --with-nth 2.. --accept-nth 1 \
  --layout=reverse --no-scrollbar --no-separator --info=inline-right \
  --highlight-line --cycle --pointer '' \
  --prompt "${mode}s  " \
  --header 'enter switch   ctrl-x kill   ? preview' \
  --color "fg:${fg:--1},bg:-1,gutter:-1,hl:${accent:--1},fg+:${fg:--1},bg+:${surface:--1},hl+:${accent:--1},prompt:${accent:--1},pointer:${pointer:--1},info:${muted:--1},header:${muted:--1},border:${surface:--1},preview-border:${surface:--1}" \
  --preview 'tmux capture-pane -ep -t {1}' --preview-window 'right,55%,hidden' \
  --bind '?:toggle-preview' \
  --bind "ctrl-x:execute-silent(tmux kill-$mode -t {1})+reload($0 $mode list)") || exit 0

tmux switch-client "${client_args[@]}" -t "$target"
