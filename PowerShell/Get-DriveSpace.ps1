Import-Module ActiveDirectory

Get-ADComputer -SearchBase "OU=OUtoSearch" -SearchScope 1 -filter * | 

ForEach-Object 
{
  Get-WmiObject win32_logicaldisk -computer $_.name |
  Select-Object SystemName, DeviceID, VolumeName,
  @{LABEL='GBfreespace';EXPRESSION={"{0:N2}" -f ($_.freespace/1GB)} },
  @{LABEL='GBSize';EXPRESSION={"{0:N2}" -f ($_.size/1GB)} } |
  Export-Csv "FileToExport.csv" -Append
}