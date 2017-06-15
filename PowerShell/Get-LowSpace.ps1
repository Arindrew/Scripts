Import-Module ActiveDirectory
# Query each computer in the specified OU
Get-ADComputer -SearchBase "OUtoSearch" -SearchScope 1 -filter * | 
# Filter out the results to only pull the information on the drives of each computer
ForEach-Object {
    Get-WmiObject win32_logicaldisk -computer $_.name |
    # Filter only hard drives (no floppy or CD-ROM) and those with less than 10GiB free
    Where-Object {(_.DriveType -eq 3) -and ($_.FreeSpace -lt 10GB)} |
    # Format results to human readable numbers (GiB instead of just bytes)
    Select-Object SystemName, DeviceID, VolumeName,
    @{LABEL='GBfreespace';EXPRESSION={"{0:N2}" -f ($_.freespace/1GB)} },
    @{LABEL='GBsize';EXPRESSION={"{0:N2}" -f ($_.size/1GB)} } |
    # Output results to a text file
    Out-File "PathtoOutputFile.txt" -Append
}