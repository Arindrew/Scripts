#Requires -RunAsAdministrator

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0
Stop-Process -processname explorer -Force

Remove-Item $env:USERPROFILE\AppData\Local\IconCache.db

Remove-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" -Name IconStreams
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" -Name PastIconStreams

Start-Process explorer.exe