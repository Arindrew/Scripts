Import-Module ActiveDirectory
Get-ADComputer -filter * |
ForEach-Object {
    Get-WmiObject win32_PhysicalMedia -computer $_.name } |
    Format-Table __Server, Tag, SerialNumber |
    Out-File -FilePath "HDDresults.txt" -Append