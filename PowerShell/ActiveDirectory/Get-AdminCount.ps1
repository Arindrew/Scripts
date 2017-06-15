Import-Module ActiveDirectory

### Computer Section ###
# Pull Computers with the 'AdminCount' attribute set and save to a file
Get-ADComputer -Filter {adminacount -gt 0} -Properties admincount | 
Select Name | Out-File "Computer_PathtoFile.txt"

# Remove empty lines and trailing whitespace
Get-Content "Computer_PathtoFile.txt" | ? {$_.trim() -ne "" } | Set-Content "Computer_PathtoFile2.txt"

# Remove 'AdminCount' attribute from all objects in the file
ForEach ($computer in Get-Content "Computer_PathtoFile2.txt") {Set-ADComputer $computer -Clear AdminCount }

### User Section ###
# Pull Users with the 'AdminCount' attribute set and save to a file
Get-ADUser -Filter {admincount -gt 0} -Properties adminCount | 
Select SAMAccountName | Out-File "User_PathtoFile.txt"

# Remove 'empty lines and trailing whitespace
Get-Content "User_PathtoFile.txt" | ? {$_.trim() -ne "" } | ForEach {$_.TrimEnd()} | Set-Content "User_PathtoFile2.txt"

# Remove 'AdminCount' attribute from all objects in the file
ForEach ($user in Get-Content "User_PathtoFile2.txt") { Set-ADUser $user -Clear AdminCount }