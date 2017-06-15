Import-Module ActiveDirectory

$Username = Read-Host -Prompt 'Users Logon Name'
Set-ADUser -Identity "$Username" -HomeDirectory "\\focusedsupport.com\DFS\Personal\$env:USERNAME"