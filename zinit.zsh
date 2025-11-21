#!/usr/bin/env zsh

# Initialize zinit
source /opt/homebrew/opt/zinit/zinit.zsh

# Essential plugins for better performance
zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# History substring search
zinit wait lucid for \
    zsh-users/zsh-history-substring-search

# Oh-my-zsh plugins (lightweight loading)
zinit wait lucid for \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::aliases \
    OMZP::brew \
    OMZP::common-aliases \
    OMZP::command-not-found

# Pure prompt theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
