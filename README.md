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

## Brew 

To install (or upgrade) packages from your `Brewfile`, run the following
command:

```bash
brew bundle install --file ~/.dotfiles/Brewfile
```


In case you want to update your `Brewfile`, run the following command:

```bash
brew bundle dump --file ~/.dotfiles/Brewfile -f
```
