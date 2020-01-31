# Dotfiles (Mac OS)
My Mac OS dotfiles

## Download

Clone the project and place it on your home directory under the name
`.dotfiles`.

```bash
git clone git@github.com:fnandogp/dotfiles-macos.git ~/.dotfiles
```

## Requirements

Install the [rcm](https://github.com/thoughtbot/rcm)

```bash
brew tap thoughtbot/formulae

brew install thoughtbot/formulae/rcm
```

## Sync

Sync your dotfiles

```bash
rcup
```

## VIM / NEOVIM

Apart from placing every dotfile in the correct places, some other
configurations are require.

Simply open you `nvim` and it will download every needed plugin.

### CoC Extenstions

Some extension need to be installed manually.

Open your `nvim` and execute the following command for each one of the
extensions.

```
:CocInstall <extension>

# e.g. :CocInstall coc-ultisnips
```

List of extensions used:
```
coc-css
coc-git
coc-highlight
coc-html
coc-json
coc-lists
coc-pairs
coc-phpls
coc-python
coc-snippets
coc-tailwindcss
coc-tsserver
coc-ultisnips
coc-yank
```
