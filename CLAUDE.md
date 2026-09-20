# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

@AGENTS.md

macOS dotfiles managed by `rcm`. This repo is the single source of truth; `rcup` symlinks files into `~`. Edit here, never at the destination (see AGENTS.md). Run `rcup` after every change and commit.

## Commands

```bash
rcup                                    # link repo files into ~ (run after every change)
brew bundle install                     # install/upgrade Homebrew packages from Brewfile
brew bundle dump --file ~/.dotfiles/Brewfile -f   # rewrite Brewfile from installed packages
zup                                     # alias: brew upgrade zinit && zinit update --all

# Neovim (config/nvim)
stylua config/nvim                      # format Lua (stylua.toml: 2 spaces, width 160, collapse simple statements)
nvim --headless "+checkhealth" +qa      # health check
nvim "+DepsUpdate"                      # review + apply plugin updates, then :DepsSnapSave and commit mini-deps-snap
nvim --headless "+DepsUpdateOffline" +qa   # install plugins exactly as the config/snapshot says
```

Headless smoke test after nvim config changes (mini.notify swallows errors from stderr, so read its history):

```bash
nvim --headless "+lua vim.defer_fn(function() for _, n in ipairs(require('mini.notify').get_all()) do io.stderr:write(n.level .. ' ' .. n.msg .. '\n') end; vim.cmd('qa!') end, 6000)"
```

## rcm mapping

- `rcrc`: `EXCLUDES="scripts/* README.md CLAUDE.md Brewfile .claude .serena .sisyphus .git"`. Excluded files are not linked.
- Root-level `name` -> `~/.name` (`zshrc`, `gitconfig`, `vimrc`, `ripgreprc`, `claude/` -> `~/.claude/`).
- `config/<app>` -> `~/.config/<app>` (nvim, tmux, kitty, ghostty, opencode, starship.toml).
- Directories are linked file by file, so a removed repo file leaves a dangling symlink at the destination. After deleting files: `find ~/.config/<app> -type l ! -exec test -e {} \; -delete`.
- `claude/.gitignore` whitelists only `agents/`, `commands/`, `statusline.sh`, `keybindings.json`; the rest of `~/.claude` is not versioned.

## Shell (zsh)

- Load order in `zshrc`: `pathrc.zsh` -> `aliasrc.zsh` -> `zinit.zsh` -> `~/.env` (untracked secrets) -> fzf, zoxide, mise, direnv -> generated completions.
- `zinit.zsh`: plugins load in turbo mode after the first prompt; pure prompt loads synchronously. Weekly `zinit update --all` via a cache stamp. zinit itself is a Homebrew package.
- `zprofile` only runs `brew shellenv`; `pathrc.zsh` repeats it guarded for non-login shells.

## Neovim (config/nvim)

Full detail in `config/nvim/README.md`. Essentials:

- Plugin manager is **mini.deps**, not lazy.nvim. `init.lua` bootstraps `mini.nvim` (stable branch) into `pack/deps/start`, then `require`s `lua/plugins/*.lua` in an explicit order.
- Each plugin module calls `MiniDeps.add()` plus `now()` (first screen draw: colourscheme, basics, icons/statusline/notify, treesitter, sessions/starter) or `later()` (everything else). There is no event/keys/ft lazy loading; `later()` is the only staging. Anything needing `VimEnter` must be in `now()`.
- `mini-deps-snap` is the lockfile. Update flow: `:DepsUpdate` -> `:DepsSnapSave` -> commit.
- Built almost entirely on mini.nvim modules (pick, files, completion, snippets, diff, git, sessions, starter, statusline, notify, clue, etc.). Prefer a mini module over a new plugin when one exists. `mini.operators` is intentionally not used.
- Leader is `,`. Git hunk keys live under `<leader>h` (mini.diff/mini.git). `<CR>` in normal mode is mini.jump2d; quickfix restores native `<CR>` via a FileType autocmd.
- Treesitter uses the `main` branch API: `vim.treesitter.start` is called from a FileType autocmd; parsers install via the `post_install` hook and `:TSUpdate` via `post_checkout`.
- LSP: `vim.lsp.config()` per server + Mason. `utils/config_detection.lua` and `utils/project_roots.lua` decide vtsls vs denols and pick the formatter/linter (Deno/Biome/oxc/Prettier/ESLint) per buffer, so both never attach to the same file.
- Sessions: one global session per `(cwd, git branch)`, autoloaded on bare `nvim` inside `~/.dotfiles` or `~/workspace/*` (`editor.lua`).
- Comments describe current behaviour only. No before/after or migration history in comments.

## tmux (config/tmux)

- `tmux.conf` sources only `theme.conf`. `theme.conf` resets styling, sets positioning and picks the active theme; `themes/*.conf` are palette-only files that source the shared layout in `styles.conf`. Change theme by editing `theme.conf`, not `tmux.conf`.
- `prefix-r` reloads.

## Other

- `config/opencode/`: opencode config and `AGENTS.md` (same response-style rules as `~/.claude/CLAUDE.md`). Its `package.json`, lockfile and `node_modules` at the destination are generated and not rcm-managed.
- `scripts/git-clone-bare-for-worktrees.sh`: clones a repo bare into `<name>/.bare` for a sibling-worktree layout. Not linked (excluded).
- Use declarative variable names in Lua and shell.
