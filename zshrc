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

# oh-my-opencode-slim: background subagents + exa websearch
export OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS=true
export OPENCODE_ENABLE_EXA=1

source <(fzf --zsh)

# mise activation (must be after all PATH modifications)
eval "$(mise activate zsh)"

eval "$(direnv hook zsh)"

# pnpm
export PNPM_HOME="/Users/fernando-dotcollective/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
