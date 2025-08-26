#!/usr/bin/env bash
set -e
echo "[+] Fixing SSH key permissions and starting ssh-agent..."
HOME="${HOME:-$USERPROFILE}"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh" 2>/dev/null || true
for f in "$HOME/.ssh/"*; do
  [ -e "$f" ] || continue
  base="$(basename "$f")"
  case "$base" in
    *.pub|known_hosts*|config) chmod 644 "$f" 2>/dev/null || true ;;
    *) chmod 600 "$f" 2>/dev/null || true ;;
  esac
done
[ -f "$HOME/.ssh/config" ] && chmod 600 "$HOME/.ssh/config" 2>/dev/null || true
if ! pgrep -u "$USER" ssh-agent >/dev/null 2>&1; then
  eval "$(ssh-agent -s)"
else
  eval "$(ssh-agent -s)" >/dev/null 2>&1 || true
fi
for key in "$HOME/.ssh/github_key" "$HOME/.ssh/developer1_fullkey" "$HOME/.ssh/id_ed25519" "$HOME/.ssh/id_rsa"; do
  if [ -f "$key" ]; then
    echo "[+] Adding key: $key"
    ssh-add "$key" || true
  fi
done
echo "[+] SSH setup complete."
