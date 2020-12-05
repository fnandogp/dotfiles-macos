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
// OR
git clone https://github.com:fnandogp/dotfiles-macos.git ~/.dotfiles
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

## ASDF

To install runtime versions:

```bash
# Node
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
asdf install nodejs latest:12
asdf list nodejs
asdf global nodejs 12.x.x # replace it with you current installed version

# Ruby
asdf plugin add ruby
asdf install ruby latest
asdf list ruby
asdf global ruby 2.x.x # replace it with you current installed version

# Python
asdf plugin add python
asdf install python latest:3
asdf install python latest:2
asdf list python
asdf global python 3.x.x 2.7.x # replace it with you current installed version

# PHP
asdf plugin add php https://github.com/asdf-community/asdf-php.git
asdf list php
PHP_WITHOUT_PEAR=yes asdf install php <versions>

# Java
asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf list java
asdf install java latest:openjdk-10
adsf global java openjdk-10x # replace it with you current installed version

```
