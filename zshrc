source $(brew --prefix)/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle docker
antigen bundle yarn
antigen bundle npm
antigen bundle brew

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle popstas/zsh-command-time
#antigen bundle ntnyq/omz-plugin-pnpm
antigen bundle baliestri/pnpm.plugin.zsh@main

# Load the theme.
antigen theme candy

# source custom files
source ~/.pathrc
source ~/.aliasrc

export EDITOR=$(which nano)

# Tell Antigen that you're done.
antigen apply
