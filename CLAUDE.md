# CLAUDE.md

@AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that manages system configuration using `rcm` (RC file management). The configuration includes:

- **Neovim**: Modern Lua-based configuration with extensive plugin ecosystem
- **Zsh**: Shell configuration with plugins and custom aliases  
- **Terminal**: Kitty and Ghostty terminal configurations
- **Development Tools**: Homebrew packages, mise for runtime management
- **AI Integration**: Code Companion with MCP (Model Context Protocol) support

## Common Commands

### Package Management
```bash
# Install/update Homebrew packages
brew bundle install

# Update Brewfile with currently installed packages
brew bundle dump --file ~/.dotfiles/Brewfile -f

# Sync dotfiles (apply configuration changes)
rcup
```

### Neovim Development
```bash
# Format Lua code
stylua .

# No specific linting setup - relies on LSP diagnostics
# Test by opening Neovim and checking for errors: nvim
```

### Runtime Management (mise)
```bash
# Set global runtime versions
mise use --global node@22
mise use --global ruby@latest
mise use --global python@latest

# Run specific version ad-hoc
mise exec node@20 -- node -v
mise exec python@3.11 -- python script.py
```

## Code Architecture

### Neovim Configuration Structure
```
config/nvim/
├── init.lua                    # Entry point, lazy.nvim bootstrap
├── lua/
│   ├── options.lua            # Vim options and diagnostics config
│   ├── keymaps.lua            # Global keymaps (leader = ",")
│   ├── ft.lua                 # Filetype-specific settings
│   └── plugins/               # Plugin configurations
│       ├── init.lua           # Core plugins (neoconf, neodev, mini.basics)
│       ├── ai-assistant.lua   # Neocodeium + Code Companion + MCP
│       ├── lsp.lua            # LSP config with Mason
│       ├── autocomplete.lua   # Blink.cmp completion
│       ├── picker.lua         # mini.pick fuzzy finder
│       ├── file-explorer.lua  # Mini.files file browser
│       ├── editor.lua         # Editor enhancements
│       ├── formatting.lua     # Code formatting
│       ├── linting.lua        # Code linting
│       ├── treesitter.lua     # Syntax highlighting
│       ├── terminal.lua       # Terminal integration
│       ├── colorscheme.lua    # Theme configuration
│       ├── coding.lua         # Coding utilities
│       ├── diagnostic.lua     # Diagnostic display
│       ├── note-taking.lua    # Note-taking tools
│       ├── ui.lua             # UI enhancements
│       └── utils/             # Utility modules
```

### Key Plugin Systems

**AI Integration**:
- **Neocodeium**: AI code completion (Alt+Y to accept)
- **Code Companion**: AI chat assistant with Anthropic adapter
- **MCP Hub**: Model Context Protocol for tool integration

**LSP Configuration**:
- Uses `nvim-lspconfig` with Mason for server management
- TypeScript via `vtsls`, Lua via `lua_ls`
- Custom diagnostics with float configuration
- Navigation breadcrumbs via `nvim-navic`

**Key Keybindings**:
- Leader key: `,`
- Code Companion: `<leader>cc` (chat), `<leader>ct` (toggle), `<leader>cx` (actions), `ga` (add file)
- LSP: `gn` (rename), `gx` (code action), `gl` (diagnostics), `gj`/`gk` (next/prev diagnostic)
- File operations: `<leader>w` (save), `<leader>q` (quit)

### Dotfiles Management

**RCM Structure**:
- Root level files are symlinked to `~/.filename`
- `config/` directory maps to `~/.config/`
- Uses `rcrc` for rcm configuration
- Excludes: README.md, Brewfile, etc.

**Shell Configuration**:
- `zshrc`: Main shell config, sources modular files
- `aliasrc.zsh`: Command aliases (nvim shortcuts: `v`, `n`; navigation: `..`, `...`; workspace: `ws`, `wsd`)
- `pathrc.zsh`: PATH modifications  
- `zplug.zsh`: Plugin manager configuration
- Integrates: zplug, fzf, zoxide, starship prompt

## MCP (Model Context Protocol) Setup

The repository includes MCP integration for enhanced AI tooling:

- **mcphub.nvim**: Neovim plugin for MCP integration with Code Companion
- **Code Companion Extensions**: Automatically loads MCP tools in AI chat
- **Available Tools**: File operations, Git commands, GitHub API, web search
- **Custom Adapters**: Anthropic (primary), local Ollama models (deepseek-coder, deepseek-r1)

To enable additional MCP servers, install servers via `npm install -g mcp-hub@latest` and configure environment variables (GITHUB_TOKEN, BRAVE_API_KEY).

## Development Workflow

1. **Making Changes**: Edit configurations in the dotfiles directory
2. **Testing**: Use `rcup` to sync changes to home directory
3. **Neovim**: Restart Neovim or use `:Lazy reload` for plugin changes
4. **Version Control**: Commit changes using standard Git workflow

## Important Notes

- Neovim uses Lazy.nvim for plugin management with automatic updates
- Mason handles LSP server installations automatically  
- Code Companion is configured for Anthropic models with local Ollama fallbacks
- MCP integration requires Node.js and `npm install -g mcp-hub@latest`
- All package management is handled through Homebrew Bundle (Brewfile)
- Runtime versions are managed via `mise` (replaces asdf)

## Code Writing Guidelines

- Always use declarative variable names