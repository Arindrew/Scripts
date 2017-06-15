$Domain = Get-ADComputer -filter * | Select -ExpandProperty Name

Write-Host -ForegroundColor Yellow "===== Parsing Computers in the Domain ====="
ForEach ($computer in $Domain) {
    if (Test-Connection -cn $computer -count 1 -Quiet) {
        Get-WmiObject -Class Win32_UserAccount -ComputerName $computer -Filter "LocalAccount='True'" |
        Select PSComputerName, Name, SID | Export-CSV -Append "PathToExport"
    }
    else {
        Write-Host -ForegroundColor Red "$computer" is offline
        Write-Host " "
    }
}