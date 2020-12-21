. "$PSScriptRoot\Configuration.ps1"

function Report-Backup {

    param ($server, $credential, $vm, $report, $powerbi, $policy, $retention)
    Connect-VIServer -Server $server -Credential $credential

    foreach ($line in $vm) {
	
	    $name = 'Backup-' + $policy + '-' + '*' + $line
	    $query = Get-Template -Name $name | Sort-Object Name | Select Name,
		    @{N="Backup"; E={$line}},
		    @{N="Policy"; E={$policy}},
		    @{N="Retention"; E={$retention}},
		    @{N="NumCpu"; E={$_.ExtensionData.Config.Hardware.NumCPU}},
		    @{N="MemoryMB"; E={$_.ExtensionData.Config.Hardware.MemoryMB}},
		    @{N="HardDiskSizeGB"; E={($_ | Get-HardDisk | Measure-Object -Sum CapacityGB).Sum}},
            @{N='ProvisionedSpaceGB'; E={(Get-VM -Name $line | Select @{N='ProvisionedSpaceGB'; E={[math]::Round($_.ProvisionedSpaceGB, 2 )}}).ProvisionedSpaceGB}},
            @{N='UsedSpaceGB'; E={(Get-VM -Name $line | Select @{N='UsedSpaceGB'; E={[math]::Round($_.UsedSpaceGB, 2 )}}).UsedSpaceGB}}

	    $query | Export-Csv -Path $report -NoTypeInformation -Append
	    $query | Export-Csv -Path $powerbi -NoTypeInformation -Append

    }

    Disconnect-VIServer -Server $server -Confirm:$false

}

Remove-Item -path $powerbi_backup

Report-Backup -server $server -credential $credential -vm $vm_daily -report $report_backup -powerbi $powerbi_backup -policy 'Daily' -retention 7
Report-Backup -server $server -credential $credential -vm $vm_weekly -report $report_backup -powerbi $powerbi_backup -policy 'Weekly' -retention 4
Report-Backup -server $server -credential $credential -vm $vm_monthly -report $report_backup -powerbi $powerbi_backup -policy 'Monthly' -retention 3