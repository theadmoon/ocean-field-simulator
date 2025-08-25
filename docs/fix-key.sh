#!/usr/bin/env bash
set -e

KEY_DIR="$HOME/.ssh"
KEY_FILE="$KEY_DIR/developer1_fullkey"
PRIVATE_KEY="$KEY_DIR/developer1.id_rsa"
EXTRA_PART="$KEY_DIR/PUT_YOUR_PRIVATE_KEY_HERE.txt"

echo "🔧 Fixing SSH key..."

if [[ ! -f "$PRIVATE_KEY" ]]; then
  echo "❌ Not found: $PRIVATE_KEY"
  exit 1
fi

if [[ ! -f "$EXTRA_PART" ]]; then
  echo "❌ Not found: $EXTRA_PART"
  exit 1
fi

cat "$PRIVATE_KEY" "$EXTRA_PART" > "$KEY_FILE"
chmod 600 "$KEY_FILE"

echo "✅ SSH key prepared at: $KEY_FILE"
