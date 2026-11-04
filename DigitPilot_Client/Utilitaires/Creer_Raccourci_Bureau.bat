@echo off
title Creer Raccourci Bureau - Digit'Pilot
echo ============================================================
echo   CREATION DU RACCOURCI SUR LE BUREAU - DIGIT'PILOT
echo ============================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$curr = '%~dp0'.TrimEnd('\'); " ^
  "$rootDir = if (Test-Path (Join-Path $curr 'DigitPilot.exe')) { $curr } elseif (Test-Path (Join-Path $curr '..\DigitPilot.exe')) { (Resolve-Path (Join-Path $curr '..')).Path } else { $curr }; " ^
  "$target = if (Test-Path (Join-Path $rootDir 'Lancer_DigitPilot.bat')) { Join-Path $rootDir 'Lancer_DigitPilot.bat' } else { Join-Path $rootDir 'DigitPilot.exe' }; " ^
  "$ico = if (Test-Path (Join-Path $curr 'app.ico')) { Join-Path $curr 'app.ico' } elseif (Test-Path (Join-Path $rootDir 'app.ico')) { Join-Path $rootDir 'app.ico' } else { (Join-Path $rootDir 'DigitPilot.exe') + ',0' }; " ^
  "$ws = New-Object -ComObject WScript.Shell; " ^
  "$desktop = [System.Environment]::GetFolderPath('Desktop'); " ^
  "$s = $ws.CreateShortcut((Join-Path $desktop 'Digit''Pilot.lnk')); " ^
  "$s.TargetPath = $target; " ^
  "$s.WorkingDirectory = $rootDir; " ^
  "$s.IconLocation = $ico; " ^
  "$s.Description = 'Digit''Pilot PC Cleaner & Utility'; " ^
  "$s.Save();"

echo [OK] Le raccourci "Digit'Pilot" a ete cree sur votre Bureau avec succes !
ping 127.0.0.1 -n 3 >nul
