@echo off
setlocal
title Désinstallation de Digit'Pilot
echo ===================================================
echo             DÉSINSTALLATION DE DIGIT'PILOT
echo ===================================================
echo.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Élévation des privilèges requise...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Voulez-vous vraiment désinstaller Digit'Pilot de cet ordinateur ?
echo (Tous les fichiers du programme et raccourcis seront supprimés).
echo.
set /p CONFIRM="Confirmer la désinstallation (O/N) ? [O] : "
if /i "%CONFIRM%"=="N" (
    echo [INFO] Désinstallation annulée par l'utilisateur.
    timeout /t 2 >nul
    exit /b 0
)

echo.
echo [1/4] Arrêt des processus Digit'Pilot en cours...
taskkill /F /IM DigitPilot.exe >nul 2>&1
taskkill /F /IM FanControl.exe >nul 2>&1
timeout /t 1 >nul

echo [2/4] Suppression des raccourcis...
set "DESKTOP_LNK=%PUBLIC%\Desktop\Digit'Pilot.lnk"
if exist "%DESKTOP_LNK%" del /f /q "%DESKTOP_LNK%" >nul 2>&1

set "USER_DESKTOP_LNK=%USERPROFILE%\Desktop\Digit'Pilot.lnk"
if exist "%USER_DESKTOP_LNK%" del /f /q "%USER_DESKTOP_LNK%" >nul 2>&1

set "START_MENU_DIR=%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Digit'Pilot"
if exist "%START_MENU_DIR%" rd /s /q "%START_MENU_DIR%" >nul 2>&1

set "USER_START_MENU_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Digit'Pilot"
if exist "%USER_START_MENU_DIR%" rd /s /q "%USER_START_MENU_DIR%" >nul 2>&1

echo [3/4] Suppression de l'enregistrement Windows (Applications et fonctionnalités)...
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\DigitPilot" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\DigitPilot" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "DigitPilot" /f >nul 2>&1

echo [4/4] Suppression des fichiers du programme...
set "INSTALL_DIR=%~dp0"
if "%INSTALL_DIR:~-1%"=="\" set "INSTALL_DIR=%INSTALL_DIR:~0,-1%"
cd /d "%TEMP%"
start "" powershell -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 2; if (Test-Path -LiteralPath '%INSTALL_DIR%') { Remove-Item -LiteralPath '%INSTALL_DIR%' -Recurse -Force }"

echo.
echo ===================================================
echo     Digit'Pilot a été désinstallé avec succès !
echo ===================================================
timeout /t 3 >nul
exit /b 0
