@echo off
setlocal
title Configuration Exclusions Antivirus - Digit'Pilot
color 0B

if not exist "%~dp0Ajouter_Exclusion_Antivirus.ps1" (
    echo [ERREUR] Le fichier Ajouter_Exclusion_Antivirus.ps1 est introuvable dans ce dossier.
    pause
    exit /b 1
)

:: 1. Verification des privileges Administrateur
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ============================================================
    echo   ELEVATION DES PRIVILEGES ADMINISTRATEUR (UAC)
    echo ============================================================
    echo.
    echo Demande d'autorisation Administrateur en cours...
    echo Veuillez accepter la fenetre de confirmation (UAC).
    echo.
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process powershell.exe -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', '%~dp0Ajouter_Exclusion_Antivirus.ps1') -Verb RunAs"
    exit /b
)

:: 2. Si deja Administrateur, lancer directement
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Ajouter_Exclusion_Antivirus.ps1"
