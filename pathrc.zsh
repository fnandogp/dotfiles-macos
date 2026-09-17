##
## Paths
##

# Homebrew: normally already applied by ~/.zprofile (login shells);
# repeated here so non-login shells get it. Guarded to avoid fpath duplicates.
[[ -n $HOMEBREW_PREFIX ]] || eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.bun/bin"

export PATH="/usr/local/sbin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME/bin:"*) ;;
*) export PATH="$PNPM_HOME/bin:$PNPM_HOME:$PATH" ;;
esac
