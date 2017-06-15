$Hostname = Read-Host -Prompt 'Computer Name'

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $Hostname | ft MACAddress,Description