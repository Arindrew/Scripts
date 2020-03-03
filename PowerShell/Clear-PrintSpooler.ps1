Function New-EncryptionKey { 

<#

.SYNOPSIS
Clears the Print Spooler cache. 

.DESCRIPTION
The Print-Spooler cmdlet stops the Print Spooler service, clears the service's cache and restarts the service

.EXAMPLE 
PS C:\> Clear-PrintSpooler.ps1

.NOTES 
Author:          Andrew S. Keller
Email:           arindrew@pm.me
Date:            2020-03-03
Version:         1.0

.LINK 
Online Version: https://github.com/Arindrew/Scripts/blob/master/PowerShell/Clear-PrintSpooler.ps1
#> 

#Stop Print Spooler Service
Stop-Service Spooler

#Confirm Print Spooler Service is stopped
Get-Service Spooler

#Remove items in Print Spooler cache folder
Remove-Item $env:SystemRoot\system32\spool\printers\*.shd
Remove-Item $env:SystemRoot\system32\spool\printers\*.spl

#Confirm items in Print Spooler cache folder are removed
Get-ChildItem $env:SystemRoot\system32\spool\printers\

#Sart Print Spooler service
Start-Service Spooler

#Confirm Print Spooler Service is started
Get-Service Spooler

} #Function
