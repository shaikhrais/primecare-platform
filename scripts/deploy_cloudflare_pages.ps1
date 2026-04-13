$ErrorActionPreference = "Stop"
$appsDir = Join-Path $PSScriptRoot "..\apps"

$appDirs = Get-ChildItem -Path $appsDir -Directory

foreach ($dir in $appDirs) {
    $appName = $dir.Name
    if ($appName -eq "cypress-test" -or $appName -eq "primecare_v4") {
        continue
    }

    $projectName = $appName -replace "_", "-"
    
    Write-Host "==================" -ForegroundColor Cyan
    Write-Host "Deploying $appName as $projectName" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan

    Set-Location -Path $dir.FullName

    Write-Host "Fetching dependencies..." -ForegroundColor Yellow
    flutter pub get

    Write-Host "Building web package..." -ForegroundColor Yellow
    flutter build web --release

    Write-Host "Deploying to Cloudflare Pages..." -ForegroundColor Yellow
    # Using npx wrangler from local node_modules
    npx wrangler pages deploy build/web --project-name $projectName
    
    Write-Host "Successfully deployed $appName!" -ForegroundColor Green
}

Set-Location -Path $PSScriptRoot
Write-Host "All apps deployed successfully!" -ForegroundColor Green
