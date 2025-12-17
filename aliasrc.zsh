##
## Aliases
##

# Common
alias s="sudo"
alias vim="vim -u DEFAULTS"
alias n="nvim"

alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'='cd ../../..'
alias '.....'='cd ../../../..'

alias nn="cd ~/Documents/Vaults/ && nvim ~/Documents/Vaults/"
alias nnp="cd ~/Documents/Vaults/Personal/ && nvim ~/Documents/Vaults/Personal/"
alias nnw="cd ~/Documents/Vaults/Work/ && nvim ~/Documents/Vaults/Work/"

alias ws="cd $HOME/workspace"
alias wsd="cd $HOME/.dotfiles"

#alias yarn="corepack yarn"
#alias yarnpkg="corepack yarnpkg"
#alias pnpm="corepack pnpm"
#alias pnpx="corepack pnpx"
#alias npm="corepack npm"
#alias npx="corepack npx"

alias rg="rg --hidden"
alias fd="fd --hidden"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'


# pnpm
export PNPM_HOME="/Users/fernando-dotcollective/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

