#!/bin/bash
set -e

echo "🚀 Starting deployment..."

# 1. Проверка package.json
if [ -f package.json ]; then
  echo "📦 Detected package.json, running npm install & build..."
  npm install
  npm run build
fi

# 2. Очистка docs/ и копирование
rm -rf docs
mkdir docs

if [ -d dist ]; then
  echo "📂 Copying dist/ to docs/"
  cp -r dist/* docs/
elif [ -d build ]; then
  echo "📂 Copying build/ to docs/"
  cp -r build/* docs/
else
  echo "📂 Copying project root (src/, assets/, index.html, etc.) to docs/"
  cp -r * docs/ || true
fi

# 3. Git коммит и пуш
git add docs
git commit -m "🚀 Deploy update $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✅ Deployment complete!"
