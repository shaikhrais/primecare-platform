# PrimeCare Pre-Deployment Integrity Guardian
# This script ensures the platform is in a "Zero-Error" state before deployment.

$ErrorActionPreference = "Stop"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " PRIMECARE GUARDIAN: Initiating Pre-Deployment Sweep" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Structural Validation (Analysis)
Write-Host "`n[1/4] Analyzing Core Infrastructure..." -ForegroundColor Yellow
cd packages/flutter_core
dart analyze
if ($LASTEXITCODE -ne 0) { throw "Analysis failed in flutter_core" }

Write-Host "[1/4] Analyzing Adapters..." -ForegroundColor Yellow
cd ../primecare_adapters
dart analyze
if ($LASTEXITCODE -ne 0) { throw "Analysis failed in primecare_adapters" }

Write-Host "[1/4] Analyzing UI System..." -ForegroundColor Yellow
cd ../factory_system/primecare_ui
dart analyze
if ($LASTEXITCODE -ne 0) { throw "Analysis failed in primecare_ui" }

# 2. Functional Verification (Tests)
Write-Host "`n[2/4] Running Corporate Portal Tests..." -ForegroundColor Yellow
cd ../../../apps/primecare_corporate
flutter test test/app_navigation_test.dart
if ($LASTEXITCODE -ne 0) { throw "Functional tests failed in primecare_corporate" }

# 3. Registry Integrity Sweep
Write-Host "`n[3/4] Running Registry Health Sweep..." -ForegroundColor Yellow
cd ../../
dart run scratch/health_sweep.dart
if ($LASTEXITCODE -ne 0) { throw "Registry health sweep failed" }

# 4. Final Verification
Write-Host "`n==========================================" -ForegroundColor Green
Write-Host " SUCCESS: Platform Integrity Verified." -ForegroundColor Green
Write-Host " Ready for Deployment." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

cd ../
