# Backup and patch the known project directory used in the previous debugging session.
$ErrorActionPreference = "Stop"
$Project = "D:\Develop\hongmeng\homework\chapter1\HarmonyHomework"
if (!(Test-Path $Project)) { throw "Project directory not found: $Project" }
$Source = Join-Path $PSScriptRoot ".."
$Target = Join-Path $Project "hvigor\hvigor-config.json5"
$SourceConfig = Join-Path $Source "hvigor\hvigor-config.json5"
if (!(Test-Path $SourceConfig)) { throw "Archive hvigor config not found: $SourceConfig" }
$Backup = "$Target.backup-$(Get-Date -Format yyyyMMdd-HHmmss)"
Copy-Item $Target $Backup
Copy-Item $SourceConfig $Target -Force
Write-Host "Patched hvigor config. Backup: $Backup"
