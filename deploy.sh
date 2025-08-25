#!/usr/bin/env bash
set -e

SSH_KEY="$HOME/.ssh/developer1_fullkey"
TARGET="developer1@ocean2joy.com"
DEST="/var/www/ocean2joy.com"

echo "▶ Starting Ocean2Joy deployment..."
echo "▶ Target: $TARGET → $DEST"

echo "▶ Testing SSH connection..."
ssh -i "$SSH_KEY" "$TARGET" "echo 'SSH connection OK'"

echo "▶ Cleaning target directory on server..."
ssh -i "$SSH_KEY" "$TARGET" "rm -rf $DEST/*"

echo "▶ Copying via rsync..."
rsync -avz -e "ssh -i $SSH_KEY" ./ "$TARGET:$DEST/"     --exclude ".git"     --exclude ".idea"     --exclude ".vscode"     --exclude "node_modules"     --exclude "*.log"     --exclude "*.zip"

echo "✅ Deploy finished successfully!"
