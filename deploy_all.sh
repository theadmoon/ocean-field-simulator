#!/bin/bash
set -e

echo "=== Ocean Field Simulator :: Full Release Deploy ==="

# [1] Start SSH agent and add keys
echo "[1] Starting SSH agent and adding keys..."
eval $(ssh-agent -s)
ssh-add ~/.ssh/github_key
ssh-add ~/.ssh/developer1_fullkey

# [2] Checking GitHub
echo "[2] Checking GitHub connection..."
ssh -T github || true

# [3] Checking Production server
echo "[3] Checking Production server connection..."
ssh prod "echo Production server reachable"

# [4] Commit changes
echo "[4] Creating commit..."
git add -A
git commit -m "Release $(date +%Y-%m-%d_%H%M)" || true

# [5] Update deploy log
echo "[5] Updating deploy log..."
echo "- Release $(date +%Y-%m-%d_%H%M)" >> docs/README_DEPLOY.md
git add docs/README_DEPLOY.md
git commit -m "Update deploy log for v$(date +%Y.%m.%d_%H%M)" || true

# [6] Push changes
echo "[6] Pushing commit + tags to GitHub..."
git push origin main
git push origin --tags

# [7] Deploy to Production
echo "[7] Deploying to Production..."
./scripts/deploy.sh
