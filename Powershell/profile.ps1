# Import-Module PersistentHistory
Import-Module cd-extras
Import-Module Dircolors

# Import-Module posh-git
# Import-Module Powertab
# Import-Module oh-my-posh
# Set-Theme Honukai

# Save Command History
$HistoryPath = "$(Split-Path $profile)/history.csv"
Import-Csv $HistoryPath | Add-History

Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action { Get-History | Select-Object -Last 100 | Export-Csv -Path $HistoryPath }

$scriptFolder = "$env:OneDriveConsumer\Scripts\Powershell"

. "$scriptFolder\customApps.ps1"
. "$scriptFolder\fanqiang.ps1"

# $env:Path = "C:\cygwin64\bin;$env:Path"

