. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

$report = $report_vm
$powrebi = $powerbi_vm

$query = Get-VM -Name '*' | Sort-Object Name | Select Name, PowerState, NumCpu, MemoryMB,
	@{N="UsedSpaceGB"; E={$_.UsedSpaceGB -as [int]}},
	@{N="HardDiskSizeGB"; E={((Get-HardDisk -VM $_ | Measure-Object -Sum CapacityGB).Sum) -as [int]}},
	@{N="ResourcePool";E={[string]::Join(',',(Get-ResourcePool -Id $_.ResourcePoolId | Select -ExpandProperty Name))}},
	@{N="IPaddress";E={$_.Guest.IpAddress[0]}},
 	@{N="GuestOS";E={$_.Guest.OSFullName}},
	@{N="Datastore";E={[string]::Join(',',(Get-Datastore -Id $_.DatastoreIdList | Select -ExpandProperty Name))}}

$query | Export-Csv -Path $report -NoTypeInformation
$query | Export-Csv -Path $powrebi -NoTypeInformation

Disconnect-VIServer -Server $server -Confirm:$false