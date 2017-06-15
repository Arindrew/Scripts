$computers = Import-CSV "H:\Scripts\PowerShell\Import\Computerlist.csv"
$array = $()

foreach ($pc in $computers){
    $computername=$pc.computername

    #Define the variable to hold the location of 'Currently Installed Programs'
    $UninstallKey="Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall"

    #Create an instance of the Registry Object and open the HKLM base key
    $reg=[microsoft.win32.registrykey]::OpenRemoteBaseKey('LocalMachine',$computername)

    #Drill down into the Uninstall key using the OpenSubKey Method
    $regkey=$reg.OpenSubKey($UninstallKey)

    #Retrieve an array of string that contains all the subkey names
    $subkey=$regkey.GetSubKeyNames()

    #Open each Subkey and use GetValue Method to return the required values for each
    foreach ($key in $subkeys){
        $thisKey=$UninstallKey+"\\"+$key
        $thisSubKey=$reg.OpenSubKey($thisKey)
        $obj = New-Object PSObject
        $obj = Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $computername
        $obj = Add-Member -MemberType NoteProperty -Name "DisplayName" -Value $($thisSubKey.GetValue("DisplayName"))
        $obj = Add-Member -MemberType NoteProperty -Name "DisplayVersion" -Value $($thisSubKey.GetValue("DisplayVersion"))
        $obj = Add-Member -MemberType NoteProperty -Name "InstallLocation" -Value $($thisSubKey.GetValue("InstallLocation"))
        $obj = Add-Member -MemberType NoteProperty -Name "Publisher" -Value $($thisSubKey.GetValue("Publisher"))
        $array += $obj
    }
}
$array | Where-Object { $_.DisplayName } | Select ComputerName, DisplayName, DisplayVersion, Publisher | ft -Auto