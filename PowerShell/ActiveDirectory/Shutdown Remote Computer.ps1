$PCName = Read-Host -Prompt 'Which computer would you like to shutdown?'

Stop-Computer -ComputerName "$PCName"