$services = @(
    "api_gateway",
    "auth_api",
    "billing_api",
    "client_api",
    "governance_api",
    "provider_api",
    "verification_api"
)

$rootDir = Get-Location

foreach ($service in $services) {
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "Building service: $service..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    docker build -t "primecare-$($service -replace '_', '-'):latest" `
        --build-arg SERVICE_PATH="services/$service" `
        -f services/service.Dockerfile .
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error building $service!" -ForegroundColor Red
        exit $LASTEXITCODE
    }
}

Write-Host "=========================================" -ForegroundColor Green
Write-Host "All services built successfully!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
