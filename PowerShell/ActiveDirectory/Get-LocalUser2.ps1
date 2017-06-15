function Get-LocalAdmin {
    param ($strcomputer)

    $admins = Get-WmiObject Win32_GroupUser -computer $strcomputer
    $admins = $admins | ? {$_.groupcomponent -like '*"Administrator"'}

    $admins |% {
        $_.partcomponent -match ".+Domain\=(.+)\,Name\=(.+)$" > $null
        $matches[1].trim('"') + "\" + $matches[2].trim('"')
    }
}

$Domain = Get-ADComputer -filter * | Select -ExpandProperty Name

Write-Host -ForegroundColor Yellow "===== Parsing Computers in the Domain ====="

ForEach ($computer in $domain) {
    $admins = Get-LocalAdmin $computer
    ForEach ($admin in $admins) {
        $str = "$computer,$admin"
        $str | Out-File "PathToOutputFile" - Append
    }
}