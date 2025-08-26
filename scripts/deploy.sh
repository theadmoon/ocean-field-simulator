#!/bin/bash
set -e

echo "=== Ocean Field Simulator :: Deploy ==="

# [1] Start SSH agent and add keys
echo "[1] Starting SSH agent..."
eval $(ssh-agent -s)

ssh-add ~/.ssh/github_key
ssh-add ~/.ssh/developer1_fullkey

# [2] Checking GitHub connection
echo "[2] Checking GitHub connection..."
if ssh -T github 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ GitHub auth OK"
else
    echo "❌ GitHub auth FAILED"
    exit 1
fi

# [3] Deploy to Production
echo "[3] Deploying to Production..."
TARGET="prod:/var/www/ocean2joy.com"

rsync -az --delete \
  --exclude ".git" \
  --exclude "docs" \
  --exclude "scripts" \
  ./ $TARGET

echo "✅ Deploy completed successfully"
