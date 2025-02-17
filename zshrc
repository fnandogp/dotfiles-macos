# source zplug
source ~/.zplug.zsh

source ~/.aliasrc
source ~/.pathrc

if [ -f ~/.env ]; then
  export $(cat ~/.env | xargs)
fi


# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'
