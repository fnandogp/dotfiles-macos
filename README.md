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
`.dotfiles`.

```bash
git clone git@github.com:fnandogp/dotfiles-macos.git ~/.dotfiles
// OR
git clone https://github.com:fnandogp/dotfiles-macos.git ~/.dotfiles
```

Install the [rcm](https://github.com/thoughtbot/rcm)

```bash
brew tap thoughtbot/formulae

brew install thoughtbot/formulae/rcm
```

Sync your dotfiles

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
