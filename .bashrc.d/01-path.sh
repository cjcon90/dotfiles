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
# Newest nvm Node, so npm works without loading nvm (e.g. for nvim's Mason)
for _p in "$HOME"/.nvm/versions/node/v*/bin; do :; done
[ -d "$_p" ] && case ":$PATH:" in *":$_p:"*) ;; *) PATH="$_p:$PATH" ;; esac
unset _p
export PATH

# Rust (installer-provided env script; idempotent)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"
export GRIM_DEFAULT_DIR="$HOME/Pictures/screenshots"
