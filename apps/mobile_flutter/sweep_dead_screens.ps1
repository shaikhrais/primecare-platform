$screens = Get-ChildItem -Path lib -Filter "*_screen.dart" -Recurse
$totalDeleted = 0

foreach ($screen in $screens) {
    $name = $screen.Name
    # Search for this filename being imported in ANY OTHER file in lib/
    $refs = Get-ChildItem -Path lib -Recurse -File | Where-Object { $_.FullName -ne $screen.FullName } | Select-String -Pattern $name -List
    
    if (-not $refs) {
        Write-Host "Unconnected Screen Detected: $name"
        Write-Host " -> Deleting: $($screen.FullName)"
        Remove-Item $screen.FullName -Force
        $totalDeleted++
    }
}

Write-Host "---"
Write-Host "Sweep Complete. Total Dead Screens Terminated: $totalDeleted"
