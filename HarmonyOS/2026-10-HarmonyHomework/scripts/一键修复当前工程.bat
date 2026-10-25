@echo off
setlocal
set "PROJECT=D:\Develop\hongmeng\homework\chapter1\HarmonyHomework"
if not exist "%PROJECT%" (
  echo Project not found: %PROJECT%
  echo Edit this script and set PROJECT to your actual project path.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0patch-existing-project.ps1"
if errorlevel 1 (
  echo Repair failed. Review the message above.
  pause
  exit /b 1
)
echo Repair script completed. Reopen DevEco Studio and sync.
pause
