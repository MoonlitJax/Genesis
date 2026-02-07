@echo off
TITLE AllFather BP 1.2 - Genesis Launcher
SETLOCAL EnableDelayedExpansion

:: --- CONFIGURATION ---
SET "DOCKER_COMPOSE_FILE=docker-compose.yml"
SET "UI_URL=http://localhost:8050"

echo =======================================================
echo           ALLFATHER SYSTEM INITIALIZATION
echo =======================================================

:: 1. CHECK FOR DOCKER (The Physical Body)
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed or not running.
    echo Please install Docker Desktop to provide the system's physical mesh.
    pause
    exit /b
)

:: 2. VERIFY DATA INTEGRITY (The Vault)
if not exist "simulated_traffic.json" (
    echo [SYSTEM] Intelligence Vault missing. Reconstructing baseline telemetry...
    (
    echo [
    echo   {"license_plate": "ALLFATHER-01", "latitude": 33.4484, "longitude": -112.0740, "timestamp": "2026-02-07T00:00:00"}
    echo ]
    ) > simulated_traffic.json
)

:: 3. WAKE THE MESH (Docker Compose)
echo [J.A.R.V.I.S.] Awakening the multi-language mesh...
docker-compose up -d --build

if %errorlevel% neq 0 (
    echo [CRITICAL] Failed to initialize the container mesh. 
    pause
    exit /b
)

:: 4. WAIT FOR BRAIN SENSORS
echo [F.R.I.D.A.Y.] Synchronizing neural interfaces...
timeout /t 5 /nobreak >nul

:: 5. LAUNCH TACTICAL UI
echo [SUCCESS] AllFather is Online. Launching Tactical Interface...
start "" "%UI_URL%"

echo =======================================================
echo    SYSTEM ACTIVE - MINIMIZE THIS WINDOW TO KEEP LIVE
echo =======================================================
pause
