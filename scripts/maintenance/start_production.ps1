# PrimeCare Local Production Simulator
# This script builds the project and starts it as if it were in production.

Write-Host "🚀 Starting PrimeCare Production Simulator..." -ForegroundColor Green

# 1. Build Frontend
Write-Host "`n📦 Building Web Admin..." -ForegroundColor Cyan
Set-Location "apps\web-admin"
npm run build
if ($LASTEXITCODE -ne 0) { Write-Error "Frontend build failed!"; exit 1 }

# 2. Check Database
Write-Host "`n🗄️ Checking Database..." -ForegroundColor Cyan
Set-Location "..\worker-api"
npx prisma generate
# Optional: npx prisma db push

# 3. Start Backend (Wrangler)
Write-Host "`n⚡ Starting Worker API (Wrangler)..." -ForegroundColor Cyan
# Starting in background usually requires Start-Process, but for simplicity in this script we'll just inform user
Write-Host "To run the backend, open a new terminal and run:" -ForegroundColor Yellow
Write-Host "cd apps/worker-api && npm run dev" -ForegroundColor White

# 4. Serve Frontend
Write-Host "`n🌐 Serving Web Admin..." -ForegroundColor Cyan
Set-Location "..\web-admin"
Write-Host "To serve the frontend build, run:" -ForegroundColor Yellow
Write-Host "npx serve -s dist -l 3000" -ForegroundColor White

Write-Host "`n✅ Build Complete! Follow instructions above to start services." -ForegroundColor Green
Pause
