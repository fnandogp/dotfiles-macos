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
  set -a
  source ~/.env
  set +a
fi

export GPG_TTY=$(tty)

# Workaround: opencode experimental markdown renders code blocks with
# hardcoded white foreground, unreadable on light terminals (gh#16470)
export OPENCODE_EXPERIMENTAL_MARKDOWN=0

source <(fzf --zsh)

# mise activation (must be after all PATH modifications)
eval "$(mise activate zsh)"

eval "$(direnv hook zsh)"
