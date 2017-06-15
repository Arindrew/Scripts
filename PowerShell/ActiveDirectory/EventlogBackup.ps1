#requires -version 3.0
#remote computer must be running PowerShell 3.0

$computers = "Computer1","Computer2"
$cred = Get-Credential Domain\Account
$eventlog = "Application"

Invoke-Command -ScriptBlock {
    $log = Get-WmiObject win32_nteventlogfile -Filter "logfilename = '$using:eventlog'"
    $file = "{0}_{1}_{2}.evtz" -f (get-date -f "yyyyMMdd"),$log.CSName,$log.FileName.Replace("","")

    #map a PSDrive with credentials
    New-PSDrive -name B -PSProvider FileSystem -Root \\RemoteShare\Path\to\Directory -Credential $using:cred | Out-Null

    #backup path must be something Windows can see like a UNC
    $backup = join-path (Get-PSDrive B).root $false
    Write-Host "Backing up to $backup" -ForegroundColor Cyan
    $r = $log | Invoke-WmiMethod -Name BackupEventLog -ArgumentList $backup
    if ($r.returnvalue -eq 0) {
        Get-Item $backup
    }
    else {
        Throw "Backup files with returnvalue $($r.returnvalue)"
    }
} -ComputerName $computers