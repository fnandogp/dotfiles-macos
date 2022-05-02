source $(brew --prefix)/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle git-flow
antigen bundle docker
antigen bundle yarn
antigen bundle npm
antigen bundle aws
antigen bundle brew

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle popstas/zsh-command-time

# Load the theme.
antigen theme af-magic

# source custom files
source ~/.pathrc
source ~/.aliasrc

export EDITOR=$(which nano)

# Tell Antigen that you're done.
antigen apply
