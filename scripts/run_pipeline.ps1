# DevSecOps Master Pipeline Orchestrator (PowerShell)
# This script executes the full security pipeline from SAST to DAST.

$RootDir = (Get-Item $PSScriptRoot).Parent.FullName
$ReportsDir = Join-Path $RootDir "reports"

# Ensure reports directory exists
if (-not (Test-Path -Path $ReportsDir)) {
    New-Item -ItemType Directory -Path $ReportsDir | Out-Null
}

Clear-Host
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   SECURESHOP FULL DEVSECOPS PIPELINE (STEP 9)      " -ForegroundColor Cyan
Write-Host "====================================================`n" -ForegroundColor Cyan

function Run-Step([string]$Name, [string]$ScriptPath) {
    Write-Host ">>> RUNNING STEP: $Name" -ForegroundColor Yellow
    & $ScriptPath
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[!] $Name finished with warnings/errors. Check reports." -ForegroundColor Gray
    }
    Write-Host "----------------------------------------------------`n"
}

# --- STATIC ANALYSIS PHASE ---
Run-Step "Secret Scanning (Step 3)" ".\scan_secrets.ps1"
Run-Step "SAST - Static Analysis (Step 1)" ".\scan_sast.ps1"
Run-Step "SCA - Dependency Scan (Step 4)" ".\scan_sca.ps1"
Run-Step "IaC - Infrastructure Scan (Step 7)" ".\scan_iac.ps1"

# --- BUILD PHASE ---
Write-Host ">>> RUNNING STEP: Container Build" -ForegroundColor Yellow
cd $RootDir
docker compose build
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Build failed! Stopping pipeline." -ForegroundColor Red
    exit 1
}
cd scripts
Write-Host "----------------------------------------------------`n"

# --- IMAGE SCANNING PHASE ---
Run-Step "Container Image Scan (Step 5)" ".\scan_container.ps1"

# --- DEPLOYMENT & DYNAMIC ANALYSIS PHASE ---
Write-Host ">>> RUNNING STEP: Deploying App for DAST" -ForegroundColor Yellow
cd $RootDir
docker compose up -d
cd scripts
Write-Host "    Waiting for services to initialize..." -ForegroundColor Gray
Start-Sleep -Seconds 10
Write-Host "----------------------------------------------------`n"

Run-Step "DAST - Dynamic Analysis (Step 6)" ".\scan_dast.ps1"

Write-Host "====================================================" -ForegroundColor Green
Write-Host "   FULL PIPELINE EXECUTION COMPLETED                " -ForegroundColor Green
Write-Host "   All reports are available in: $ReportsDir        " -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
