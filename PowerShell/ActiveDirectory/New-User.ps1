Import-Module ActiveDirectory

$Firstname = Read-Host -Prompt 'Users First Name'
$MI = Read-Host -Prompt 'Users Middle Initial'
$Lastname = Read-Host -Prompt 'Users Last Name'
$Rank = Read-Host -Prompt 'Users Rank'
$Squadron = Read-Host -Prompt 'Users Squadron (17 RS)'
$AOR = Read-Host -Prompt 'Users AOR (AOR1)'
$Expiration = Read-Host -Prompt 'Account Expiration Data (7/4/2016)'

New-ADUser -DisplayName "$LastName, $FirstName $MI $Rank $Squadron" -Enabled $true 
-Name "$LastName, $Firstname, $MI $Rank $Squadron" -path "OU=Users,OU=$AOR,DC=DOMAIN" 
-SamAccountName "$Firstname.$Lastname" -PasswordNotRequired $true -UserPrincipalName "$Firstname.$Lastname@DOMAIN"
-AccountExpirationDate "$Expiration" -ChangePasswordAtLogon $true -EmailAddress "$Firstname.$Lastname@DOMAIN"
-HomeDirectory "\\RemoteShare\Path\to\Home" -HomeDrive "P:" -GivenName "$FirstName" -Initials "$MI" -Surnamne "$Lastname"

If ($AOR -match "AOR1"){
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
}

If ($AOR -match "AOR2"){
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
}

If ($AOR -match "AOR3"){
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
    Add-ADGroupMember -Identity "Group Name" -Members "$Firstname.$Lastname"
}

$Session = NewPSSession -ConfigurationName Microsoft.Exchange -ConnectionURI ExchangeServer -Authentication Kerberos
Import-PSSession $Session -Verbose

Enable-Mailbox "$Firstname.$LastName@Domain" -Database "$AOR Users"
Set-Mailbox "$Firstname.$Lastname" -RecipientLimits 0