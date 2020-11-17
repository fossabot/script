. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

$report = $report_datastore
$powrebi = $powerbi_datastore

$query = Get-Datastore | Where {$_.type -eq "VMFS"} | Select Name,  
    	@{N="CanonicalName"; E={($_.ExtensionData.Info.Vmfs.Extent[0]).DiskName}},
	@{N="DisplayName"; E={(Get-ScsiLun -CanonicalName ($_.ExtensionData.Info.Vmfs.Extent[0]).DiskName -VMHost (Get-VIObjectByVIView $_.ExtensionData.Host[0].Key)).ExtensionData.DisplayName}},
	Id, CapacityGB,
	@{N='Datastore Used Space GB'; E={[math]::Round($_.CapacityGB - $_.FreeSpaceGB)}},
  	@{N='VM Space Used GB'; E={ [math]::Round((($_ | Get-VM | Select -Expand UsedSpaceGB | measure -Sum).Sum) + 
   	((($_ | Get-Template).ExtensionData.Summary.Storage.Committed | measure -Sum).Sum) / 1GB) } },
  	@{N='VM Space Provisioned GB'; E={ [math]::Round((($_ | Get-VM | Select -Expand ProvisionedSpaceGB | measure -Sum).Sum) +
	((($_ | Get-Template).ExtensionData.Summary.Storage.Uncommitted | measure -Sum).Sum) / 1GB) } },
	@{N="VM / All"; E={@($_ | Get-VM).Count}},
	@{N="VM / ON"; E={@($_ | Get-VM | Where-Object {$_.PowerState -eq "PoweredOn"}).Count}},
	@{N="VM / OFF"; E={@($_ | Get-VM | Where-Object {$_.PowerState -eq "PoweredOff"}).Count}},
	@{N="VM / Backup"; E={@($_ | Get-VM | Where-Object {$_.Name -like "Backup*"}).Count}},
	@{N="Template / All"; E={@($_ | Get-Template).Count}}
	@{N="Month"; E={$month}},
	@{N="Year"; E={$year}} |
Where-Object {$_.DisplayName -notlike 'Local*'} | Sort Name

$query | Export-Csv -Path $report -NoTypeInformation
$query | Export-Csv -Path $powrebi -Append -NoTypeInformation

Disconnect-VIServer -Server $server -Confirm:$false