. 'C:\Program Files\Microsoft\Exchange Server\v14\bin\RemoteExhange.ps1'
Connect-ExchangeServer -auto

Get-MailboxStatistics -Server ExchangeServer |
Select DisplayName, ItemCount, TotalItemSize |
Sort-Object TotalItemSize -Descending |
Export-Csv "PathtoExportFile.csv"