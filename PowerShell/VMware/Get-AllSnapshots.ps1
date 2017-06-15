Get-VM | Get-Snapshot | Format-List VM, Description, Created, Name

Get-VM | Get-Snapshot | Where {$_.Name -match "Test"} | Remove-Snapshot -Confirm:$true