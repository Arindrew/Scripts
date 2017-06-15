New-VIProperty -Name ProductFullName -ObjectType VMHost -ValueFromExtensionProperty Config.Product.FullName
New-VIProperty -Name AssetTag2 -ObjectType VMHost -Value { param($vmhost); $vmhost.ExtensionData.Summary.Hardware.OtherIdentifyingInfo[2].IdentifierValue }
Neq-VIProperry -Name AssetTag6 -ObjectType VMHost -Value { param($vmhost); $vmhost.ExtensionData.Summary.Hardware.OtherIdentifyingInfo[6].IdentifierValue }

$report = @()

foreach ($vmhost in Get-VMHost) {
    $info = "" | Select AssetTag2, AssetTag6, Name, Model, ProcessorType, MemoryTotalGB, ProductFullName
    if ($vmhost.AssetTag6 -eq $null) {
        $info.AssetTag2 = $vmhost.AsssetTag2
    }
    else {
        $info.AssetTag6 = $vmhost.AssetTag6
    }
    $info.Name = $vmhost.Name
    $info.Model = $vmhost.Model
    $info.ProcessorType = $vmhost.ProcessorType
    $info.MemoryTotalGB = [math]::round($vmhost.MemoryTotalGB,0)
    $info.ProductFullName = $vmhost.ProductFullName
    $report += $info
}

$report | Export-Csv -NoTypeInformation -Path "PathToExportedFile.csv"