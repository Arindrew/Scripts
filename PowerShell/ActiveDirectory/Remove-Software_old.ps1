Get-WMIObject -Class Win32_Product | Where-Object {$_.Name -match "McAfee VirusScan Enterprise"} | Select-Object Name

Get-WmiObject -ComputerName "ComputerName" -Class Win32_Product | Where-Object {$_.Name -match "McAfee*"} | ft PSComputerName, Name

$app = Get-WmiObject -ComputerName "ComputerName" -Class Win32_Product | Where-Object {$_.Name -match "McAfee VirusScan Enterprise"}
$app.uninstall()
ft PSComputerName, Name

# $ComputerName = Read-Host -Prompt 'Computer Name'
<#
ForEach ($ComputerName in Get-Content H:\Scripts\PowerShell\Import\computers.txt) {
    Get-WMIObject -Computername "$ComputerName" -Class Win32_Product | 
    Where-Object {$_.Name -match "McAfee*"} | 
    ft PSComputerName,Name
    }
#>