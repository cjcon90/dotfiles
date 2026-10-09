# Interactive shells only (01-path.sh still runs for non-interactive ones)
[[ $- == *i* ]] || return 0

# ── Shell options ─────────────────────────────────────────────────────────────
shopt -s globstar    # ** recursive globs
shopt -s autocd      # type a dir name to cd into it
shopt -s checkwinsize
shopt -s histappend

# ── History ───────────────────────────────────────────────────────────────────
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=100000
HISTTIMEFORMAT="%F %T  "

# ── Environment ───────────────────────────────────────────────────────────────
if command -v bat &>/dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # bat-powered man pages
    export BAT_THEME="Dracula"
fi

# ── Aliases: navigation ───────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ── Aliases: modern replacements ──────────────────────────────────────────────
if command -v eza &>/dev/null; then
    alias ls='eza --color=auto --group-directories-first --icons'
    alias ll='eza -lah --git --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons'
    alias lta='eza --tree --level=3 -a --icons'
    alias tree='eza --tree'
else
    alias ls='ls --color=auto'
fi
command -v bat &>/dev/null && alias cat='bat --pager=never'
alias grep='grep --color=auto'
alias vim='nvim'
alias ff='fastfetch'

# ── Aliases: git ──────────────────────────────────────────────────────────────
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

# ── Aliases: docker ───────────────────────────────────────────────────────────
alias dps='docker ps'
alias dlog='docker logs -f'
alias dex='docker exec -it'

# ── NVM (lazy-loaded: sourcing nvm.sh directly costs ~200ms per shell) ────────
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    _load_nvm() {
        unset -f nvm node npm npx corepack _load_nvm
        . "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    }
    for _cmd in nvm node npm npx corepack; do
        eval "${_cmd}() { _load_nvm; ${_cmd} \"\$@\"; }"
    done
    unset _cmd
fi

# ── fzf (Ctrl+R history, Ctrl+T file picker) ──────────────────────────────────
if command -v fzf &>/dev/null; then
    eval "$(fzf --bash)"
    export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --info=inline"
    if command -v rg &>/dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
fi

# ── zoxide (smart cd) ─────────────────────────────────────────────────────────
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"

# ── Starship prompt ───────────────────────────────────────────────────────────
command -v starship &>/dev/null && eval "$(starship init bash)"

# ── Atuin (better shell history; after fzf so it owns Ctrl+R) ─────────────────
# install: curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
command -v atuin &>/dev/null && eval "$(atuin init bash)"
