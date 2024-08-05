eval "$(starship init zsh)"

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias vim="vim -u DEFAULTS"
alias n="nvim"

alias ws="cd $HOME/workspace"
alias wsc="cd $HOME/workspace/convincely"
alias wsd="cd $HOME/.dotfiles"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# pnpm
export PNPM_HOME="/Users/fnandogp/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# mise
source ~/.miserc 
export PATH="$(brew --prefix)/mise/shims:$PATH"
