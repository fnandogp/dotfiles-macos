# source zplug
source ~/.zplug.zsh

source ~/.aliasrc
source ~/.pathrc

if [ -f ~/.env ]; then
  export $(cat ~/.env | xargs)
fi

