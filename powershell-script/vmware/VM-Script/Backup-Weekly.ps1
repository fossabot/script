. "$PSScriptRoot\Configuration.ps1"

function Backup-VirtualMachine {

    param ($server, $credential, $vm, $path, $folder, $datastore, $policy)
    Connect-VIServer -Server $server -Credential $credential

    foreach ($line in $vm) {

	    $name = 'Backup-' + $policy + '-' + $date + '-' + $line
	    $dsdc = Get-Datastore $datastore -Datacenter $datacenter
	    $all += 1

	    try {

		    $backup = New-VM -Name $name -VM $line -VMHost $vmhost -Datastore $dsdc -ResourcePool $resourcepool -Location $folder -ErrorAction Stop
		    $backup | Out-File $path -Append

		    Get-VM -Name $name | Set-VM -ToTemplate -Confirm:$false

		    $query = Get-VM -Name $line | select Name, VMHost, GuestId, NumCpu, MemoryMB -ErrorAction Stop
		    $query | Out-File $path -Append

		    $count += 1

	    } catch {

		    $ErrorMessage = $_.Exception.Message
    	    $FailedItem = $_.Exception.ItemName
		    $error += $line + "`r`n"

	    }

    }

    . "$PSScriptRoot\Notification-Line.ps1" -policy $policy -all $all -count $count
           
    Disconnect-VIServer -Server $server -Confirm:$false

}

Backup-VirtualMachine -server $server -credential $credential -vm $vm_weekly -path $path_log_weekly -folder $folder_weekly -datastore $datastore_backup -policy 'Weekly'