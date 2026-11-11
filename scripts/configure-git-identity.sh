#!/usr/bin/env bash
set -e

basedir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
identity_file="$HOME/.gitconfig.local"
mode=${DOTFILES_IDENTITY:-}
name=${DOTFILES_GIT_NAME:-}
email=${DOTFILES_GIT_EMAIL:-}

if [ -z "$mode$name$email" ]; then
  # Preserve a previous choice, including identities configured before dotfiles.
  name=$(git config --file "$identity_file" user.name 2>/dev/null || true)
  email=$(git config --file "$identity_file" user.email 2>/dev/null || true)
  if [ -z "$name" ] || [ -z "$email" ]; then
    name=$(git config --global --includes user.name || true)
    email=$(git config --global --includes user.email || true)
  fi
  if [ -n "$name" ] && [ -n "$email" ]; then
    mode=custom
  fi
fi

if [ -z "$mode$name$email" ]; then
  while true; do
    if ! read -r -p "Use Joaquin's Git name and email? [y/N] " answer; then
      echo "No identity selected. Set DOTFILES_IDENTITY=joaquin or DOTFILES_GIT_NAME and DOTFILES_GIT_EMAIL for unattended installs." >&2
      exit 1
    fi
    case "$answer" in
      y|Y|yes|Yes|YES) mode=joaquin; break ;;
      n|N|no|No|NO|'') mode=custom; break ;;
      *) echo "Please answer yes or no." ;;
    esac
  done
fi

case "$mode" in
  joaquin)
    name=$(git config --file "$basedir/gitconfig" user.name)
    email=$(git config --file "$basedir/gitconfig" user.email)
    ;;
  custom|'')
    while [[ ! "$name" =~ [^[:space:]] ]]; do
      if ! read -r -p "Git full name: " name; then
        echo "A Git name is required." >&2
        exit 1
      fi
    done
    while [[ ! "$email" =~ [^[:space:]] ]]; do
      if ! read -r -p "Git email: " email; then
        echo "A Git email is required." >&2
        exit 1
      fi
    done
    ;;
  *) echo "DOTFILES_IDENTITY must be joaquin or custom." >&2; exit 1 ;;
esac

git config --file "$identity_file" user.name "$name"
git config --file "$identity_file" user.email "$email"
echo "==> Git identity: $name <$email> (saved in $identity_file)"
