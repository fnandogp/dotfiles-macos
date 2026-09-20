# Neovim configuration

A Lua config managed by [mini.deps](https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-deps.md) and built **mostly on [mini.nvim](https://github.com/nvim-mini/mini.nvim) modules**. Targets Neovim **0.12+** (uses `vim.lsp.config()`, the treesitter `main` branch, and native `vim._extui`).

> Part of the dotfiles repo, symlinked to `~/.config/nvim` via `rcm`. Editing files here is live.

## Layout

```
config/nvim/
├── init.lua              # Entry: bootstrap mini.nvim + mini.deps, load core, require plugin modules
├── mini-deps-snap        # Plugin revision snapshot (lockfile equivalent), :DepsSnapSave / :DepsSnapLoad
└── lua/
    ├── options.lua       # Editor options, folding, diagnostics, vim._extui
    ├── keymaps.lua       # Global keymaps (leader = ",")
    ├── ft.lua            # Filetype associations (.env -> sh, *.http -> http)
    └── plugins/          # One module per concern; each calls MiniDeps.add + now()/later()
        ├── init.lua          # mini.basics (sane defaults)
        ├── colorscheme.lua   # rose-pine (active), catppuccin, dracula, gruvbox, tokyonight
        ├── ui.lua            # mini icons/statusline/notify/cursorword/cmdline/input/clue + render-markdown
        ├── treesitter.lua    # nvim-treesitter main branch, context, autotag
        ├── autocomplete.lua  # mini.completion + mini.snippets + mini.keymap
        ├── picker.lua        # mini.pick (+ extra/visits); wires vim.ui.select
        ├── file-explorer.lua # mini.files
        ├── bookmark.lua      # per-project bookmarks via mini.visits labels
        ├── coding.lua        # mini editing modules + mini.diff/mini.git + diffview + neogit
        ├── editor.lua        # mini sessions/starter/hipatterns/indentscope/bracketed/jump2d/misc + misc plugins
        ├── lsp.lua           # nvim-lspconfig + Mason + navic breadcrumbs
        ├── formatting.lua    # conform.nvim (format-on-save, config-driven)
        ├── linting.lua       # nvim-lint (config-driven JS linter choice)
        ├── terminal.lua      # toggleterm
        ├── note-taking.lua   # obsidian.nvim (work + personal vaults)
        ├── ai-assistant.lua  # neocodeium inline completion
        └── utils/            # config_detection, project_roots
```

## Plugin management (mini.deps)

- `MiniDeps.add()` registers a plugin (installs it on first launch). Plugins live in `~/.local/share/nvim/site/pack/deps/`.
- `now(fn)` runs during startup: colourscheme, mini.basics, icons/statusline/notify, treesitter, sessions/starter.
- `later(fn)` runs after startup, in order: everything else. No event/keys/ft lazy loading; `later()` is the only staging.
- `mini.nvim` itself tracks the `stable` branch; other plugins track their default branch (treesitter pinned to `main`).

```vim
:DepsUpdate            " fetch + show confirmation buffer, apply on write
:DepsUpdateOffline     " apply the snapshot / spec state without fetching
:DepsClean             " remove plugins no longer in the config
:DepsSnapSave          " write mini-deps-snap after an update you want to keep
:DepsSnapLoad          " roll back to the committed snapshot
:DepsShowLog
```

## mini.nvim-centric design

| Concern | Module | Replaces |
|---|---|---|
| Plugin manager | `mini.deps` | lazy.nvim |
| Sessions | `mini.sessions` (per cwd + git branch, see `editor.lua`) | persisted.nvim |
| Start screen | `mini.starter` | - |
| Git hunks | `mini.diff` | gitsigns.nvim |
| Git inspection | `mini.git` (`:Git`, line history) | gitsigns blame |
| Zoom | `mini.misc.zoom()` | zen-mode.nvim |
| Completion | `mini.completion` (native pum + LSP) | blink.cmp |
| Snippets | `mini.snippets` (+ friendly-snippets) | LuaSnip |
| Smart insert keys | `mini.keymap` (`map_multistep`) | blink keymaps |
| Notifications + LSP progress | `mini.notify` | noice notify + fidget |
| Cmdline tweaks | `mini.cmdline` (popup UI via `vim._extui`) | noice cmdline |
| `vim.ui.input` / `vim.ui.select` | `mini.input` / `mini.pick` | dressing.nvim |
| Pickers | `mini.pick` (+ extra/visits) | telescope |
| File explorer | `mini.files` | neo-tree/nvim-tree |
| Statusline | `mini.statusline` | lualine |
| Key hints | `mini.clue` | which-key |
| Editing | `mini.pairs/surround/comment/move/ai/bufremove/splitjoin/align/trailspace` | many |
| Navigation | `mini.bracketed`, `mini.jump2d`, `mini.indentscope` | - |
| Icons | `mini.icons` | nvim-web-devicons |

## Sessions and start screen

- Bare `nvim` inside `~/.dotfiles` or `~/workspace/*`: reads the session for `(cwd, git branch)` if one exists, otherwise starts tracking a new one and shows the start screen. Sessions are written on exit.
- Bare `nvim` elsewhere: start screen only.
- `<leader>S` selects a session. Session files: `~/.local/share/nvim/session/`.

## Completion stack

`autocomplete.lua` wires three mini modules:

- **mini.snippets** - snippet engine. Loads friendly-snippets (vscode format) per language, plus a custom `co` -> `console.log({})` snippet scoped to JS/TS.
- **mini.completion** - LSP-driven popup with bordered info/signature windows. `completeopt` is `menuone,noselect,fuzzy`.
- **mini.keymap** - multistep insert keys:
  - `<Tab>` - next snippet tabstop -> expand snippet -> next popup item
  - `<S-Tab>` - prev snippet tabstop -> prev popup item
  - `<CR>` - accept popup selection -> else newline with auto-pair handling

LSP capabilities are advertised to all servers in `lsp.lua` via `require("mini.completion").get_lsp_capabilities()`.

## LSP

- `nvim-lspconfig` + `mason.nvim` (server install) + `nvim-navic` (winbar breadcrumbs).
- Servers configured: `lua_ls`, `vtsls` (TS/JS, Node-only), `denols` (Deno-only), `graphql`.
- Deno vs Node is resolved by `utils/config_detection.lua` + `utils/project_roots.lua` so vtsls and denols never both attach.

## Key bindings

Leader = `,`

### Global (`keymaps.lua`)
| Key | Action |
|---|---|
| `<leader>w` / `<leader>W` | Write buffer / write all |
| `<leader>q` / `<leader>Q` | Quit buffer / quit all |
| `<leader>E` | Reload buffer (`:edit!`) |
| `<leader>y` / `<leader>d` / `<leader>p` | Clipboard yank / blackhole delete / paste-without-yank |
| `<C-d>` / `<C-u>` / `n` / `N` | Scroll/search, re-centred |
| `,,` / `;;` | Append `,` / `;` at end of line |
| `//` | Search for selection / word under cursor |
| `<A-j>` / `<A-k>` | Move selected lines down / up |
| `<C-M-h/j/k/l>` | Move window left/bottom/top/right |
| `<Esc>` (terminal) | Leave terminal mode |
| `q` / `Q` / `@` | Disabled (no macro record/replay; `@:` kept). `q` closes utility windows: help, man, quickfix, checkhealth, `:Git` output, notify history, deps confirm, start screen, Neogit, mini.files, Outline, diffview, grug-far, toggleterm |

### Git (`coding.lua`)
| Key | Action |
|---|---|
| `]c` / `[c` | Next / prev hunk (native diff motions inside `:diffthis`) |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk under cursor (or selection) |
| `<leader>hS` / `<leader>hR` | Stage / reset whole buffer |
| `<leader>hp` | Toggle inline hunk overlay |
| `<leader>hq` / `<leader>hQ` | Hunks of buffer / all buffers to quickfix |
| `<leader>hb` | Line history at cursor (visual: range history) |
| `<leader>hd` / `<leader>hD` | `:Git diff` of file, unstaged / staged |
| `ih` | Hunk textobject (`ghih` stages it, `gHih` resets it) |
| `<leader>g` | Neogit status |

### Navigation and editing (`editor.lua`, `coding.lua`)
| Key | Action |
|---|---|
| `<CR>` | Jump to a labelled spot (mini.jump2d); quickfix keeps its native `<CR>` |
| `]b ]q ]d ]f ]j ]l ]o ]t ]w ]x ]y` (+ `[`) | mini.bracketed targets: buffer, quickfix, diagnostic, file, jump, location, oldfile, treesitter, window, conflict, yank |
| `[i` / `]i` / `ii` / `ai` | Indent scope top / bottom / textobjects |
| `gS` | Split/join arguments or list |
| `ga` / `gA` | Align (interactive) |
| `sa` / `sd` / `sr` | Surround add / delete / replace |
| `<leader>x` | Trim trailing whitespace and blank lines |
| `<leader>z` | Zoom current buffer (toggle) |
| `<leader>S` | Select session |

### LSP (buffer-local, `lsp.lua`)
| Key | Action |
|---|---|
| `gl` | Line diagnostics float |
| `gj` / `gk` | Next / prev diagnostic |
| `<leader>ls` / `lt` / `lr` / `li` | LSP start / stop / restart / info |

Plugin-specific keymaps (pickers, mini.files, notes, terminal, etc.) live in their respective files. Press `<leader>`, `g`, `[`, `]` or `<C-w>` and `mini.clue` shows the available follow-ups.

## Managing the config

```bash
rcup                                  # sync dotfiles symlinks
nvim "+DepsUpdate"                    # review + apply plugin updates, then :DepsSnapSave and commit
nvim --headless "+DepsUpdateOffline" +qa   # install exactly what the snapshot/spec says
stylua lua/ init.lua                  # format Lua
nvim --headless "+checkhealth" +qa    # health check
```
