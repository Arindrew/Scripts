Import-Module ActiveDirectory

$computers = Get-ADComputer -LDAPFilter "(objectclass=computer)" -SearchBase "dc=17rs,dc=nellis,dc=ic,dc=gov"

ForEach ($computer in $computers) {
    #Binding the users to DS
    $ou = [ADSI]("LDAP://" + $computer)
    $sec = $ou.psbase.objectSecurity

    if ($sec.get_AreAccessRulesProtected()) {
        $isProtected = $false ## allows interitance
        $preserveInheritance = $true ## preserve inheritance rules
        $sec.SetAccessRuleProtection($isProtected, $preserveInheritance)
        $ou.psbase.commitchanges()
        Write-Host -ForegroundColor DarkRed -BackgroundColor White "$computer is now inheriting permissions";
    }
    else {
        Write-Host -ForegroundColor DarkGreen -BackgroundColor White "$computer Inheritable Permissions already set";
    }
}