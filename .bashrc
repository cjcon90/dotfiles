# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
elif [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# History
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# Env
export EDITOR="nvim"
export GRIM_DEFAULT_DIR="$HOME/Pictures/screenshots"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        [ -f "$rc" ] && . "$rc"
    done
    unset rc
fi

# NVM
export NVM_DIR="$HOME/.nvm"
# Lazy-loaded: sourcing nvm.sh directly costs ~200ms on every shell start
_load_nvm() {
    unset -f nvm node npm npx corepack _load_nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}
for _cmd in nvm node npm npx corepack; do
    eval "${_cmd}() { _load_nvm; ${_cmd} \"\$@\"; }"
done
unset _cmd

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias ff='fastfetch'

# Starship prompt
command -v starship &>/dev/null && eval "$(starship init bash)"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"
