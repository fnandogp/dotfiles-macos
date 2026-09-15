##
## Aliases
##

# Common
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

# OpenCode v2 (separate config dir to avoid v1/v2 config shape conflicts)
alias c2='OPENCODE_CONFIG_DIR="$HOME/.config/opencode2" opencode2'


# Update zinit (via Homebrew) and all plugins now
alias zup='brew upgrade zinit && zinit update --all'
