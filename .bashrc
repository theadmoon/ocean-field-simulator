# ==================================================
#  Ocean2Joy .bashrc
# ==================================================

# Включаем поддержку алиасов (если запуск не интерактивный)
shopt -s expand_aliases

# ==================================================
# Git + PATH
# ==================================================

# Добавляем Git for Windows в PATH
export PATH="/c/Program Files/Git/bin:/c/Program Files/Git/cmd:$PATH"

# Проверка Git
if command -v git >/dev/null 2>&1; then
    echo "✔ Git доступен: $(git --version)"
else
    echo "✘ Git не найден — проверь установку"
fi

# ==================================================
# SSH setup
# ==================================================

# Автозапуск ssh-agent (один процесс на юзера)
if ! pgrep -u "$USERNAME" ssh-agent > /dev/null 2>&1; then
    eval $(ssh-agent -s) >/dev/null
fi

# Добавляем ключ, если его нет в агенте
ssh-add -l | grep "developer1_fullkey" >/dev/null 2>&1
if [ $? -ne 0 ]; then
    ssh-add ~/.ssh/developer1_fullkey </dev/null 2>/dev/null
fi

# ==================================================
# Deploy helpers
# ==================================================

# Снимаем старые алиасы, если были
unalias deploy 2>/dev/null || true
unalias autodeploy 2>/dev/null || true
unalias dcu 2>/dev/null || true
unalias dcd 2>/dev/null || true
unalias dcl 2>/dev/null || true

# Функции для запуска скриптов
deploy() {
    bash "/d/2025/ocean-field-simulator/deploy.sh" "$@"
}

autodeploy() {
    bash "/d/2025/ocean-field-simulator/autodeploy.sh" "$@"
}

# Docker helpers
dcu() { docker-compose up -d "$@"; }
dcd() { docker-compose down "$@"; }
dcl() { docker-compose logs -f --tail=100 "$@"; }

# ==================================================
# Автопереход в проект
# ==================================================
cd /d/2025/ocean-field-simulator >/dev/null 2>&1 || true
