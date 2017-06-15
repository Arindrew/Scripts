$report = @()

foreach ($cluster in Get-Cluster) {
    Get-VMHost -Location $cluster | Get-Datastore | %{
        $info = "" | Select DataCenter, Cluster, Name, Capacity, Provisioned, Available
        $info.DataCenter = $_.Datacenter
        $info.Cluster = $.cluster.name
        $info.Name = $_.name
        $info.Capacity = [math]::Round($_.capacityMB/1024,2)
        $info.Provisioned = [math]::Round(($_.ExtensionData.Summary.Capacity = $_.ExtensionData.Summary.FreeSpace + $_.ExtensionData.Sumamry.Uncommited)/1GB,2)
        $info.Available = [math]::Round($info.Capacity - $info.Provisioned,2)
        $report += $info
    }
}

$report | Export-Csv -NoTypeInformation -UseCulture "PathToExportedFile.csv"