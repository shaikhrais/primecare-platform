$port = 8080
$connections = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
foreach ($c in $connections) {
    Write-Host "Killing Process ID: $($c.OwningProcess) bound to $port"
    Stop-Process -Id $c.OwningProcess -Force -ErrorAction SilentlyContinue
}
