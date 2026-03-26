Write-Host "Hunting down stale Cloudflare Node & Flutter Engine instances..."
Get-WmiObject Win32_Process | Where-Object { $_.CommandLine -like "*wrangler*" -or $_.CommandLine -like "*vite*" -or $_.CommandLine -like "*flutter*" -or $_.CommandLine -like "*dart*" } | ForEach-Object { 
    Write-Host "Terminating PID: $($_.ProcessId) -> $($_.CommandLine)"
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}
Write-Host "✅ Network Ecosystem Flushed."
