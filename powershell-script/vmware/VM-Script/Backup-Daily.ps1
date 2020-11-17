. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

$vm = $vm_daily
$path = $path_log_daily
$folder = $folder_daily
$datastore = $datastore

foreach ($line in $vm) {

	$name = 'Backup-Daily-' + $date + '-' + $line
	$dsdc = Get-Datastore $datastore -Datacenter $datacenter
	$all += 1

	try {

		$backup = New-VM -Name $name -VM $line -VMHost $vmhost -Datastore $dsdc -ResourcePool $resourcepool -Location $folder -ErrorAction Stop
		$backup | Out-File $path -Append

		Get-VM -Name $name | Set-VM -ToTemplate -Confirm:$false

		$query = Get-VM -Name $line | select Name, VMHost, GuestId, NumCpu, MemoryMB -ErrorAction Stop
		$query | Out-File $path -Append

		$success += 1		

	} catch {

		# $ErrorMessage = $_.Exception.Message
    		# $FailedItem = $_.Exception.ItemName
		# $error += $line + "`r`n"

	}

}

if (!$error -eq '') {

	$msg = 'Daily : ' + $date + "`r`n" + 'All VM Backup : ' + $all + "`r`n" + 'Count VM Backup Successfully : ' + $success
	$uri = 'https://notify-api.line.me/api/notify'
	$token = 'Bearer ' + $secret_key
	$header = @{Authorization = $token}
	$body = @{message = $msg}
	$res = Invoke-RestMethod -Uri $uri -Method Post -Headers $header -Body $body 
	echo $res

}

Disconnect-VIServer -Server $server -Confirm:$false