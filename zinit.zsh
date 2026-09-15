source /opt/homebrew/opt/zinit/zinit.zsh

# Turbo mode: everything below loads after the first prompt.
# nocd: do not chdir into the plugin dir while running ices (pure would flash the path).
zinit wait lucid nocd for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit cclear; zinit creinstall -q .' \
        zsh-users/zsh-completions

# History substring search on arrow keys (both normal and application cursor modes)
zinit wait lucid nocd for \
    atload"bindkey '^[[A' history-substring-search-up; bindkey '^[OA' history-substring-search-up; bindkey '^[[B' history-substring-search-down; bindkey '^[OB' history-substring-search-down" \
        zsh-users/zsh-history-substring-search

# Oh-my-zsh snippets
zinit wait lucid nocd for \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::aliases \
    OMZP::brew \
    OMZP::common-aliases \
    OMZP::command-not-found \
    OMZP::tmux

# Pure prompt (loaded synchronously so the first prompt is already styled)
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Weekly plugin update, run on the first interactive shell once the stamp is
# older than 7 days. Foreground so atpull hooks run and errors are visible.
# zinit itself is updated by Homebrew (brew upgrade zinit), not self-update.
zinit_update_stamp="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zinit-last-update"
zinit_stale_stamp=( ${~zinit_update_stamp}(N.mw+1) )
if [[ ! -f $zinit_update_stamp || -n $zinit_stale_stamp ]]; then
  mkdir -p "${zinit_update_stamp:h}"
  zinit update --all -q && touch "$zinit_update_stamp"
fi
unset zinit_update_stamp zinit_stale_stamp

# Completion behaviour
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
