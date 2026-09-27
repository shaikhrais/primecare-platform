# deploy_apis.ps1
# Deploy all Cloudflare Workers under services/* that contain a wrangler.toml
# Requires CLOUDFLARE_API_TOKEN set in .env
$repoRoot = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
$envFile = Join-Path $repoRoot ".env"
# Load .env token
Get-Content $envFile | ForEach-Object {
    if ($_ -match '^CLOUDFLARE_API_TOKEN=(.+)') {
        $env:CLOUDFLARE_API_TOKEN = $Matches[1]
    }
}
if (-not $env:CLOUDFLARE_API_TOKEN) {
    Write-Host "[ERROR] CLOUDFLARE_API_TOKEN not set in .env. Please add it before running this script." -ForegroundColor Red
    exit 1
}
Get-ChildItem "$repoRoot/services" -Directory | ForEach-Object {
    $serviceDir = $_.FullName
    $wranglerPath = Join-Path $serviceDir "wrangler.toml"
    if (Test-Path $wranglerPath) {
        Write-Host "Deploying $($_.Name)" -ForegroundColor Cyan
        Push-Location $serviceDir
        dart pub get
        npx wrangler deploy
        Pop-Location
    }
}
