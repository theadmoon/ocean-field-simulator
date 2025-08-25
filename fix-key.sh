#!/bin/bash
# fix-key.sh — восстановление прав на SSH ключи

KEY_PATH="$HOME/.ssh/developer1_fullkey"
chmod 600 "$KEY_PATH"
echo "✅ Permissions fixed for $KEY_PATH"

KEY_PATH2="$HOME/.ssh/id_ed25519"
chmod 600 "$KEY_PATH2"
echo "✅ Permissions fixed for $KEY_PATH2"
