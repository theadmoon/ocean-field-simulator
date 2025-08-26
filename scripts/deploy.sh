#!/bin/bash
set -e

echo "=== Starting deploy ==="

# Запуск ssh-agent и подключение ключей
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_key
ssh-add ~/.ssh/developer1_fullkey

# Проверка подключения к GitHub
ssh -T github || { echo "GitHub connection failed"; exit 1; }

# Проверка подключения к серверу
ssh prod "echo prod ok" || { echo "Server connection failed"; exit 1; }

# Коммит и пуш на GitHub
git add -A
git commit -m "Auto-deploy $(date '+%Y-%m-%d %H:%M:%S')" || true
git push github main

# Деплой на сервер (исключаем ненужные папки и файлы)
rsync -avz --delete \
  --exclude ".git" \
  --exclude "docs/" \
  --exclude "*.zip" \
  --exclude "PROJECT_JOURNAL.md" \
  ./ prod:/var/www/ocean2joy.com

echo "=== Deploy finished successfully ==="
