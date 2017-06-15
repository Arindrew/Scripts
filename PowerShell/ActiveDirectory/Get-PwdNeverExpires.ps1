Import-Module ActiveDirectory

Search-ADAccount -PasswordNeverExpires -SearchBase "ActiveDirectoryPath" -SearchScope 1 | ft Name