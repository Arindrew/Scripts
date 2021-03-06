$reportReg = @()
$Computers = Get-Content "C:\Path\to\Servers.txt"

ForEach ($Computers in $computers){
    If (Test-Connection -ComputerName $computer -Count 1 -ErrorAction 0){
        Try {
            # This is were the registry key is looked for on the remote server
            $RegLine = "" | Select ComputerName, RegistryKey
            $objReg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $Computer)
            $objRegKey = $objReg.OpenSubKey("SYSTEM\\CurrentControlSet\\Control\\Lsa")
            $RegLine.ComputerName = $Computer
            $RegLine.Registrykey = $objRegKey.GetValue("lmcompatibilitylevel")
            $reportReg += $RegLine
        }
        Catch {
            Write-Warning "Unable to reach $Computer, adding to bad list to look at later."
            $Computer | Add-Content "C:\Path\to\BadServers.txt"
            Continue
        }
    }
}