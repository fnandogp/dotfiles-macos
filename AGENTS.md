# AGENTS.md

Guidance for AI agents working in this repository.

## Single source of truth

This repo (~/.dotfiles) is the single source of truth for all configuration. Files are symlinked to their destinations via rcm (rcup).

## Edit rules

- Never edit files at their destination paths (e.g. ~/.config/opencode/, ~/.zshrc)
- Always edit the repo copy instead:
  - ~/.config/opencode/* -> config/opencode/*
  - ~/.config/<app>/* -> config/<app>/*
  - ~/.* (root-level dotfiles) -> <name>
- Read files from this folder too, not from the symlinked destination
- Never read destination-only files either (e.g. ~/.config/opencode/package.json, package-lock.json, node_modules - generated, not rcm-managed). Ask the user if that info is needed

## Why

- User works exclusively from this folder
- Editing destination paths hides intent and risks breaking the rcm structure (rcrc exclusions, non-symlinked files like README.md and Brewfile)

## After changes - every task, no exceptions

- rcm is core: always use `rcup` for linking
- Run `rcup` after every change to ensure links exist and point at the repo
- Never finish a task without running `rcup`
- Commit changes with standard Git workflow
