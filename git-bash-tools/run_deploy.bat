@echo off
set MSG=%1
if "%MSG%"=="" set MSG=Update: auto-deploy
"C:\Program Files\Git\bin\bash.exe" --login -i -c "./deploy.sh "%MSG%""
pause
