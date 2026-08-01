# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
elif [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Base PATH — set explicitly rather than trusting the inherited environment.
# Non-login shells (e.g. `pct enter` into an LXC container) can inherit a
# PATH missing /usr/local/bin etc; .bashrc.d/01-path.sh layers user paths
# ($HOME/.local/bin, $HOME/bin, $GOPATH/bin) on top of this safe baseline.
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

# All env, aliases, functions, and tool init live in ~/.bashrc.d/
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        [ -f "$rc" ] && . "$rc"
    done
    unset rc
fi
