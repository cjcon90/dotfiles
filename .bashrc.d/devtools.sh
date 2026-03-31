# ── Shell options ─────────────────────────────────────────────────────────────
shopt -s globstar    # ** recursive globs
shopt -s autocd      # type a dir name to cd into it
shopt -s checkwinsize
shopt -s histappend

# ── History ───────────────────────────────────────────────────────────────────
HISTCONTROL=ignoredups:erasedups
HISTSIZE=50000
HISTFILESIZE=100000
HISTTIMEFORMAT="%F %T  "
# Append to history after every command (shared across sessions)
PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # bat-powered man pages
export BAT_THEME="Dracula"

# ── Aliases: navigation ───────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ── Aliases: modern replacements ──────────────────────────────────────────────
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'
alias lta='eza --tree --icons --level=3 -a'
alias cat='bat --pager=never'
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

# ── fzf ───────────────────────────────────────────────────────────────────────
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash
[ -f /usr/share/fzf/shell/completion.bash ]   && source /usr/share/fzf/shell/completion.bash

export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --info=inline"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ── zoxide (smart cd) ─────────────────────────────────────────────────────────
eval "$(zoxide init bash)"

# ── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init bash)"
