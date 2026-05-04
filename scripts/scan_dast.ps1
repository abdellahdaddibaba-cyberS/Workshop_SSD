# DAST (Dynamic Application Security Testing) Script (PowerShell)
# This script runs OWASP ZAP to scan the running application for vulnerabilities.

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName
$ReportsDir = Join-Path $RootDir "reports"

# Ensure reports directory exists
if (-not (Test-Path -Path $ReportsDir)) {
    New-Item -ItemType Directory -Path $ReportsDir | Out-Null
}

# The Target URL of your running application (usually the API Gateway)
# On Windows/Mac, use host.docker.internal to reach the host from a container
$TargetUrl = "http://host.docker.internal:8081" 

Write-Host "--- Starting DAST Scan (Step 6) ---" -ForegroundColor Cyan
Write-Host "Target: $TargetUrl" -ForegroundColor Yellow
Write-Host "NOTE: The application MUST be running for this scan to work." -ForegroundColor Gray

# Define report file names
$HtmlReport = "dast_report.html"
$JsonReport = "dast_report.json"

Write-Host "`n[+] Running OWASP ZAP Baseline Scan..." -ForegroundColor Yellow
Write-Host "    This may take a few minutes..." -ForegroundColor Gray

# Run OWASP ZAP via Docker
# We add --add-host to ensure the container can resolve host.docker.internal
docker run --rm `
    -v "${ReportsDir}:/zap/wrk/:rw" `
    --add-host=host.docker.internal:host-gateway `
    ghcr.io/zaproxy/zaproxy:stable zap-baseline.py `
    -t $TargetUrl `
    -r $HtmlReport `
    -J $JsonReport `
    -I 

# Note: -I means "Ignore failures" so the script doesn't stop if vulnerabilities are found.
# This allows the pipeline to finish and you can check the report.

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n[OK] DAST Scan completed successfully." -ForegroundColor Green
} else {
    Write-Host "`n[!] DAST Scan finished with findings. Check the reports in: $ReportsDir" -ForegroundColor Yellow
}

Write-Host "`nReports generated:" -ForegroundColor Gray
Write-Host "- HTML: $(Join-Path $ReportsDir $HtmlReport)" -ForegroundColor White
Write-Host "- JSON: $(Join-Path $ReportsDir $JsonReport)" -ForegroundColor White

Write-Host "`n--- DAST Scanning Completed ---" -ForegroundColor Green
