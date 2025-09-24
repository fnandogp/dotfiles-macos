# source zinit
source ~/.zinit.zsh

source ~/.aliasrc.zsh
source ~/.pathrc.zsh

if [ -f ~/.env ]; then
  export $(cat ~/.env | grep -v '^#' | xargs)
fi

export GPG_TTY=$(tty)

source <(fzf --zsh)
