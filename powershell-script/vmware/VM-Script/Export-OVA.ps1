. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

$vm = $vm_ova
$path = $path_export_ova
$datastore = $datastore

foreach ($line in $vm) {

	$name = 'Export-OVA-' + $date + '-' + $line
	$dsdc = Get-Datastore $datastore -Datacenter $datacenter

	try {

		New-VM -Name $name -VM $line -VMHost $vmhost -Datastore $dsdc -ResourcePool $resourcepool -ErrorAction Stop
		Get-VM -Name $line | Export-VApp -Destination $path -Format Ova
		Remove-VM $name -DeleteFromDisk -Confirm:$false -ErrorAction Stop

	} catch {

		# $ErrorMessage = $_.Exception.Message
    		# $FailedItem = $_.Exception.ItemName
		# $error += $line + "`r`n"

	}

}

Disconnect-VIServer -Server $server -Confirm:$false

