# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt share_history extended_history hist_ignore_all_dups hist_ignore_space hist_reduce_blanks hist_verify

# tmux plugin configuration (read by OMZP::tmux when zinit loads it)
export ZSH_TMUX_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_FIXTERM=false

# PATH first so every later tool resolves
source ~/.pathrc.zsh
source ~/.aliasrc.zsh
source ~/.zinit.zsh

if [ -f ~/.env ]; then
  set -a
  source ~/.env
  set +a
fi

export GPG_TTY=$(tty)

# Workaround: opencode experimental markdown renders code blocks with
# hardcoded white foreground, unreadable on light terminals (gh#16470)
export OPENCODE_EXPERIMENTAL_MARKDOWN=0

# oh-my-opencode-slim: background subagents + exa websearch
export OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS=true
export OPENCODE_ENABLE_EXA=1

source <(fzf --zsh)

eval "$(zoxide init zsh)"

# mise activation (must be after all PATH modifications)
eval "$(mise activate zsh)"

eval "$(direnv hook zsh)"

# Completions for tools that ship none in Homebrew site-functions.
# Runs after mise so mise-managed binaries resolve. Cached file is
# regenerated only when the binary is newer. compinit runs later (zinit turbo).
generated_completions_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completions"
mkdir -p "$generated_completions_dir"
fpath=("$generated_completions_dir" $fpath)
generate_completion() {
  local tool_name=$1 completion_command=$2
  local completion_file="$generated_completions_dir/_$tool_name"
  (( $+commands[$tool_name] )) || return 0
  [[ -s $completion_file && ! $commands[$tool_name] -nt $completion_file ]] && return 0
  eval "$completion_command" > "$completion_file" 2>/dev/null || rm -f "$completion_file"
}
generate_completion pnpm "pnpm completion zsh"
generate_completion bun "bun completions"
generate_completion opencode "opencode completion zsh"

