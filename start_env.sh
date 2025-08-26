#!/usr/bin/env bash
# start_env.sh — подготовка окружения

echo "[*] Starting SSH agent..."
eval $(ssh-agent -s)

echo "[*] Adding SSH keys..."
ssh-add ~/.ssh/github_key
ssh-add ~/.ssh/developer1_fullkey

echo "[*] Checking GitHub connection..."
if ssh -T github 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ GitHub auth OK"
else
    echo "❌ GitHub auth failed"
fi

echo "[*] Checking production server connection..."
if ssh prod "echo ok" 2>/dev/null | grep -q "ok"; then
    echo "✅ Production server reachable"
else
    echo "❌ Production server connection failed"
fi

echo "[*] Environment ready."
