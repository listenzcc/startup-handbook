
# function RegisterCompletions([string[]] $commands, $param, $target) {
#   Register-ArgumentCompleter -CommandName $commands -ParameterName $param -ScriptBlock $target
# }
# RegisterCompletions Set-Location-MyEnhance 'Path' { CompletePaths -dirsOnly @args }

function Search-Everything {
    # Search files using everything
    [cmdletBinding()]
    param (
        $search = ".md"
        , $path = "."
    )
    everything -search $search -path $path
}

function MyServer {
    # Login to $ServerIP as $ServerUser
    # $args commands will be operated if being provided
    [cmdletBinding()]
    param (
        $Cmd = ''
        , $User = $serverUser
        , $Ip = $serverIP
    )
    Write-Output "ssh -l $User $Ip $Cmd"
    ssh -l $User $Ip $Cmd
}

function Start-Bgd-Job {
    # Start background job
    [cmdletBinding()]
    param(
        $Method
    )

    # Start jupyter as background job
    if ($Method -eq "jupyter") {
        Write-Output 'Starting juptyerlab'
        Start-Job -ScriptBlock { Set-Location $using:pwd; jupyter-lab.exe . }
    }
}

function Remove-Bgd-Jobs {
    # Remove all jobs by force
    # It means kill the job and remove it from the pool
    # Show State Before Remove
    Write-Output 'Before:'
    Get-Job
    # Remove jobs
    Get-Job | Select-Object id | Remove-Job -Force
    # Show State After Remove
    Write-Output 'After:'
    Get-Job
}

function Find-Files-By {
    # Find all the files ends with $ext
    # if not provide $depth,
    # we will use 3 for instead.
    [CmdletBinding()]
    param(
        $Ext = ".txt"
        , $Depth = 1
    )

    Write-Output "----  Finding $Ext files with Depth of $Depth ----"

    Get-ChildItem -Depth $depth -Recurse | Where-Object { $_.Extension -eq $ext } | Sort-Object FullName
}

function Invoke-CapsLockPlus () {
    # Invoke CapsLockPlus
    # I assume the software has been installed on the ~/Documents/capslock-plus
    Invoke-Command -ScriptBlock { set-location $env:HOME\Documents\capslock-plus; .\CapsLock+.ahk }
}

function Get-ChildItem-MyEnhance {
    # Enhancement of Get-ChildItem method
    # It will produce "MegaByte" and "RelativeName" properties for Get-ChildItem
    [CmdletBinding()]
    param(
        $Path = $pwd.path
        , $Depth = 0
        , $Exclude = ""
        , [switch]$Recurse
    )

    $gc = Get-ChildItem -Path $Path -Depth $Depth -Recurse

    $gc | Select-Object Mode, LastWriteTime, FileSize, @{Name = "RelativeName"; Expression = { (resolve-path -relative $_.fullname).Replace(".\", "") } }
}

# Load and Save Command History
$HistoryPath = "$env:USERPROFILE\PSHistory.csv"
$saveHistoryScriptBlock = {
    Get-History | Select-Object -Last 100 | Export-Csv -Path "${HistoryPath}"
}
If (Test-Path "${HistoryPath}") {
    Import-Csv "${HistoryPath}" | Add-History
}
Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action $saveHistoryScriptBlock

# Execute History Command
function Invoke-HistoryMyEnhance {
    param($cmd)
    Write-Output Excuting: $cmd
    Invoke-Expression $cmd
}

$getHistoryScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    return Get-History | Sort-Object -Descending | Where-Object { $_.CommandLine -like "$wordToComplete*" }
}
Register-ArgumentCompleter -CommandName Invoke-HistoryMyEnhance -ParameterName 'cmd' -ScriptBlock $getHistoryScriptBlock


function Set-Location-MyEnhance {
    # Require,
    # module: cd-extras

    # I don't know why,
    # but after putting the CmdletBinding parameters DO prevent the files being auto-completed to the path's value

    [CmdletBinding(
        DefaultParameterSetName = 'Path',
        SupportsTransactions = $true,
        HelpUri = 'https://go.microsoft.com/fwlink/?LinkID=113397')
    ]
    param(
        # Default $Path
        [Parameter(ParameterSetName = 'Path', Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string] ${Path}
    )

    # CD to $Path and prompt
    if ($Path) {
        Set-LocationEx $Path
    }
    else {
        Set-LocationEx ~
    }
    $path = $pwd.path
    write-output "Changed location to $path"

    # Append the $path,
    # into the END of the file
    $path >> $env:HOME/.cd-trace
}

function Get-LocationTrace {
    # Require,
    # module: cd-extras

    # Get trace history
    $lst = Get-Content $env:HOME/.cd-trace

    # Reverse the trace
    [array]::Reverse($lst)
    # Remove the duplicated rows,
    # the first occurs are kept
    $lst = ($lst | Select-Object -Unique)
    # Reverse back the trace
    [array]::Reverse($lst)
    $lst = ($lst | Select-Object -Last 9)
    # See what we have got
    # write-output $lst $lst.Length
    For ($i = 0; $i -lt $lst.Length; $i++) {
        $j = $lst.Length - $i
        $e = $lst[$i]
        Write-Output "[$j] $e"
    }

    # Interaction
    # If user input nothing for $select,
    # the default $path value will be null,
    # thus the location will be not changed
    $select = Read-Host -Prompt 'CD to'
    # Add the If-option to keep the folder if nothing is selected.
    if ($select) {
        try {
            $path = $lst[$lst.Length - $select]
            # Write-Output $path
            Set-Location-MyEnhance $path
        }
        catch {
            Write-Output ':: Select Nothing with error.'
        }
    }
    else {
        Write-Output ':: Select Nothing.'
    }
}

Function Get-DirectoryTreeSize {
    <#
    .SYNOPSIS
        This is used to get the file count, subdirectory count and folder size for the path specified. The output will show the current folder stats unless you specify the "AllItemsAndAllFolders" property.
        Since this uses Get-ChildItem as the underlying structure, this supports local paths, network UNC paths and mapped drives.

    .NOTES
        Name: Get-DirectoryTreeSize
        Author: theSysadminChannel
        Version: 1.0
        DateCreated: 2020-Feb-11


    .LINK
        https://thesysadminchannel.com/get-directory-tree-size-using-powershell -


    .PARAMETER Recurse
        Using this parameter will drill down to the end of the folder structure and output the filecount, foldercount and size of each folder respectively.

    .PARAMETER AllItemsAndAllFolders
        Using this parameter will get the total file count, total directory count and total folder size in MB for everything under that directory recursively.

    .EXAMPLE
        Get-DirectoryTreeSize "C:\Some\Folder"

        Path            FileCount DirectoryCount FolderSizeInMB
        ----            --------- -------------- --------------
        C:\Some\folder          3              3          0.002

    .EXAMPLE
        Get-DirectoryTreeSize "\\MyServer\Folder" -Recurse

        Path                 FileCount DirectoryCount FolderSizeInMB
        ----                 --------- -------------- --------------
        \\MyServer\Folder            2              1         40.082
        .\Subfolder                  1              0         26.555

    .EXAMPLE
        Get-DirectoryTreeSize "Z:\MyMapped\folder" -AllItemsAndAllFolders

        Path                  TotalFileCount TotalDirectoryCount TotalFolderSizeInMB
        ----                  -------------- ------------------- -------------------
        Z:\MyMapped\folder                 3                   1              68.492

    #>

    [CmdletBinding(DefaultParameterSetName = "Default")]
    param(
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [string]  $Path,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "ShowRecursive"
        )]
        [switch]  $Recurse,
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "ShowTopFolderAllItemsAndAllFolders"
        )]
        [switch]  $AllItemsAndAllFolders
    )

    BEGIN {
        #Adding a trailing slash at the end of $path to make it consistent.
        if (-not $Path.EndsWith('\')) {
            $Path = "$Path\"
        }
    }

    PROCESS {
        try {
            if (-not $PSBoundParameters.ContainsKey("AllItemsAndAllFolders") -and -not $PSBoundParameters.ContainsKey("Recurse")) {
                $FileStats = Get-ChildItem -Path $Path -File -ErrorAction Stop | Measure-Object -Property Length -Sum
                $FileCount = $FileStats.Count
                $DirectoryCount = Get-ChildItem -Path $Path -Directory | Measure-Object | select -ExpandProperty Count
                $SizeMB = "{0:F3}" -f ($FileStats.Sum / 1MB) -as [decimal]

                [PSCustomObject]@{
                    Path           = $Path#.Replace($Path,".\")
                    FileCount      = $FileCount
                    DirectoryCount = $DirectoryCount
                    FolderSizeInMB = $SizeMB
                }
            }

            if ($PSBoundParameters.ContainsKey("AllItemsAndAllFolders")) {
                $FileStats = Get-ChildItem -Path $Path -File -Recurse -ErrorAction Stop | Measure-Object -Property Length -Sum
                $FileCount = $FileStats.Count
                $DirectoryCount = Get-ChildItem -Path $Path -Directory -Recurse | Measure-Object | select -ExpandProperty Count
                $SizeMB = "{0:F3}" -f ($FileStats.Sum / 1MB) -as [decimal]

                [PSCustomObject]@{
                    Path                = $Path#.Replace($Path,".\")
                    TotalFileCount      = $FileCount
                    TotalDirectoryCount = $DirectoryCount
                    TotalFolderSizeInMB = $SizeMB
                }
            }

            if ($PSBoundParameters.ContainsKey("Recurse")) {
                Get-DirectoryTreeSize -Path $Path
                $FolderList = Get-ChildItem -Path $Path -Directory -Recurse | select -ExpandProperty FullName

                if ($FolderList) {
                    foreach ($Folder in $FolderList) {
                        $FileStats = Get-ChildItem -Path $Folder -File | Measure-Object -Property Length -Sum
                        $FileCount = $FileStats.Count
                        $DirectoryCount = Get-ChildItem -Path $Folder -Directory | Measure-Object | select -ExpandProperty Count
                        $SizeMB = "{0:F3}" -f ($FileStats.Sum / 1MB) -as [decimal]

                        [PSCustomObject]@{
                            Path           = $Folder.Replace($Path, ".\")
                            FileCount      = $FileCount
                            DirectoryCount = $DirectoryCount
                            FolderSizeInMB = $SizeMB
                        }
                        #clearing variables
                        $null = $FileStats
                        $null = $FileCount
                        $null = $DirectoryCount
                        $null = $SizeMB
                    }
                }
            }
        }
        catch {
            Write-Error $_.Exception.Message
        }

    }

    END {}

}


$getExtensions = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    Get-ChildItem -Recurse -Depth 1 -File | Where-Object { $_.FullName -NotLike '*\.*' } | Select-Object Extension | Sort-Object Extension | get-unique -AsString | Where-Object { $_.Extension -like "$wordToComplete*" } | ForEach-Object { $_.Extension }
}
Register-ArgumentCompleter -CommandName Get-FilesByExtension -ParameterName 'Extension' -ScriptBlock $getExtensions

function Get-FilesByExtension {
    # Binding Parameters
    [CmdletBinding()]
    param(
        [Parameter(
            Position = 0
        )]
        [string] $Extension
        , $Depth = 2
        , $Exclude = ""
    )

    # Echo the Current Job
    Write-Output "Selecting Extension of $Extension"

    # If Extension is Empty, all the Available Extension are listed
    if ($Extension -eq "") {
        Get-ChildItem -Recurse -Depth $Depth -File | Where-Object { $_.FullName -NotLike '*\.*' } | Group-Object Extension | Sort-Object Count
        return
    }

    # If Extension is Inputed, all the Files with the Extension are listed
    $all = Get-ChildItem -Recurse -Depth $Depth -File | Where-Object { $_.FullName -NotLike '*\.*' } | Select-Object FullName, Name, LastWriteTime, Extension | Group-Object Extension

    $select = $all | Where-Object { $_.Name -like $Extension } | Select-Object Group

    $select.Group | Select-Object Name, LastWriteTime, fullname, extension | Sort-Object LastWriteTime
}

$ScriptPath = $script:MyInvocation.MyCommand.Path


Set-Item Alias:cd Set-Location-MyEnhance
Remove-Item Alias:wget
Set-Alias cdt Get-LocationTrace
Update-TypeData -AppendPath $ScriptPath\\..\\type\\fileTypeEnhance.ps1xml # -verbose

function MyFunctions() {
    # The script is
    Write-Output "Script is $ScriptPath"
    # List all my custom functions
    Write-Output "Search-Everything       `t: Search files using everything"
    Write-Output "MyServer                `t: Access my Server Quickly"
    Write-Output "Start-Bgd-job           `t: Start Background Job"
    Write-Output "Remove-Bgd-Jobs         `t: Remove All Background Jobs"
    Write-Output "Find-Files-By           `t: Find Subfiles with their Extensions"
    Write-Output "Invoke-CapsLockPlus     `t: Invoke CapsLockPlus"
    Write-Output "Get-ChildItem-MyEnhance `t: List Files with their FileSize"
    Write-Output "Set-Location-MyEnhance  `t: Enhanced cd command, cd and record the pwd after"
    Write-Output "Get-LocationTrace       `t: Enhanced cdt command, list history path and cd to the selected"
    Write-Output "Get-DirectoryTreeSize   `t: Get Directory Leafs and its Size"
}

Write-Output 'Custom Apps have been loaded, type "MyFunctions" to see them.'
