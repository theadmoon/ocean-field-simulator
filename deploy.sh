#!/bin/bash
echo "🚀 Starting Ocean2Joy deploy from root..."

# Проверка, что git инициализирован
if [ ! -d ".git" ]; then
  echo "❌ This is not a git repo. Run 'git init' and add remote first."
  exit 1
fi

# Добавляем все файлы
git add -A

# Делаем коммит с меткой времени
git commit -m "Deploy update $(date '+%Y-%m-%d %H:%M:%S')"

# Отправляем на GitHub в main
git push origin main

echo "✅ Deploy complete! Visit your site:"
echo "🌍 https://theadmoon.github.io/ocean-field-simulator/"
