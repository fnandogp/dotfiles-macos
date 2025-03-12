# source zplug
source ~/.zplug.zsh

source ~/.aliasrc
source ~/.pathrc

if [ -f ~/.env ]; then
  export $(cat ~/.env | xargs)
fi


# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# pnpm
export PNPM_HOME="/Users/fernando-dotcollective/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
