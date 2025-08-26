#!/usr/bin/env bash
set -euo pipefail
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"
echo "== Ocean Field Simulator :: Deploy =="
echo "[i] Project root: $PROJECT_ROOT"
if [ -f ".env" ]; then
  set -a; source .env; set +a
  echo "[i] Loaded .env"
fi
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
GIT_REMOTE_GH="${GIT_REMOTE_GH:-origin}"
GIT_BRANCH_PUSH="${GIT_BRANCH_PUSH:-$CURRENT_BRANCH}"
DEPLOY_ALIAS="${DEPLOY_ALIAS:-prod}"
DEPLOY_PATH="${DEPLOY_PATH:-/var/www/ocean2joy.com}"
echo "[i] GitHub remote: $GIT_REMOTE_GH, branch: $GIT_BRANCH_PUSH"
echo "[i] Server alias: $DEPLOY_ALIAS, path: $DEPLOY_PATH"
ssh-add -l >/dev/null 2>&1 && echo "[i] Keys loaded in agent:" && ssh-add -l || echo "[!] ssh-agent has no keys (will still try)."
echo "[+] Pushing to GitHub..."
git push "$GIT_REMOTE_GH" "$GIT_BRANCH_PUSH"
if [ -d "deploy" ]; then
  echo "[+] Rsync deploy/ -> $DEPLOY_ALIAS:$DEPLOY_PATH"
  rsync -az --delete --info=progress2 -e "ssh -o IdentitiesOnly=yes -F $HOME/.ssh/config"     "./deploy/" "$DEPLOY_ALIAS:$DEPLOY_PATH/"
  echo "[✓] Rsync complete."
else
  echo "[!] No deploy/ directory found. Skipping rsync step."
fi
echo "[✓] Deploy finished successfully."
