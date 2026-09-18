#!/usr/bin/env bash
# Session / window switcher in a native fzf floating pane (fzf --tmux).
# On tmux >= 3.7 the border is drawn by tmux, so fzf never repaints a frame.
#
# usage: fzf_switch.sh session|window|agent [list|preview <tool> <target>|delete <tool> <target>]
#   list    print "<target>\t<label>" lines only (fzf reload after ctrl-x kill)
#   preview print messages of an opencode session / capture a claude window
#   delete  kill a claude window / delete an opencode session
#
# agent: unified picker for AI coding sessions open in tmux (claude + opencode),
# with a tool column telling them apart. Only live TUIs are listed.
# claude: foreground process is claude, the window is the target ("✳ <title>"
# pane stamp is the label). opencode: the TUI stamps pane_title "OC | <title>",
# matched to API sessions for status/id; jump falls back to cwd matching.
#
# Bind with TMUX_CLIENT='#{client_tty}' so the switch lands on the client that
# opened the picker, not the most recently active one.

mode="$1"
client_args=()
[[ -n "$TMUX_CLIENT" ]] && client_args=(-c "$TMUX_CLIENT")

# tmux's server env can go stale (run-shell never sources zprofile/pathrc);
# pnpm moved its global bin to $PNPM_HOME/bin, which old servers don't know.
if ! command -v opencode >/dev/null 2>&1; then
  PATH="$HOME/Library/pnpm/bin:$PATH"
  export PATH
fi

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
    agent)
      # Unified picker: AI coding sessions currently open in tmux (claude +
      # opencode). Both TUIs stamp pane_title ("<glyph> <session title>").
      # f1 target (opencode: session id; claude: window) f2 tool
      # f3 status f4 tmux session f5 title f6 age
      trunc() {
        local s=$1 n=$2
        ((${#s} > n)) && printf '%s…' "${s:0:n-1}" || printf '%s' "$s"
      }

      # claude TUIs: foreground process is claude, window is the target;
      # shells with a leftover ✳ title (claude exited) are excluded
      while IFS=$'\t' read -r target cmd ptitle tsess; do
        printf '%s\t%s\t%-2s\t%-12s\t%-40s\t%s\n' \
          "$target" claude " " "$(trunc "$tsess" 12)" "$(trunc "${ptitle#✳ }" 40)" ""
      done < <(tmux list-panes -a -F '#{session_name}:#{window_index}	#{pane_current_command}	#{pane_title}	#{session_name}' \
        | awk -F'\t' '$2 == "claude"')

      # opencode TUIs: only sessions open in a window - the TUI stamps
      # pane_title as "OC | <session title>" (tmux may truncate with …),
      # so drive the list from the panes and match API sessions to them.
      active=$(opencode api get /api/session/active 2>/dev/null || echo '{}')
      pane_map=$(tmux list-panes -a -F '#{pane_title}	#{session_name}	#{pane_current_path}	#{pane_current_command}' \
        | awk -F'\t' '$4 ~ /opencode/')
      opencode_waiting_on_input() {
        for ep in permission form; do
          opencode api get "/api/session/$1/$ep" 2>/dev/null | jq -e '.data | length > 0' >/dev/null 2>&1 && return 0
        done
        return 1
      }
      # API rows: id status name age dir (top-level only; background children are noise)
      mapfile -t api_rows < <(opencode api get /api/session 2>/dev/null | jq -r \
        --argjson now "$(date +%s)" --arg active "$active" '
        (($active | fromjson? // {}).data) as $act
        | def ago(ms): ($now - (ms/1000) | floor) as $s
            | if $s < 60 then "\($s)s ago"
              elif $s < 3600 then "\($s/60|floor)m ago"
              elif $s < 86400 then "\($s/3600|floor)h ago"
              else "\($s/86400|floor)d ago" end;
        .data
        | map(select(.parentID == null))
        | sort_by(-(.time.updated // 0))[]
        | [ .id,
            (if $act[.id] then "●" else " " end),
            (.title // "untitled"),
            ago(.time.updated // .time.created // 0),
            .location.directory
          ] | @tsv')
      declare -A listed=()
      while IFS=$'\t' read -r ptitle tsess ppath cmd; do
        t="${ptitle#OC | }"
        for row in "${api_rows[@]}"; do
          IFS=$'\t' read -r id status name age dir <<<"$row"
          [[ -n "${listed[$id]:-}" ]] && continue
          # title match (exact or …-truncated); untitled sessions match by cwd
          if [[ "$t" == "$name" || ( "$t" == *… && "$name" == "${t%…}"* ) ]] \
             || { [[ -z "${t// /}" || "$t" == "untitled" ]] && [[ "$dir" == "$ppath" ]]; }; then
            listed[$id]=1
            [[ "$status" == "●" ]] && opencode_waiting_on_input "$id" && status='!'
            printf '%s\t%s\t%-2s\t%-12s\t%-40s\t%s\n' \
              "$id" opencode "$status" "$(trunc "$tsess" 12)" "$(trunc "$name" 40)" "$age"
            break
          fi
        done
      done <<<"$pane_map"
      ;;
  esac
}

opencode_preview() {
  # .data // [] guards against null (deleted session, stale list entry)
  opencode api get "/api/session/$1/message" 2>/dev/null | jq -r '
    (.data // [])[-10:][] | select(.type == "user" or .type == "assistant")
    | ("[" + .type + "] " + (if .type == "user" then (.text // "")
        else ([.content[]?.text // ""] | join(" ")) end
      | gsub("\n+"; " ") | .[0:200]))' \
    | sed -E '/^\[(user|assistant)\] *$/d'   # drop empty-text messages
}

[[ "$2" == list ]] && { list; exit; }
# agent helpers: dispatch on tool (claude: tmux window / opencode: session id)
[[ "$2" == preview ]] && {
  if [[ "$3" == claude ]]; then tmux capture-pane -ep -t "$4"
  else opencode_preview "$4"; fi
  exit
}
[[ "$2" == delete ]] && {
  if [[ "$3" == claude ]]; then tmux kill-window -t "$4"
  else opencode session delete "$4"; fi
  exit
}

# Palette from the active tmux theme (@theme_* options set in themes/*.conf)
theme() { tmux show -gqv "@theme_$1"; }
fg=$(theme fg); surface=$(theme surface); muted=$(theme muted)
accent=$(theme session); pointer=$(theme prefix)

if [[ "$mode" == agent ]]; then
  IFS=$'\t' read -r target tool < <(list | fzf --tmux center,62%,38% \
    --delimiter $'\t' --with-nth 3.. --accept-nth 1,2 \
    --layout=reverse --no-scrollbar --no-separator --info=inline-right \
    --highlight-line --cycle --pointer '' \
    --prompt 'agents  ' \
    --header 'enter jump   ctrl-x kill/delete   ? preview   ● running   ! waiting' \
    --color "fg:${fg:--1},bg:-1,gutter:-1,hl:${accent:--1},fg+:${fg:--1},bg+:${surface:--1},hl+:${accent:--1},prompt:${accent:--1},pointer:${pointer:--1},info:${muted:--1},header:${muted:--1},border:${surface:--1},preview-border:${surface:--1}" \
    --preview "$0 agent preview {2} {1}" --preview-window 'right,55%,hidden' \
    --bind '?:toggle-preview' \
    --bind "ctrl-x:execute-silent($0 agent delete {2} {1})+reload($0 agent list)") || exit 0

  if [[ "$tool" == claude ]]; then
    tmux switch-client "${client_args[@]}" -t "$target"
    exit 0
  fi
  [[ -z "$target" ]] && exit 1   # opencode row selected

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
    # resolve the binary here: the new pane inherits the (possibly stale)
    # server env and may not find `opencode` on its own PATH
    opencode_bin=$(command -v opencode)
    sess=$(tmux display-message -p "${client_args[@]}" '#S')
    new=$(tmux new-window -d -P -F '#{session_name}:#{window_index}' \
      -t "$sess:" -c "$dir" -n "opencode" "'$opencode_bin' -s '$target'")
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
