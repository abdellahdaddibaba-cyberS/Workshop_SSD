# Infrastructure-as-Code (IaC) Scanning Script (PowerShell)
# This script runs Trivy to scan Dockerfiles and Docker Compose files for misconfigurations.

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName
$ReportsDir = Join-Path $RootDir "reports"
$ReportFile = Join-Path $ReportsDir "scan_iac.txt"

# Ensure reports directory exists
if (-not (Test-Path -Path $ReportsDir)) {
    New-Item -ItemType Directory -Path $ReportsDir | Out-Null
}

Write-Host "--- Starting IaC Security Scan (Step 7) ---" -ForegroundColor Cyan
Write-Host "Scanning: Dockerfiles and docker-compose.yml" -ForegroundColor Yellow
Write-Host "Writing report to: $ReportFile" -ForegroundColor Gray

# Run Trivy configuration scan
# We scan the root directory (.) which will pick up all Dockerfiles and the compose file
docker run --rm `
    -v "${RootDir}:/src" `
    -v "${PSScriptRoot}:/scripts" `
    -v "${HOME}/.cache:/root/.cache/" `
    aquasec/trivy config /src --severity HIGH,CRITICAL `
    --format template --template "@/scripts/trivy-template.tpl" | Out-File -FilePath $ReportFile -Encoding utf8

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n[OK] IaC Scan completed. No High/Critical misconfigurations found." -ForegroundColor Green
} else {
    Write-Host "`n[!] IaC Scan completed. Security risks found! Check the report." -ForegroundColor Red
}

Write-Host "`n--- IaC Scanning Completed ---" -ForegroundColor Green
