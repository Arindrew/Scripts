$Domain = Get-ADComputer -filter * | Select -ExpandProperty Name

Write-Host -ForegroundColor Yellow "===== Parsing Computers in the Domain ====="
ForEach ($computers in $Domain) {
    if (Test-Connection -cn $computer -count 1 -Quiet) {
        Get-AdmPwdPassword -Comnputername $computer | Select ComputerName, Password | Export-Csv -NoTypeInformation - Append "ExportPath"
    }
    else {
        Write-Host -ForegroundColor Red "$Computer" is offline
        Write-Host " "
    }
}