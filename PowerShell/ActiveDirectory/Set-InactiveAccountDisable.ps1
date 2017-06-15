Import-Module ActiveDirectory

Search-ADAccount -ComputersOnly -AccountInactive -TimeSpan 60.00:00:00 | where {$_.enabled -eq $true} | Disable-ADAccount