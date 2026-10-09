# .bashrc

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
elif [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# All env, aliases, functions, and tool init live in ~/.bashrc.d/
#   01-path.sh   PATH + toolchain env (always sourced, incl. non-interactive)
#   devtools.sh  interactive-only: options, history, aliases, prompt, tool init
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*.sh; do
        [ -f "$rc" ] && . "$rc"
    done
    unset rc
fi

# Per-machine overrides (untracked)
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
