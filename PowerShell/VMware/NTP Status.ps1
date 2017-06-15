Get-VMhost | Sort Name | Select Name,
@{N="NTPServer";E={$_ | Get-VMHostNtpServer}},
@{N="ServiceRunning";E={Get-VMhostService -VMHost $_ | Where-Object {$_.key -eq "ntpd"}).Running}}

# Add-VMHostNtpServer -VMHost VMhost.FQDN -NtpServer "NTP1.FQDN, NTP2.FQDN"
# Get-VMHostService -VMHost VMhost.FQDN | Where-Object {$_.key -eq "ntpda"} | Start-VMHostService | Set-VMHostService -policy on