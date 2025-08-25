# 🌊 Ocean Field Simulator — Project Journal

---

## 📌 История релизов
- 2025-08-25 12:00 → v6 archived and deployed
- 2025-08-25 12:30 → v7 archived and deployed
- 2025-08-25 13:00 → v8 archived and deployed (auto-snapshots on deploy)

---

## 🚀 Шпаргалка по деплою

### 1. Подготовка
- SSH-ключи:
  - Сервер → `~/.ssh/developer1_fullkey`
  - GitHub → `~/.ssh/id_ed25519`
- Исправить права при необходимости:
  ```bash
  bash fix-key.sh
  ```
- Проверить `.env`:
  ```ini
  DEPLOY_HOST_ALIAS=prod
  DEPLOY_PATH=/var/www/ocean2joy.com
  PROJECT_NAME=ocean-field-simulator
  ```

### 2. Автодеплой
В корне проекта:
```bash
./autodeploy.sh
```
Скрипт делает всё автоматически:
- Создаёт архив в `archives/`
- Увеличивает версию
- Обновляет журнал
- Пушит изменения на GitHub
- Создаёт GitHub Release
- Деплоит на сервер ocean2joy.com
- ✅ Создаёт снапшот за день (если ещё нет)

### 3. Восстановление в новом чате
- Загрузи последний архив из `archives/`
- Из него восстановятся:
  - `autodeploy.sh`
  - `.env`
  - `fix-key.sh`
  - `PROJECT_JOURNAL.md`
- Я смогу сразу продолжить работу без потерь контекста
- 2025-08-25 18:15:47 → v1 archived and deployed
