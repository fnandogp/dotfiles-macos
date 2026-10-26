# CLAUDE.md

@AGENTS.md

macOS dotfiles managed by `rcm`. This repo is the single source of truth; `rcup` symlinks files into `~`. Edit here, never at the destination. Run `rcup` after every change and commit.

## Project map

- Root-level `name` -> `~/.name` (`zshrc`, `zprofile`, `gitconfig`, `vimrc`, `ripgreprc`, `rcrc`)
- `config/<app>` -> `~/.config/<app>` (nvim, tmux, kitty, ghostty, opencode, starship.toml)
- `scripts/` - helper scripts, not linked (`git-clone-bare-for-worktrees.sh`: bare clone into `<name>/.bare` for sibling worktrees)
- `Brewfile` - Homebrew packages, not linked
- `rcrc` `EXCLUDES="claude scripts/* README.md CLAUDE.md Brewfile .claude .serena .sisyphus .git"` - excluded files are not linked
- `~/.claude` is not managed here (lives in another project)

<important if="you need to run commands to link, install packages, format, update plugins or check health">

| Command | What it does |
|---|---|
| `rcup` | Link repo files into `~` (run after every change) |
| `brew bundle install` | Install/upgrade Homebrew packages from Brewfile |
| `brew bundle dump --file ~/.dotfiles/Brewfile -f` | Rewrite Brewfile from installed packages |
| `zup` | Alias: `brew upgrade zinit && zinit update --all` |
| `stylua config/nvim` | Format Lua |
| `nvim --headless "+checkhealth" +qa` | Neovim health check |
| `nvim "+DepsUpdate"` | Review + apply plugin updates, then `:DepsSnapSave` and commit `mini-deps-snap` |
| `nvim --headless "+DepsUpdateOffline" +qa` | Install plugins exactly as config/snapshot says |

</important>

<important if="you changed Neovim config and need to verify it loads without errors">

mini.notify swallows errors from stderr, so read its history:

```bash
nvim --headless "+lua vim.defer_fn(function() for _, n in ipairs(require('mini.notify').get_all()) do io.stderr:write(n.level .. ' ' .. n.msg .. '\n') end; vim.cmd('qa!') end, 6000)"
```

</important>

<important if="you are deleting or renaming files under config/">
- Directories are linked file by file, so a removed repo file leaves a dangling symlink
- After deleting: `find ~/.config/<app> -type l ! -exec test -e {} \; -delete`
</important>

<important if="you are writing or editing comments">
- Comments describe current behaviour only. No before/after or migration history
</important>

<important if="you are naming variables in Lua or shell">
- Use declarative variable names
</important>

<important if="you are working on zsh config (zshrc, zprofile, *.zsh)">

- Load order in `zshrc`: `pathrc.zsh` -> `aliasrc.zsh` -> `zinit.zsh` -> `~/.env` (untracked secrets) -> fzf, zoxide, mise, direnv -> generated completions
- `zinit.zsh`: plugins load in turbo mode after first prompt; starship prompt (`config/starship.toml`) loads synchronously. Weekly `zinit update --all` via cache stamp. zinit itself is a Homebrew package
- `zprofile` only runs `brew shellenv`; `pathrc.zsh` repeats it guarded for non-login shells

</important>

<important if="you are working on Neovim config (config/nvim)">

Full detail in `config/nvim/README.md`.

- Plugin manager is **mini.deps**, not lazy.nvim. `init.lua` bootstraps `mini.nvim` (stable branch) into `pack/deps/start`, then `require`s `lua/plugins/*.lua` in explicit order
- Each plugin module calls `MiniDeps.add()` plus `now()` (first screen draw: colourscheme, basics, icons/statusline/notify, treesitter, sessions/starter) or `later()` (everything else). No event/keys/ft lazy loading. Anything needing `VimEnter` must be in `now()`
- `mini-deps-snap` is the lockfile
- Prefer a mini.nvim module over a new plugin when one exists. `mini.operators` intentionally not used
- Leader is `,`. Git hunk keys under `<leader>h` (mini.diff/mini.git). Normal-mode `<CR>` is mini.jump2d; quickfix restores native `<CR>` via FileType autocmd
- Treesitter uses `main` branch API: `vim.treesitter.start` from a FileType autocmd; parsers install via `post_install` hook, `:TSUpdate` via `post_checkout`
- LSP: `vim.lsp.config()` per server + Mason. `utils/config_detection.lua` and `utils/project_roots.lua` pick vtsls vs denols and the formatter/linter (Deno/Biome/oxc/Prettier/ESLint) per buffer, so both never attach to the same file
- Sessions: one global session per `(cwd, git branch)`, autoloaded on bare `nvim` inside `~/.dotfiles` or `~/workspace/*` (`editor.lua`)

</important>

<important if="you are working on tmux config (config/tmux)">

- `tmux.conf` sources only `theme.conf`. `theme.conf` resets styling, sets positioning, picks the active theme
- `themes/*.conf` are palette-only and source the shared layout in `styles.conf`
- Change theme in `theme.conf`, not `tmux.conf`
- `prefix-r` reloads

</important>

<important if="you are working on opencode config (config/opencode)">
- `AGENTS.md` there holds the same response-style rules as `~/.claude/CLAUDE.md`
- `package.json`, lockfile and `node_modules` at the destination are generated, not rcm-managed
</important>
