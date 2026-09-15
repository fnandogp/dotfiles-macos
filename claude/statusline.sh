#!/bin/bash

# Statusline using the terminal's ANSI palette, so it follows the active
# terminal theme (Ghostty, Kitty) instead of a fixed colour set.
# Context usage comes straight from the JSON Claude Code sends on stdin
# (https://code.claude.com/docs/en/statusline)

# Accent slot: blue, cyan, magenta, green, yellow
COLOR="blue"

C_RESET='\033[0m'
C_TEXT='\033[39m'      # terminal default foreground
C_BAR_EMPTY='\033[90m'     # bright black foreground (muted)
C_BAR_EMPTY_BG='\033[100m' # same slot as background, fills the top half of a partial cell

case "$COLOR" in
blue) C_ACCENT='\033[34m' ;;
cyan) C_ACCENT='\033[36m' ;;
magenta) C_ACCENT='\033[35m' ;;
green) C_ACCENT='\033[32m' ;;
yellow) C_ACCENT='\033[33m' ;;
*) C_ACCENT="$C_TEXT" ;;
esac

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
max_context=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
max_k=$((max_context / 1000))

[[ $pct -gt 100 ]] && pct=100

bar_width=10
bar=""
for ((i = 0; i < bar_width; i++)); do
	bar_start=$((i * 10))
	progress=$((pct - bar_start))
	if [[ $progress -ge 8 ]]; then
		bar+="${C_ACCENT}█${C_RESET}"
	elif [[ $progress -ge 3 ]]; then
		bar+="${C_ACCENT}${C_BAR_EMPTY_BG}▄${C_RESET}"
	else
		bar+="${C_BAR_EMPTY}█${C_RESET}"
	fi
done

printf '%b\n' "${C_ACCENT}${model}${C_TEXT} | ${bar} ${C_TEXT}${pct}% of ${max_k}k tokens${C_RESET}"
