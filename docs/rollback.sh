#!/usr/bin/env bash
set -e

source .env

echo "🔄 Available backups on $DEPLOY_HOST_ALIAS:"
ssh $DEPLOY_HOST_ALIAS "ls -1d ${DEPLOY_PATH}_backup_* 2>/dev/null || echo '❌ No backups found'"

read -p '👉 Enter backup folder name (leave empty for last): ' BACKUP_CHOICE

if [ -z "$BACKUP_CHOICE" ]; then
  BACKUP_CHOICE="${DEPLOY_PATH}_backup_last"
fi

echo "⏪ Rolling back to $BACKUP_CHOICE ..."
ssh $DEPLOY_HOST_ALIAS "if [ -d $BACKUP_CHOICE ]; then rm -rf $DEPLOY_PATH && cp -r $BACKUP_CHOICE $DEPLOY_PATH && echo '✅ Rollback complete'; else echo '❌ Backup not found'; fi"
