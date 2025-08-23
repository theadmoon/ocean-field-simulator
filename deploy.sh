#!/bin/bash
set -e

echo "🚀 Starting Ocean2Joy deploy..."

# Папка проекта
PROJECT_DIR="$(pwd)"

# 1. Чистим старый билд
rm -rf "$PROJECT_DIR/docs"
mkdir "$PROJECT_DIR/docs"

# 2. Если проект на Vite/React/Node (раскомментируй при необходимости)
# echo "📦 Installing dependencies..."
# npm install

# echo "⚡ Building project..."
# npm run build

# 3. Для простого HTML/JS/CSS (как у нас сейчас)
echo "📋 Copying files into /docs..."
cp -r "$PROJECT_DIR/index.html" "$PROJECT_DIR/docs/"
cp -r "$PROJECT_DIR/assets" "$PROJECT_DIR/docs/" 2>/dev/null || true

# 4. Git push
echo "📤 Pushing to GitHub..."
git add .
git commit -m "deploy: auto build to /docs"
git push origin main

echo "✅ Deploy finished! Your site will update at GitHub Pages in ~1 minute."
