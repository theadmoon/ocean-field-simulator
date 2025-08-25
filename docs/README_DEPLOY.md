# Ocean2Joy Deployment Guide (v6)

## Подготовка
1. Убедись, что в `~/.ssh/` лежат:
   - `developer1.id_rsa`
   - `PUT_YOUR_PRIVATE_KEY_HERE.txt`

2. Запусти скрипт для сборки ключа:
   ```bash
   chmod +x fix-key.sh
   ./fix-key.sh
   ```

3. В `~/.ssh/config` должно быть:
   ```ssh-config
   Host prod
       HostName ocean2joy.com
       User developer1
       IdentityFile ~/.ssh/developer1_fullkey
       IdentitiesOnly yes
   ```

## Проверка соединения
Можно проверить отдельно:
```bash
./test-ssh.sh
```

## Деплой
1. Запусти:
   ```bash
   ./deploy.sh
   ```

2. Скрипт выполнит:
   - восстановление ключа
   - проверку SSH
   - создание резервной копии текущего сайта
   - очистку директории на сервере
   - загрузку файлов через rsync

## Откат (Rollback)
1. Просмотреть список доступных бэкапов и выбрать нужный:
   ```bash
   ./rollback.sh
   ```

2. Если оставить ввод пустым — откатится к последнему (`_backup_last`).

✅ После этого проект будет доступен на https://ocean2joy.com
