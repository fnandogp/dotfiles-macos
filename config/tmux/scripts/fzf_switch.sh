#!/usr/bin/env bash
# Session / window switcher in a native fzf floating pane (fzf --tmux).
# On tmux >= 3.7 the border is drawn by tmux, so fzf never repaints a frame.
#
# usage: fzf_switch.sh session|window|oc [list|preview <sessionID>]
#   list    print "<target>\t<label>" lines only (fzf reload after ctrl-x kill)
#   preview print recent messages of an opencode session (oc mode fzf preview)
#
# oc: pick an opencode session (local API, top-level sessions only, ● running /
# ! waiting for input). If a tmux window already runs it (TUI pane title
# "OC | <title>", cwd fallback) switch there, else open a new window with
# `opencode -s <id>` in the session's directory.
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
    oc)
      # f1 id (hidden) f2 dir f3 age f4 state (● running, ! waiting for input) f5 title
      # Top-level sessions only (background/child agent sessions are noise).
      active=$(opencode api get /api/session/active 2>/dev/null || echo '{}')
      oc_pend() {
        for ep in permission form; do
          opencode api get "/api/session/$1/$ep" 2>/dev/null | jq -e '.data | length > 0' >/dev/null 2>&1 && return 0
        done
        return 1
      }
      while IFS=$'\t' read -r id dir age dot title; do
        [[ "$dot" == "●" ]] && oc_pend "$id" && dot='!'
        printf '%s\t%s\t%s\t%s\t%s\n' "$id" "$dir" "$age" "$dot" "$title"
      done < <(opencode api get /api/session 2>/dev/null | jq -r \
        --arg home "$HOME" --argjson now "$(date +%s)" --arg active "$active" '
        ($active | fromjson).data as $act
        | def ago(ms): ($now - (ms/1000) | floor) as $s
            | if $s < 60 then "\($s)s ago"
              elif $s < 3600 then "\($s/60|floor)m ago"
              elif $s < 86400 then "\($s/3600|floor)h ago"
              else "\($s/86400|floor)d ago" end;
        .data
        | map(select(.parentID == null))
        | sort_by(-(.time.updated // 0))[]
        | [ .id,
            (.location.directory | sub("^" + $home; "~") | if length > 34 then .[0:31] + "..." else . end),
            ago(.time.updated // .time.created // 0),
            (if $act[.id] then "●" else " " end),
            (.title // "untitled")
          ] | @tsv')
      ;;
  esac
}

oc_preview() {
  opencode api get "/api/session/$1/message" 2>/dev/null | jq -r '
    .data[-10:][] | select(.type == "user" or .type == "assistant")
    | ("[" + .type + "] " + (if .type == "user" then (.text // "")
        else ([.content[]?.text // ""] | join(" ")) end
      | gsub("\n+"; " ") | .[0:200]))'
}

[[ "$2" == list ]] && { list; exit; }
[[ "$2" == preview ]] && { oc_preview "$3"; exit; }

# Palette from the active tmux theme (@theme_* options set in themes/*.conf)
theme() { tmux show -gqv "@theme_$1"; }
fg=$(theme fg); surface=$(theme surface); muted=$(theme muted)
accent=$(theme session); pointer=$(theme prefix)

if [[ "$mode" == oc ]]; then
  target=$(list | fzf --tmux center,62%,38% \
    --delimiter $'\t' --with-nth 2,3,4,5 --accept-nth 1 \
    --layout=reverse --no-scrollbar --no-separator --info=inline-right \
    --highlight-line --cycle --pointer '' \
    --prompt 'opencode  ' \
    --header 'enter open/jump   ctrl-x delete   ? messages   ● running   ! waiting' \
    --color "fg:${fg:--1},bg:-1,gutter:-1,hl:${accent:--1},fg+:${fg:--1},bg+:${surface:--1},hl+:${accent:--1},prompt:${accent:--1},pointer:${pointer:--1},info:${muted:--1},header:${muted:--1},border:${surface:--1},preview-border:${surface:--1}" \
    --preview "$0 oc preview {1}" --preview-window 'right,55%,hidden' \
    --bind '?:toggle-preview' \
    --bind "ctrl-x:execute-silent(opencode session delete {1})+reload($0 oc list)") || exit 0

  IFS=$'\t' read -r dir title < <(opencode api get "/api/session/$target" 2>/dev/null \
    | jq -r '[.data.location.directory, (.data.title // "untitled")] | @tsv')
  [[ -d "$dir" ]] || exit 1

  # jump to an existing window already running this session.
  # primary match: the TUI sets pane_title to "OC | <session title>" (tmux may
  # truncate it with …); prefer a title match whose cwd is also the session dir
  # (duplicate titles across projects); fallback: opencode pane in the session dir.
  win=""
  while IFS=$'\t' read -r w cmd ppath ptitle; do
    [[ "$cmd" =~ opencode ]] || continue
    t="${ptitle#OC | }"
    if [[ "$t" == "$title" || ( "$t" == *… && "$title" == "${t%…}"* ) ]]; then
      win="$w"
      [[ "$ppath" == "$dir" ]] && break
    fi
  done < <(tmux list-panes -a -F '#{session_name}:#{window_index}	#{pane_current_command}	#{pane_current_path}	#{pane_title}')
  [[ -z "$win" ]] && win=$(tmux list-panes -a -F '#{session_name}:#{window_index}	#{pane_current_command}	#{pane_current_path}' \
    | awk -F'\t' -v dir="$dir" '$2 ~ /opencode/ && $3 == dir {print $1; exit}')
  if [[ -n "$win" ]]; then
    tmux switch-client "${client_args[@]}" -t "$win"
  else
    sess=$(tmux display-message -p "${client_args[@]}" '#S')
    new=$(tmux new-window -d -P -F '#{session_name}:#{window_index}' \
      -t "$sess:" -c "$dir" -n "oc" "opencode -s '$target'")
    tmux switch-client "${client_args[@]}" -t "$new"
  fi
  exit 0
fi

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
