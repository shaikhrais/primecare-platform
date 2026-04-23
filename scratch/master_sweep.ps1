$apps = @(
    "primecare_business_development",
    "primecare_client",
    "primecare_clinic",
    "primecare_franchise",
    "primecare_marketing",
    "primecare_support"
)

$rootDir = Get-Location

foreach ($app in $apps) {
    Write-Host "=========================================" -ForegroundColor Cyan
    Write-Host "Processing $app..." -ForegroundColor Cyan
    Write-Host "=========================================" -ForegroundColor Cyan
    
    Set-Location -Path "apps\$app"
    
    Write-Host "Building $app..." -ForegroundColor Cyan
    flutter build web --release --no-tree-shake-icons
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error building $app!" -ForegroundColor Red
        Set-Location -Path $rootDir
        continue
    }

    $projectName = $app -replace "_", "-"
    Write-Host "Deploying $app as $projectName..." -ForegroundColor Cyan
    wrangler pages deploy build/web --project-name=$projectName --commit-dirty=true
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error deploying $app!" -ForegroundColor Red
    }
    
    Set-Location -Path $rootDir
}

Write-Host "Master Sweep Completed!" -ForegroundColor Green
