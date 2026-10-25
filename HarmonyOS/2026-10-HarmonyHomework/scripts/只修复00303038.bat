@echo off
setlocal
set "PROJECT=D:\Develop\hongmeng\homework\chapter1\HarmonyHomework"
set "TARGET=%PROJECT%\hvigor\hvigor-config.json5"
set "SOURCE=%~dp0..\hvigor\hvigor-config.json5"
if not exist "%TARGET%" (echo Target not found: %TARGET% & pause & exit /b 1)
if not exist "%SOURCE%" (echo Source not found: %SOURCE% & pause & exit /b 1)
copy "%TARGET%" "%TARGET%.backup-%RANDOM%" >nul
if errorlevel 1 (echo Backup failed & pause & exit /b 1)
copy "%SOURCE%" "%TARGET%" >nul
if errorlevel 1 (echo Copy failed & pause & exit /b 1)
echo Updated hvigor-config.json5 with required dependencies field.
pause
