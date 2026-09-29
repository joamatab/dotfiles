#!/bin/sh
# Resolve the symlinked Karabiner directory back to this dotfiles checkout.
directory=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) || exit 1
exec /usr/bin/python3 "$directory/../scripts/clipboard_cleanup.py" "$@"
