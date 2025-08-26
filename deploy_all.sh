#!/usr/bin/env bash
# deploy_all.sh — полный цикл: commit + tag + push + deploy + log update

set -e  # стоп при любой ошибке

echo "=== Ocean Field Simulator :: Full Release Deploy ==="

# --- Шаг 1. Подготовка окружения ---
echo "[1] Starting SSH agent and adding keys..."
eval $(ssh-agent -s)

ssh-add ~/.ssh/github_key 2>/dev/null || echo "ℹ️ GitHub key already loaded"
ssh-add ~/.ssh/developer1_fullkey 2>/dev/null || echo "ℹ️ Prod key already loaded"

# --- Шаг 2. Проверка GitHub ---
echo "[2] Checking GitHub connection..."
if ssh -T github 2>&1 | grep -q "You've successfully authenticated"; then
    echo "✅ GitHub auth OK"
else
    echo "❌ GitHub auth FAILED"
    exit 1
fi

# --- Шаг 3. Проверка продакшн сервера ---
echo "[3] Checking Production server connection..."
if ssh prod "echo ok" 2>/dev/null | grep -q "ok"; then
    echo "✅ Production server reachable"
else
    echo "❌ Production server connection FAILED"
    exit 1
fi

# --- Шаг 4. Автокоммит ---
echo "[4] Creating commit..."
git add -A
commit_msg="Release $(date +'%Y-%m-%d_%H-%M')"
git commit -m "$commit_msg" || echo "ℹ️ Nothing to commit"

# --- Шаг 5. Тег релиза ---
release_tag="v$(date +'%Y.%m.%d_%H%M')"
git tag -a "$release_tag" -m "Release $release_tag" || echo "ℹ️ Tag already exists"

# --- Шаг 6. Обновление README_DEPLOY.md ---
echo "[6] Updating deploy log..."
log_file="docs/README_DEPLOY.md"
timestamp=$(date +'%Y-%m-%d %H:%M:%S %Z')
echo "- ✅ Release $release_tag deployed at $timestamp" >> "$log_file"
git add "$log_file"
git commit -m "Update deploy log for $release_tag" || echo "ℹ️ No changes in log"

# --- Шаг 7. Пуш в GitHub ---
echo "[7] Pushing commit + tags to GitHub..."
git push origin main
git push origin --tags

# --- Шаг 8. Деплой на сервер ---
echo "[8] Deploying to Production..."
./scripts/deploy.sh

echo "=== ✅ Full Release Deploy Finished Successfully ==="
