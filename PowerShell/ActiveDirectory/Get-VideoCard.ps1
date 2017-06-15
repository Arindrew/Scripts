$AOR1Computers = Get-ADComputer -SearchBase "ActiveDirectoryPath" -SearchScope -2 -filter * | Select -ExpandProperty Name
$AOR2Computers = Get-ADComputer -SearchBase "ActiveDirectoryPath" -SearchScope -2 -filter * | Select -ExpandProperty Name
$AOR3Computers = Get-ADComputer -SearchBase "ActiveDirectoryPath" -SearchScope -2 -filter * | Select -ExpandProperty Name

$OutArray = @()

ForEach ($computer in $AOR1Computers) {
    $myobj = "" | Select "ComputerName","ComputerSystemProduct","VideoController"
    $myobj.ComputerName          = $computer
    $myobj.ComputerSystemProduct = Get-WmiObject -Class Win32_ComputerSystemProduct -ComputerName "$computer" | Select Name
    $myobj.VideoController       = Get-WmiObject -Class Win32_VideoController -ComputerName "$computer" | Select Name
    $OutArray += $myobj
    $myobj = $null
}

ForEach ($computer in $AOR2Computers) {
    $myobj = "" | Select "ComputerName","ComputerSystemProduct","VideoController"
    $myobj.ComputerName          = $computer
    $myobj.ComputerSystemProduct = Get-WmiObject -Class Win32_ComputerSystemProduct -ComputerName "$computer" | Select Name
    $myobj.VideoController       = Get-WmiObject -Class Win32_VideoController -ComputerName "$computer" | Select Name
    $OutArray += $myobj
    $myobj = $null
}

ForEach ($computer in $AOR3Computers) {
    $myobj = "" | Select "ComputerName","ComputerSystemProduct","VideoController"
    $myobj.ComputerName          = $computer
    $myobj.ComputerSystemProduct = Get-WmiObject -Class Win32_ComputerSystemProduct -ComputerName "$computer" | Select Name
    $myobj.VideoController       = Get-WmiObject -Class Win32_VideoController -ComputerName "$computer" | Select Name
    $OutArray += $myobj
    $myobj = $null
}

$OutArray | Export-Csv "PathToExportFile"