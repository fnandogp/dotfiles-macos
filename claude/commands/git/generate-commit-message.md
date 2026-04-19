---
description: Generate a conventional commit message from staged changes.
argument-hint: "[optional context]"
allowed-tools: Bash(git diff:*)
---

# Task: Generate a Conventional Commit Message

Based on the staged code changes, generate a concise conventional commit message. Provide only the commit message, no explanation.

## Steps

1. Run `git diff --cached` to see staged changes
2. Generate a commit message following Conventional Commits format
3. Output only the message

## Rules

- Format: `<type>(<scope>): <subject>`
- Max 50 chars for subject line
- Imperative mood ("add" not "added")
- No trailing period
- Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- Scope: infer from file paths, omit if multi-area

## Optional User Context

$ARGUMENTS
