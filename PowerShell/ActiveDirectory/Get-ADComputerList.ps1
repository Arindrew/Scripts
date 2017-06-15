Import-Module ActiveDirectory

Get-ADComputer -Filter * | ft Name