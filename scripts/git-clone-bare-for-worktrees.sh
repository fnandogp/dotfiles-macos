#!/usr/bin/env bash
set -e

# Examples of call:
# git-clone-bare-for-worktrees git@github.com:name/repo.git
# => Clones to a /repo directory
#
# git-clone-bare-for-worktrees git@github.com:name/repo.git my-repo
# => Clones to a /my-repo directory

url=$1
basename=${url##*/}
name=${2:-${basename%.*}}

# Verify we can access the remote before creating directories
if ! git ls-remote "$url" HEAD >/dev/null 2>&1; then
	echo "Error: Cannot access remote repository '$url'" >&2
	echo "Check your permissions and network connection." >&2
	exit 1
fi

mkdir "$name"
cd "$name"

# Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
#
# Plan is to create worktrees as siblings of this directory.
# Example targeted structure:
# .bare
# main
# new-awesome-feature
# hotfix-bug-12
# ...
git clone --bare "$url" .bare
echo "gitdir: ./.bare" >.git

# Explicitly sets the remote origin fetch so we can fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Gets all branches from origin
git fetch origin

# Detect the default branch and create a worktree for it
default_branch=$(git remote show origin | sed -n 's/.*HEAD branch: //p')

if [ -n "$default_branch" ]; then
	git worktree add "$default_branch" "$default_branch"
	echo "Created worktree for default branch '$default_branch'"
else
	echo "Warning: Could not detect default branch. No worktree created." >&2
fi
