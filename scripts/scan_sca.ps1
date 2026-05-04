# Local SCA Scan Script (PowerShell)
# This script runs Trivy locally using Docker to check for vulnerable dependencies.

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName

Write-Host "--- Running Trivy (Dependency Scan) ---" -ForegroundColor Cyan
docker run --rm -v "${RootDir}:/src" aquasec/trivy fs /src --severity HIGH,CRITICAL
