# Connect to the VI Server
$VIServers = "vCenterServer.FQDN"
# Query for the VM guests
$VMGuestList = Get-VM
# Loop through the VM guests, if the VM is installed on a Windows VM, set the VM Tools upgrade checkbox to true and the Sync Time checkbox to false
ForEach ($VMGuest in $VMGuestList) {
    if ($VM.guest.OSFullName -like *Windows*) {
        $spec = New-Object VMware.VIM.VirtualMachineConfigSpec
        $spec.changeVersion = $VMGuest.ExtensionData.Config.ChangeVersion
        $spec.tools = New-Object VMware.VIM.ToolsConfigInfo
        $spec.tools.toolsUpgradePolicy = "upgradeAtPowerCycle"
        $spec.tools.syncTimeWithHost = $false
        # Apply the changes
        $MyVM = Get-View -ID $VMGuest.ID
        $MyVM.ReconfigVM_Task($spec)
    }
}