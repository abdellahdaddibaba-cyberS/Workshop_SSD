# Container Image Scanning Script (PowerShell)
# This script runs Trivy to scan built container images for vulnerabilities.

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName
$ReportsDir = Join-Path $RootDir "reports"

# Create reports directory if it doesn't exist
if (-not (Test-Path -Path $ReportsDir)) {
    New-Item -ItemType Directory -Path $ReportsDir | Out-Null
}

# Define images to scan
$Images = @(
    "user-service:latest",
    "product-service:latest",
    "order-service:latest",
    "payment-service:latest",
    "notification-service:latest",
    "inventory-service:latest",
    "gateway:latest"
)

Write-Host "--- Starting Container Image Scanning (Step 5) ---" -ForegroundColor Cyan
Write-Host "Reports will be saved to: $ReportsDir" -ForegroundColor Gray

foreach ($Image in $Images) {
    # Check if image exists locally
    $ImageExists = docker images -q $Image
    
    if (-not $ImageExists) {
        Write-Host "[!] Skipping $Image (Not found locally)" -ForegroundColor Gray
        continue
    }

    $CleanImageName = $Image.Replace(":", "_")
    $ReportFile = Join-Path $ReportsDir "scan_$CleanImageName.txt"

    Write-Host "`n[+] Scanning Image: $Image" -ForegroundColor Yellow
    Write-Host "    Writing report to: $ReportFile..." -ForegroundColor Gray
    
    # Run Trivy image scan using the plain text template
    docker run --rm `
        -v //var/run/docker.sock:/var/run/docker.sock `
        -v "${PSScriptRoot}:/scripts" `
        -v "${HOME}/.cache:/root/.cache/" `
        aquasec/trivy image --severity HIGH,CRITICAL --no-progress `
        --format template --template "@/scripts/trivy-template.tpl" $Image | Out-File -FilePath $ReportFile -Encoding utf8

    if ($LASTEXITCODE -eq 0) {
        Write-Host "    [OK] Scan completed. No High/Critical vulnerabilities found." -ForegroundColor Green
    } else {
        Write-Host "    [!] Scan completed. Vulnerabilities found! Check the report." -ForegroundColor Red
    }
}

Write-Host "`n--- Container Scanning Completed ---" -ForegroundColor Green
