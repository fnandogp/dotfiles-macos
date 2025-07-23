# Dotfiles (Mac OS)

My Mac OS dotfiles

## Installation

First of all, install [Homebrew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

And then, manually install Git (not installed by default):

```bash
brew install git
```

Clone the project and place it on your home directory under the name
`.dotfiles`:

```bash
git clone git@github.com:fnandogp/dotfiles-macos.git ~/.dotfiles
# OR
git clone https://github.com/fnandogp/dotfiles-macos.git ~/.dotfiles
```

Install the [rcm](https://github.com/thoughtbot/rcm)

```bash
brew tap thoughtbot/formulae
brew install thoughtbot/formulae/rcm
```

Sync your dotfiles:

```bash
rcup
```

To install (or upgrade) packages from your `Brewfile`, run the following
command:

```bash
brew bundle install
```

In case you want to update your `Brewfile`, run the following command:

```bash
brew bundle dump --file ~/.dotfiles/Brewfile -f
```

## Runtime Management with mise

Install [mise](https://mise.jdx.dev/) for managing runtime versions:

```bash
curl https://mise.run | sh
```

Set global runtime versions:

```bash
# Set common runtimes
mise use --global node@22
mise use --global ruby@latest
mise use --global python@latest

# Run specific versions when needed
mise exec node@20 -- node -v
mise exec python@3.11 -- python script.py
```

## Features

This dotfiles setup includes:

- **Neovim**: Modern Lua configuration with AI integration (Code Companion, Neocodeium)
- **Terminal**: Kitty and Ghostty configurations
- **Shell**: Zsh with plugins (fzf, zoxide, starship prompt)
- **AI Tools**: MCP (Model Context Protocol) integration for enhanced development
