#!/bin/bash
echo "🌊 Starting Ocean2Joy deploy..."

# Проверка, что git инициализирован
if [ ! -d ".git" ]; then
  echo "❌ Это не git-репозиторий. Сначала сделай git init и настрой remote."
  exit 1
fi

# Чистим docs/
echo "🧹 Cleaning docs/..."
rm -rf docs
mkdir docs

# Если есть package.json → запускаем npm build
if [ -f "package.json" ]; then
  echo "⚡ package.json найден — запускаем npm run build..."
  npm install
  npm run build

  # Копируем результат билда (например в dist/) → docs/
  if [ -d "dist" ]; then
    cp -r dist/* docs/
  elif [ -d "build" ]; then
    cp -r build/* docs/
  else
    echo "⚠️ npm run build завершился, но dist/ или build/ не найдены!"
  fi
else
  echo "📂 package.json не найден — копируем весь проект..."
  cp -r * docs/
  # Убираем саму папку docs из копии (чтобы не зациклиться)
  rm -rf docs/docs
fi

# Добавляем .nojekyll, чтобы GitHub Pages поддерживал вложенные папки
echo "" > docs/.nojekyll

# Добавляем все файлы
git add -A

# Делаем коммит с меткой времени
git commit -m "🚀 Deploy update $(date '+%Y-%m-%d %H:%M:%S')"

# Отправляем на GitHub
git push origin main

echo "✅ Deploy complete! Сайт: https://theadmoon.github.io/ocean-field-simulator/"
