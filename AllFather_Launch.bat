@echo off
TITLE AllFather BP 1.2 Genesis Launcher
SET "URL=http://localhost:8050"

echo [1/3] Checking Environment...
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not running.
    pause
    exit /b
)

echo [2/3] Synthesizing Language Mesh...
docker-compose up -d --build

echo [3/3] Synchronizing J.A.R.V.I.S. HUD...
timeout /t 10 /nobreak >nul

start %URL%
echo.
echo ==================================================
echo ALLFATHER IS ONLINE. TRACKING ACTIVE.
echo ==================================================
pause
