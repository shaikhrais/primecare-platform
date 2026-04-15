$ErrorActionPreference = "Stop"

Write-Host "Starting Pre-flight Verification..." -ForegroundColor Cyan

Write-Host "Running Dart analysis..." -ForegroundColor Yellow
dart analyze --fatal-warnings
if ($LASTEXITCODE -ne 0) {
    Write-Host "Code analysis failed! Fix all errors and warnings before proceeding." -ForegroundColor Red
    exit 1
}

Write-Host "Running Linting..." -ForegroundColor Yellow
npm run turbo:lint
if ($LASTEXITCODE -ne 0) {
    Write-Host "Linting failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Running Unit Tests..." -ForegroundColor Yellow
npm run turbo:test
if ($LASTEXITCODE -ne 0) {
    Write-Host "Tests failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Pre-flight Code Verification Passed! Environment is clean." -ForegroundColor Green
exit 0
