$WScript = New-Object -ComObject WScript.Shell

$ErrorActionPreference = 'SilentlyContinue'

$wd = "$env:OneDriveCommercial\\Desktop"

$files = ls -File $wd
$dirs = ls -Directory $wd | ForEach-Object {Get-Item $_.FullName}

$targets = $files | ForEach-Object {Get-Item $WScript.CreateShortcut($_.FullName).TargetPath} 

$found = ls $targets

$found += ls $dirs

$all = $found | ForEach-Object {ls $_.FullName -File -Recurse}

$output = $all | Where-Object {!$_.FullName.contains('\.git\')}
$output = $output | Where-Object {!$_.FullName.contains('\__pycache__\')}

$output