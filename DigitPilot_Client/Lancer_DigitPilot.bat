@echo off
setlocal
cd /d "%~dp0"
title Digit'Pilot v0.1.2
echo ==============================================
echo       DIGIT'PILOT PC UTILITY - v0.1.2         
echo ==============================================
echo.

if not exist "%~dp0DigitPilot.exe" (
    echo [ERREUR] DigitPilot.exe est introuvable dans ce dossier.
    pause
    exit /b 1
)

net session >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Execution directe en mode Administrateur...
    start "" /D "%~dp0" "%~dp0DigitPilot.exe"
    exit
)

echo [INFO] Demande d'elevation Administrateur (UAC)...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$exe = [System.Environment]::ExpandEnvironmentVariables('%~dp0DigitPilot.exe'); $dir = [System.Environment]::ExpandEnvironmentVariables('%~dp0'); try { Start-Process -FilePath $exe -WorkingDirectory $dir -Verb RunAs -ErrorAction Stop } catch { Start-Process -FilePath $exe -WorkingDirectory $dir }"
exit
