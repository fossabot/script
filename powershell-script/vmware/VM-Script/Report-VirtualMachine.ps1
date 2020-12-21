. "$PSScriptRoot\Configuration.ps1"

function Report-VirtualMachine {

    param ($server, $credential, $report, $powerbi)
    Connect-VIServer -Server $server -Credential $credential

    $query = Get-VM -Name '*' | Sort-Object Name | Select-Object Name, PowerState, Folder, VMHost, NumCpu, MemoryMB,
	    @{N="UsedSpaceGB"; E={$_.UsedSpaceGB -as [int]}},
	    @{N="HardDiskSizeGB"; E={((Get-HardDisk -VM $_ | Measure-Object -Sum CapacityGB).Sum) -as [int]}},
	    @{N="Cluster"; E={$_.VMHost.Parent}},
	    @{N="ResourcePool";E={[string]::Join(',',(Get-ResourcePool -Id $_.ResourcePoolId | Select -ExpandProperty Name))}},
	    @{N="IPaddress";E={$_.Guest.IpAddress[0]}},
 	    @{N="GuestOS";E={$_.Guest.OSFullName}},
	    @{N="Datastore";E={[string]::Join(',',(Get-Datastore -Id $_.DatastoreIdList | Select -ExpandProperty Name))}},
	    @{N="CreateBy";E={$_.CustomFields.Item('CreateBy')}},
	    @{N="CreateOn";E={$_.CustomFields.Item('CreateOn')}},
        @{N="Department";E={$_.CustomFields.Item('Department')}},
        @{N="Environment";E={$_.CustomFields.Item('Environment')}},
	    @{N="Owner";E={$_.CustomFields.Item('Owner')}},
        @{N="Status";E={$_.CustomFields.Item('Status')}},
	    @{N="Notes";E={$_.value.Notes}}

    $query | Export-Csv -Path $report -NoTypeInformation
    $query | Export-Csv -Path $powerbi -NoTypeInformation
    Disconnect-VIServer -Server $server -Confirm:$false

}

Report-VirtualMachine -server $server -credential $credential -report $report_vm -powerbi $powerbi_vm