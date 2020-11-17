. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

foreach ($line_d in $vm_daily) {

	try {	

		$lastvm = 'Backup-Daily-' + $lastdate_daily + '-' + $line_d
		#$remove = Remove-VM $lastvm -DeleteFromDisk -Confirm:$false -ErrorAction Stop
		Remove-Template -Template $lastvm -DeleteFromDisk -Confirm:$false -ErrorAction Stop

	} catch {

		# $ErrorMessage = $_.Exception.Message
    		# $FailedItem = $_.Exception.ItemName
		# $error += $line + "`r`n"

	}

}

foreach ($line_w in $vm_weekly) {

	try {

		$lastvm = 'Backup-Weekly-' + $lastdate_weekly + '-' + $line_w
		#$remove = Remove-VM $lastvm -DeleteFromDisk -Confirm:$false -ErrorAction Stop
		Remove-Template -Template $lastvm -DeleteFromDisk -Confirm:$false -ErrorAction Stop

	} catch {

		# $ErrorMessage = $_.Exception.Message
    		# $FailedItem = $_.Exception.ItemName
		# $error += $line + "`r`n"

	}

}

foreach ($line_m in $vm_monthly) {

	try {

		$lastvm = 'Backup-Monthly-' + $lastdate_monthly + '-' + $line_m
		#$remove = Remove-VM $lastvm -DeleteFromDisk -Confirm:$false -ErrorAction Stop
		Remove-Template -Template $lastvm -DeleteFromDisk -Confirm:$false -ErrorAction Stop

	} catch {

		# $ErrorMessage = $_.Exception.Message
    		# $FailedItem = $_.Exception.ItemName
		# $error += $line + "`r`n"

	}	

}

Disconnect-VIServer -Server $server -Confirm:$false