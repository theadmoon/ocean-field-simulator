#!/usr/bin/env bash
set -e

source .env

echo "🔍 Testing SSH connection to $DEPLOY_HOST_ALIAS..."
./fix-key.sh

ssh $DEPLOY_HOST_ALIAS "echo '✅ Connected successfully to $DEPLOY_HOST_ALIAS'"
