#!/bin/bash
echo "🚀 Starting Ocean2Joy deploy..."

# Проверка на package.json → билд
if [ -f "package.json" ]; then
  echo "📦 package.json найден — собираем проект..."
  npm run build || { echo "❌ Ошибка при сборке!"; exit 1; }
  BUILD_DIR="build"
else
  echo "📂 package.json не найден — копируем весь проект..."
  BUILD_DIR="."
fi

# Чистим docs/
echo "🧹 Cleaning docs/..."
rm -rf docs/*
mkdir -p docs

# Копируем всё, кроме docs и скрытых .git
rsync -av --exclude='docs' --exclude='.git' "$BUILD_DIR"/ docs/

# Добавляем в git
git add -A

# Коммит с меткой времени
git commit -m "Deploy update $(date '+%Y-%m-%d %H:%M:%S')"

# Пушим
git push origin main

echo "✅ Deploy complete! Visit your site:"
echo "👉 https://theadmoon.github.io/ocean-field-simulator/"
