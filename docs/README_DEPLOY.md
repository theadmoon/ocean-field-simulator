# 🚀 AutoDeploy v6

## Состав
- `autodeploy.sh` — полный автодеплой (GitHub + Releases + сервер ocean2joy.com)
- `PROJECT_JOURNAL.md` — журнал версий
- `archives/` — сюда будут сохраняться архивы версий

## Требования
- Установлен `git` и настроен SSH-доступ к GitHub
- Установлен `gh` (GitHub CLI), авторизация `gh auth login`
- Рабочий SSH-доступ на ocean2joy.com (alias `prod` в `~/.ssh/config`)

## Использование
```bash
chmod +x autodeploy.sh
./autodeploy.sh
```
В результате:
- Создаётся архив в `archives/`
- Версия фиксируется в `PROJECT_JOURNAL.md`
- Изменения пушатся в GitHub
- Создаётся релиз в GitHub Releases
- Файлы деплоятся на ocean2joy.com

