Stop-Service Spooler
Get-Service Spooler

Remove-Item $env:SystemRoot\system32\spool\printers\*.shd
Remove-Item $env:SystemRoot\system32\spool\printers\*.spl

Get-ChildItem $env:SystemRoot\system32\spool\printers\

Start-Service Spooler
Get-Service Spooler