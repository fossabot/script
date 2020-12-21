. "$PSScriptRoot\Configuration.ps1"

function Delete-Backup {

    param ($server, $credential, $vm, $lastdate, $policy)
    Connect-VIServer -Server $server -Credential $credential

    foreach ($line in $vm) {
    
	    try {
		    $lastvm = 'Backup-' + $policy + '-' + $lastdate + '-' + $line
		    Remove-Template -Template $lastvm -DeleteFromDisk -Confirm:$false -ErrorAction Stop

	    } catch {

		    $ErrorMessage = $_.Exception.Message
			$FailedItem = $_.Exception.ItemName
		    $error += $line + "`r`n"

	    }

    }

    Disconnect-VIServer -Server $server -Confirm:$false

}

Delete-Backup -server $server -credential $credential -vm $vm_daily -lastdate $lastdate_daily -policy 'Daily'
Delete-Backup -server $server -credential $credential -vm $vm_weekly -lastdate $lastdate_weekly -policy 'Weekly'
Delete-Backup -server $server -credential $credential -vm $vm_monthly -lastdate $lastdate_monthly -policy 'Monthly'