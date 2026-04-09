using System.IO
using System.Text.RegularExpressions

$path = 'c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_v4\lib\offices'
$files = Get-ChildItem -Path $path -Filter '*.dart' -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Replace page_template
    $newContent = [Regex]::Replace($content, "import\s+'(\.\./)+components/page_template\.dart';", "import 'package:primecare_v4/shared/components/page_template.dart';")
    
    # Replace clinical_glass
    $newContent = [Regex]::Replace($newContent, "import\s+'(\.\./)+components/clinical_glass\.dart';", "import 'package:primecare_v4/design_system/clinical_glass.dart';")

    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated $($file.FullName)"
    }
}
