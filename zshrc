source ~/.antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle git-flow
antigen bundle docker
antigen bundle yarn
antigen bundle npm
antigen bundle composer
antigen bundle aws
antigen bundle brew

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle popstas/zsh-command-time
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme avit

# Defaults
export EDITOR=/usr/bin/vim
export TERM=xterm-256color

# source custom files
source ~/.pathrc
source ~/.aliasrc

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Tell Antigen that you're done.
antigen apply
