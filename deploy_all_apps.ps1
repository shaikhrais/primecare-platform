$apps = @(
    "primecare_business_development",
    "primecare_client",
    "primecare_clinic",
    "primecare_corporate",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support"
)

$rootDir = Get-Location

foreach ($app in $apps) {
    # Convert underscores to hyphens for Cloudflare project name
    $projectName = $app -replace "_", "-"
    
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "Deploying $app to Cloudflare Pages as '$projectName'..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    Set-Location -Path "apps\$app"
    
    # Ensure build exists
    if (-Not (Test-Path "build\web")) {
        Write-Host "Error: build\web not found for $app. Please ensure you run build_all_apps.ps1 first." -ForegroundColor Red
        continue
    }

    # Deploy to cloudflare
    wrangler pages deploy build/web --project-name=$projectName --commit-dirty=true
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error deploying $app!" -ForegroundColor Red
    }
    
    Set-Location -Path $rootDir
}

Write-Host "=========================================" -ForegroundColor Green
Write-Host "Deployment cycle completed!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green
