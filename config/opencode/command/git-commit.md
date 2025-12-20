---
description: Generates a commit message and commits.
argument-hint: [optional context...]
allowed-tools: Bash(git diff:*, git status, git commit:*)
---

# Task: Generate Conventional Commit Message and Commit

Based on the following code changes, please generate a concise and descriptive commit message that follows the Conventional Commits specification.

Then commit with that message.

## Staged Changes:

!git diff --cached

## Optional User Context:

$ARGUMENTS
