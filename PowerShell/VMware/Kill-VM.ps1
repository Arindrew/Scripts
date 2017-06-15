Function Kill-VM {
    <#
    .SYNOPSIS Kills a virtual machine
    .DESCRIPTION Kills a virtual machine at the lowest level, use when Stop-VM fails.
    .PARAMETER VM the virtual machine to kill
    .PARAMETER KillType The type of kill operation to attempt. There are three types of VM kills that can be attempted: soft, hard, and force
    Users should attempt 'soft' kills first, which will give the VMX process a chance to shutdown cleanly (like kill or kill -SIGTERM)
    If that does not work, move to a 'hard' kill, which will shutdown the process immediately (like kill -9 or kill -SIGKILL)
    If that does not work, move to a 'force' kill, which should be used as a last resort attempt to kill the VM. If all three fail then a reboot is required.
    .EXAMPLE PS C:\> Kill-VM (Get-VM VM1) -KillType soft

    .EXAMPLE PS C:\> Get-VM VM1 | Kill-VM

    .EXAMPLE PS C:\> Get-VM VM1 | Kill-VM -Killtype hard
    #>

param (
    [Parameter(mandatory=$true, Position=0, ValueFromPipeline=$true)]
    $VM, $KillType
)

Process {
    if ($VM.PowerState -eq "PoweredOff") {
        Write-Host "$($VM.Name) is already powered off"
    }
    else {
        $esxcli = Get-ESXCli -vmhost ($VM.VMhost)
        $WorldID = ($esxcli.vm.process.list() | Where {_.DisplayName -eq $VM.Name}).WorldID
        if (-not $KillType) {
            $KillType = "soft"
        }
        $result = $esxcli.vm.process.kill($KillType, WorldID)
        if ($result -eq "true") {
            Write-Host "$($VM.Name) killed via a $KillType kill"
        }
        else {
            $result
        }
    }
}