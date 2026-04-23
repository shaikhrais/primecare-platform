$rootDir = Get-Location

$apps = @(
    "primecare_business_development",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support"
)

foreach ($app in $apps) {
    $projectName = $app -replace "_", "-"
    
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "Deploying $app to Cloudflare Pages as '$projectName'..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    Set-Location -Path "apps\$app"
    
    if (-Not (Test-Path "build\web")) {
        Write-Host "Error: build\web not found for $app. Skipping." -ForegroundColor Yellow
        Set-Location -Path $rootDir
        continue
    }

    wrangler pages deploy build/web --project-name=$projectName --commit-dirty=true
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error deploying $app!" -ForegroundColor Red
    }
    
    Set-Location -Path $rootDir
}

Write-Host "=========================================" -ForegroundColor Green
Write-Host "Deployment cycle completed!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
