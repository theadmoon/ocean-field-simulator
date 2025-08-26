@echo off
setlocal
title Ocean Field Simulator - Deploy
cd /d "%~dp0"
set "BASH_EXE=%ProgramFiles%\Git\bin\bash.exe"
if not exist "%BASH_EXE%" set "BASH_EXE=%ProgramFiles(x86)%\Git\bin\bash.exe"
if not exist "%BASH_EXE%" (
  echo [ERROR] Git Bash not found. Please install "Git for Windows".
  pause
  exit /b 1
)
echo [+] Running key fix and deploy via Git Bash...
"%BASH_EXE%" -lc "chmod +x ./scripts/*.sh 2>/dev/null; ./scripts/fix-key.sh && ./scripts/deploy.sh"
echo.
echo [i] Finished. Review any messages above.
pause
