# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
# (cargo/atuin env are sourced from ~/.bashrc.d/01-path.sh)

# Per-machine overrides (untracked)
[ -f ~/.bash_profile.local ] && . ~/.bash_profile.local
