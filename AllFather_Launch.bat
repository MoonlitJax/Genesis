@echo off
TITLE AllFather BP 1.2 Genesis Launcher
echo ==================================================
echo       ALLFATHER PROJECT: AWAKENING SEQUENCE
echo ==================================================

:: Check if Docker is running
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not running. Launch Docker Desktop first.
    pause
    exit /b
)

:: Build and Start the Mesh
echo [SYSTEM] Synthesizing Language Cores (Python, Go, Rust, SQL)...
docker-compose up -d --build

:: Wait for UI to warm up
echo [SYSTEM] Warming up J.A.R.V.I.S. HUD...
timeout /t 8 /nobreak >nul

:: Launch Interface
start http://localhost:8050
echo [SUCCESS] AllFather is Online.
echo ==================================================
pause
