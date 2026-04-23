$app = "primecare_corporate"
$projectName = "primecare-corporate"

Write-Host "Building $app..." -ForegroundColor Cyan
Set-Location -Path "apps\$app"
flutter build web --release

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed for $app!" -ForegroundColor Red
    exit 1
}

Write-Host "Deploying $app to Cloudflare Pages..." -ForegroundColor Cyan
wrangler pages deploy build/web --project-name=$projectName --commit-dirty=true

if ($LASTEXITCODE -ne 0) {
    Write-Host "Deployment failed for $app!" -ForegroundColor Red
    exit 1
}

Write-Host "Done!" -ForegroundColor Green
