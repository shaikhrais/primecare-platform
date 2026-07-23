Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
 = [System.Windows.Forms.SystemInformation]::VirtualScreen
 = .Width
 = .Height
 = .Left
 = .Top
 = New-Object System.Drawing.Bitmap , 
 = [System.Drawing.Graphics]::FromImage()
.CopyFromScreen(, , 0, 0, .Size)
.Save("appsprimecare_marketingintegration_testscreenshot_stress_test.dart", [System.Drawing.Imaging.ImageFormat]::Png)
.Dispose()
.Dispose()
