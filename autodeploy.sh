#!/usr/bin/env bash
set -e

SSH_KEY="$HOME/.ssh/developer1_fullkey"
TARGET="developer1@ocean2joy.com"
DEST="/var/www/ocean2joy.com"

DATE=$(date +"%Y-%m-%d_%H-%M")
ARCHIVE="ocean-field-simulator_${DATE}.zip"

echo "▶ Creating archive: $ARCHIVE"
zip -r "$ARCHIVE" . -x "*.git*" -x "*.idea*" -x "*.vscode*" -x "*.DS_Store" -x "node_modules/*"

echo "▶ Uploading archive to server..."
scp -i "$SSH_KEY" "$ARCHIVE" "$TARGET:$DEST/"

echo "▶ Extracting on server..."
ssh -i "$SSH_KEY" "$TARGET" "cd $DEST && unzip -o $ARCHIVE && rm $ARCHIVE"

echo "▶ Pushing to GitHub..."
git add .
git commit -m "Autodeploy on $DATE"
git push origin main || true

echo "✅ Autodeploy finished successfully!"
