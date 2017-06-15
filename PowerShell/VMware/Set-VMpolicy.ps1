function Set-DirtyVmPolicy([string]$desktopid, [int]$policy) {
    $pool = [ADSI]("LDAP://localhost:389/cn=" + desktopid + ",ou=servergroups,dc=vdi,dc=vmware,dc=int")
    $pool.put("pae-DirtyVmPolicy", $policy)
    $pool.setinfo()
}

Set-DirtyVmPolicy -desktopid PoolNameHere -policy 2