$ErrorActionPreference = "Stop"
$appsDir = Join-Path $PSScriptRoot "..\apps"

# Load .env file if present
if (Test-Path ".env") {
    Get-Content ".env" | ForEach-Object {
        if ($_ -match '^\s*([^#=]+)\s*=\s*(.*)$') {
            $key = $Matches[1].Trim()
            $val = $Matches[2].Trim()
            if ($val.StartsWith('"') -and $val.EndsWith('"')) { $val = $val.Substring(1, $val.Length - 2) }
            if ($val.StartsWith("'") -and $val.EndsWith("'")) { $val = $val.Substring(1, $val.Length - 2) }
            $env:$key = $val
        }
    }
}

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
    flutter build web --release --no-wasm-dry-run --dart-define=API_BASE_URL=https://primecare-worker-api-gateway.itpro-mohammed.workers.dev/api

    Write-Host "Creating Cloudflare Pages _redirects file for SPA client-side routing..." -ForegroundColor Yellow
    Set-Content -Path "build\web\_redirects" -Value "/* /index.html 200" -Encoding Ascii

    Write-Host "Deploying to Cloudflare Pages..." -ForegroundColor Yellow
    # Using wrangler from local node_modules
    $oldToken = $env:CLOUDFLARE_API_TOKEN
    $env:CLOUDFLARE_API_TOKEN = $null
    
    npx wrangler pages deploy build/web --project-name $projectName
    
    $env:CLOUDFLARE_API_TOKEN = $oldToken
    
    Write-Host "Successfully deployed $appName!" -ForegroundColor Green
}

Set-Location -Path $PSScriptRoot
Write-Host "All apps deployed successfully!" -ForegroundColor Green
