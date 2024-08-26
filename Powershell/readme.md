# Powershell Can-be-Used Scripts

- Author: Chuncheng Zhang
- Date: 2021-03-01
- Version: 0.0

## Description

The collection is used to provide some functionality scripts,
to make powershell **basically human useable**.

## Contains

- customApps.ps1: The main script.
- type/fileTypeEnhance.ps1xml: The config xml file to enhance file type.

## Typical Using

The script and the config file are used to initialize to powershell terminal,
they are used in the startup script,
the [profile.ps1] start-up file in my case.

```powershell
# Basic setup
$serverIP = '----'
$serverUser = '----'
$scriptFolder = "$env:OneDrive\Scripts\Powershell"

# Using config file
Update-TypeData -AppendPath $scriptFolder\type\\fileTypeEnhance.ps1xml -verbose

# Run the script
. "$scriptFolder\customApps.ps1"
```
