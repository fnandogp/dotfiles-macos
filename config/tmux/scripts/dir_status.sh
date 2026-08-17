#!/usr/bin/env bash
# Print the pane directory name for the tmux status bar.
# Inside a linked git worktree, expand to "<project> (<worktree>)".

path="$1"
name="${path##*/}"

git_dir=$(git -C "$path" rev-parse --absolute-git-dir 2>/dev/null) || { echo "$name"; exit; }

# Linked worktrees live under <common>/worktrees/<name>; a normal repo does not.
if [[ "$git_dir" == */worktrees/* ]]; then
  common_dir=${git_dir%/worktrees/*}          # .../<project>/.bare (or .git)
  project=$(basename "$(dirname "$common_dir")")
  echo "$project ($name)"
else
  echo "$name"
fi
