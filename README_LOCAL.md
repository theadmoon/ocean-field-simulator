# Git Bash Tools for Ocean2Joy

## Files
- **deploy.sh** — запускает git commit + push в main.
- **run_deploy.bat** — Windows ярлык для запуска deploy.sh.
- **.gitattributes** — гарантирует, что скрипты будут с правильными концами строк.

## Usage
1. Распакуй `git-bash-tools.zip` в корень проекта (например, `ocean-field-simulator/`).
2. Запусти **Git Bash** в этом каталоге.
3. Сделай первый commit/push вручную:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```
4. После этого можно использовать `./deploy.sh` или `run_deploy.bat`.

