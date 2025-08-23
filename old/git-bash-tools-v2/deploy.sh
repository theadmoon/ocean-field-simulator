#!/bin/bash
set -e

echo "🌊 Ocean2Joy Deploy Script starting..."

# 1. Определяем корень проекта
PROJECT_ROOT="$(pwd)"

# 2. Чистим и пересоздаём docs/
echo "🧹 Cleaning docs/"
rm -rf "$PROJECT_ROOT/docs"
mkdir -p "$PROJECT_ROOT/docs"

# 3. Гарантируем наличие .gitkeep
echo "# keep docs folder" > "$PROJECT_ROOT/docs/.gitkeep"

# 4. Проверяем package.json
if [ -f "$PROJECT_ROOT/package.json" ]; then
  echo "📦 package.json найден — запускаем сборку"
  npm install
  npm run build

  # По умолчанию билд может быть в build/, dist/ или out/
  if [ -d "$PROJECT_ROOT/build" ]; then
    cp -r "$PROJECT_ROOT/build/"* "$PROJECT_ROOT/docs/"
  elif [ -d "$PROJECT_ROOT/dist" ]; then
    cp -r "$PROJECT_ROOT/dist/"* "$PROJECT_ROOT/docs/"
  elif [ -d "$PROJECT_ROOT/out" ]; then
    cp -r "$PROJECT_ROOT/out/"* "$PROJECT_ROOT/docs/"
  else
    echo "⚠️ Не найден build/dist/out — копируем весь проект как есть"
    rsync -av --exclude 'docs' --exclude 'node_modules' "$PROJECT_ROOT/" "$PROJECT_ROOT/docs/"
  fi
else
  echo "📂 package.json не найден — копируем весь проект"
  rsync -av --exclude 'docs' --exclude 'node_modules' "$PROJECT_ROOT/" "$PROJECT_ROOT/docs/"
fi

# 5. Git commit & push
echo "🔄 Добавляем в git"
git add docs/

echo "💬 Введите комментарий к коммиту (по умолчанию 'Deploy update'):"
read -r COMMIT_MSG
if [ -z "$COMMIT_MSG" ]; then
  COMMIT_MSG="Deploy update"
fi

git commit -m "$COMMIT_MSG" || echo "ℹ️ Нет изменений для коммита"
git push origin main

echo "✅ Deploy завершён. Проверяй GitHub Pages!"
