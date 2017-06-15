Import-Module ActiveDirectory

Get-ADComputer -filter * | ForEach-Object {
    Get-WmiObject Win32_PhysicalMedia -computer $_.name } |
    Format-Table __Server, Tag, SerialNumber | 
    Out-File -Append -FilePath "PathtoExportedFile.txt"