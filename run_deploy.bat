@echo off
REM Runs deploy.sh via Git Bash on Windows
setlocal
REM Try default Git Bash path; adjust if needed
set "GITBASH=C:\Program Files\Git\bin\bash.exe"

if not exist "%GITBASH%" (
  echo Git Bash not found at "%GITBASH%". Please edit run_deploy.bat and set the correct path.
  pause
  exit /b 1
)

"%GITBASH%" -lc "./deploy.sh %*"
endlocal
