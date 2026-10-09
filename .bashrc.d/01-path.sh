# ── PATH ──────────────────────────────────────────────────────────────────────
# Make sure the standard system dirs are present (non-login shells, e.g.
# `pct enter` into an LXC container, can inherit a PATH missing /usr/local/bin
# etc), without clobbering anything the system profile already added
# (e.g. /opt/... from /etc/profile.d).
for _p in /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin; do
    case ":$PATH:" in *":$_p:"*) ;; *) PATH="${PATH:+$PATH:}$_p" ;; esac
done

# User paths, prepended once
export GOPATH="$HOME/go"
for _p in "$GOPATH/bin" "$HOME/bin" "$HOME/.local/bin"; do
    case ":$PATH:" in *":$_p:"*) ;; *) PATH="$_p:$PATH" ;; esac
done
unset _p
export PATH

# Rust / Atuin (installer-provided env scripts; idempotent)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"
export GRIM_DEFAULT_DIR="$HOME/Pictures/screenshots"
