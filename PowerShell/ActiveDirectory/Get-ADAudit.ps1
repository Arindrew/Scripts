AD-Audit -Filter 'useraccountcontrol -band 65536' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\U_Dont_Expire_Pwd.csv"
Get-ADComputer -Filter 'useraccountcontrol -band 65536' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\C_Dont_Expire_Pwd.csv"

AD-Audit -Filter 'useraccountcontrol -band 32' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\U_Password_Not_Reqd.csv"
Get-ADComputer -Filter 'useraccountcontrol -band 32' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\C_Password_Not_Reqd.csv"

AD-Audit -Filter 'useraccountcontrol -band 128' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\U_Encrypted_Text_Password_Allowed.csv"
Get-ADComputer -Filter 'useraccountcontrol -band 128' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\C_Encrypted_Text_Password_Allowed.csv"

AD-Audit -Filter 'useraccountcontrol -band 524288' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\U_Trusted_For_Delegation.csv"
Get-ADComputer -Filter 'useraccountcontrol -band 524288' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\C_Trusted_For_Delegation.csv"

AD-Audit -Filter 'useraccountcontrol -band 4194304' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\U_Dont_Require_Preauth.csv"
Get-ADComputer -Filter 'useraccountcontrol -band 4194304' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\C_Dont_Require_Preauth.csv"

AD-Audit -Filter 'useraccountcontrol -band 2097152' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\U_Use_DES_Key_Only.csv"
Get-ADComputer -Filter 'useraccountcontrol -band 2097152' -Properties useraccountcontrol | Export-Csv "$env:USERNAME\Desktop\C_Use_DES_Key_Only.csv"