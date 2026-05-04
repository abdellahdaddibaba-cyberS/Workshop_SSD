# Local SAST Scan Script (PowerShell)
# This script runs Bandit and Semgrep locally using Docker.

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName

Write-Host "--- Running Bandit (Python SAST) ---" -ForegroundColor Cyan
# Using a generic python image to ensure bandit is available and up to date
docker run --rm -v "${RootDir}:/src" python:3.11-slim bash -c "pip install --quiet bandit && bandit -r /src/services -f txt"

Write-Host "`n--- Running Semgrep (Multi-language SAST) ---" -ForegroundColor Cyan
docker run --rm -v "${RootDir}:/src" semgrep/semgrep semgrep scan --config=auto /src/services
