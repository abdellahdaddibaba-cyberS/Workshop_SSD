# Local Secret Scan Script (PowerShell)
# This script runs Gitleaks locally using Docker.

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName

Write-Host "--- Running Gitleaks (Secret Scan) ---" -ForegroundColor Cyan
docker run --rm -v "${RootDir}:/path" zricethezav/gitleaks:latest detect --source="/path" --config="/path/gitleaks.toml" --no-git -v