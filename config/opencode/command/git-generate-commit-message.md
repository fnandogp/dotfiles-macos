---
description: Generates a commit message from staged changes.
argument-hint: [optional context...]
allowed-tools: Bash(git diff:*)
---

# Task: Generate a Conventional Commit Message

Based on the following code changes, please generate a concise and descriptive commit message that follows the Conventional Commits specification.

Provide only the commit message itself, without any introduction or explanation.

## Staged Changes:

!git diff --cached

## Optional User Context:

$ARGUMENTS
