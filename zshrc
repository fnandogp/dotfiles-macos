# tmux plugin configuration
export ZSH_TMUX_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_FIXTERM=false

# source zinit
source ~/.zinit.zsh

source ~/.aliasrc.zsh
source ~/.pathrc.zsh

if [ -f ~/.env ]; then
  export $(cat ~/.env | grep -v '^#' | xargs)
fi

export GPG_TTY=$(tty)

source <(fzf --zsh)

# mise activation (must be after all PATH modifications)
eval "$(mise activate zsh)"
