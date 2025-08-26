#!/bin/bash
set -e

echo "=== Ocean Field Simulator :: Deploy ==="

# [1] Starting deploy...
echo "[1] Starting deploy to server..."
TARGET="prod:/var/www/ocean2joy.com"

rsync -az --delete \
  --exclude ".git" \
  --exclude "docs" \
  --exclude "scripts" \
  ./ $TARGET

echo "[✓] Deploy completed successfully!"
