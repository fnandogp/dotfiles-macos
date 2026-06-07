# Neovim configuration

A Lua, [lazy.nvim](https://github.com/folke/lazy.nvim)-managed config built **mostly on [mini.nvim](https://github.com/nvim-mini/mini.nvim) modules**. Targets Neovim **0.12+** (uses `vim.lsp.config()`, the treesitter `main` branch, and native `vim._extui`).

> Part of the dotfiles repo, symlinked to `~/.config/nvim` via `rcm`. Editing files here is live.

## Layout

```
config/nvim/
├── init.lua              # Entry: bootstrap lazy.nvim, load core, import lua/plugins/
└── lua/
    ├── options.lua       # Editor options, folding, diagnostics, vim._extui
    ├── keymaps.lua       # Global keymaps (leader = ",")
    ├── ft.lua            # Filetype associations (.env -> sh, *.http -> http)
    └── plugins/          # One file per concern; lazy.nvim imports the dir
        ├── init.lua          # neoconf, neodev, mini.basics (sane defaults)
        ├── lsp.lua           # nvim-lspconfig + Mason + navic breadcrumbs
        ├── autocomplete.lua  # mini.completion + mini.snippets + mini.keymap
        ├── coding.lua        # mini editing (pairs/surround/comment/move/ai) + git
        ├── formatting.lua    # conform.nvim (format-on-save, config-driven)
        ├── linting.lua       # nvim-lint (config-driven JS linter choice)
        ├── ui.lua            # mini statusline/notify/cmdline/input/clue + markdown
        ├── editor.lua        # editor enhancements (sessions, folds, search, zen...)
        ├── picker.lua        # mini.pick (+ extra/visits); wires vim.ui.select
        ├── file-explorer.lua # mini.files
        ├── treesitter.lua    # syntax (nvim-treesitter main branch)
        ├── colorscheme.lua   # catppuccin (configured) + rose-pine (active)
        ├── diagnostic.lua    # placeholder (config lives in options.lua)
        ├── terminal.lua      # toggleterm
        ├── note-taking.lua   # obsidian.nvim (work + personal vaults)
        ├── bookmark.lua      # per-project bookmarks via mini.visits labels
        ├── ai-assistant.lua  # neocodeium inline completion
        └── utils/            # config_detection, project_roots, ai-assistant helpers
```

## mini.nvim-centric design

This config deliberately leans on mini.nvim instead of larger single-purpose plugins.

| Concern | Module | Replaces |
|---|---|---|
| Completion | `mini.completion` (native pum + LSP) | blink.cmp |
| Snippets | `mini.snippets` (+ friendly-snippets) | LuaSnip |
| Smart insert keys | `mini.keymap` (`map_multistep`) | blink keymaps |
| Notifications + LSP progress | `mini.notify` | noice notify + fidget |
| Cmdline tweaks | `mini.cmdline` (popup UI via `vim._extui`) | noice cmdline |
| `vim.ui.input` | `mini.input` | dressing.nvim |
| `vim.ui.select` | `mini.pick` (`MiniPick.ui_select`) | dressing.nvim |
| Pickers | `mini.pick` (+ extra/visits) | telescope |
| File explorer | `mini.files` | neo-tree/nvim-tree |
| Statusline | `mini.statusline` | lualine |
| Key hints | `mini.clue` | which-key |
| Editing | `mini.pairs/surround/comment/move/ai/bufremove` | many |
| Icons | `mini.icons` | nvim-web-devicons |

## Completion stack

`autocomplete.lua` wires three mini modules:

- **mini.snippets** - snippet engine. Loads friendly-snippets (vscode format) per language, plus a custom `co` -> `console.log({})` snippet scoped to JS/TS.
- **mini.completion** - LSP-driven popup with bordered info/signature windows. `completeopt` is `menuone,noselect,fuzzy` (fuzzy is appended after mini.basics sets the base).
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

### LSP (buffer-local, `lsp.lua`)
| Key | Action |
|---|---|
| `gl` | Line diagnostics float |
| `gj` / `gk` | Next / prev diagnostic |
| `<leader>ls` / `lt` / `lr` | LSP start / stop / restart |

Plugin-specific keymaps (pickers, mini.files, git, AI, etc.) live in their respective files. Press `<leader>`, `g`, or `<C-w>` and `mini.clue` shows the available follow-ups.

## Managing the config

```bash
rcup                         # sync dotfiles symlinks
nvim "+Lazy sync" +qa        # update/install/clean plugins
stylua lua/                  # format Lua
nvim --headless "+checkhealth" +qa   # health check
```

Plugins update automatically (`checker.enabled = true` in `init.lua`).
