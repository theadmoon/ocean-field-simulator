#!/usr/bin/env bash
set -e

source .env

echo "🚀 Starting Ocean2Joy deployment..."
echo "   Target: $DEPLOY_HOST_ALIAS → $DEPLOY_PATH"

echo "🔧 Restoring SSH key..."
./fix-key.sh

echo "🔌 Testing SSH connection..."
ssh -o BatchMode=yes $DEPLOY_HOST_ALIAS "echo '✅ SSH connection established'"

# Backup current version
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
echo "📦 Creating backup on server..."
ssh $DEPLOY_HOST_ALIAS "if [ -d $DEPLOY_PATH ]; then cp -r $DEPLOY_PATH ${DEPLOY_PATH}_backup_$TIMESTAMP && cp -r $DEPLOY_PATH ${DEPLOY_PATH}_backup_last; fi"

echo "🧹 Cleaning target directory..."
ssh $DEPLOY_HOST_ALIAS "rm -rf $DEPLOY_PATH/*"

echo "📂 Syncing files via rsync..."
rsync -azv --exclude '.git' --exclude '*.log' ./ $DEPLOY_HOST_ALIAS:$DEPLOY_PATH/ | tee deploy.log

echo "✅ Deployment finished!"
