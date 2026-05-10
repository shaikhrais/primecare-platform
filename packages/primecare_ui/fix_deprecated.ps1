$output = dart analyze
foreach ($line in $output) {
    if ($line -match "info - (.*?):\d+:\d+ - '(.*?)' is deprecated.*?Use (.*?) and") {
        $file = $matches[1].Trim()
        $old = $matches[2]
        $new = $matches[3]
        if (Test-Path $file) {
            Write-Host "Replacing $old with $new in $file"
            $content = Get-Content $file -Raw
            $content = $content.Replace($old, $new)
            Set-Content $file $content
        }
    }
}
