#!/usr/bin/env zsh

source $(brew --prefix)/opt/zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "catppuccin/zsh-syntax-highlighting", defer:2

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/aliases", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/mise", from:oh-my-zsh
zplug "plugins/starship", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Then, source plugins and add commands to $PATH
zplug load 
