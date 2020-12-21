. "$PSScriptRoot\Configuration.ps1"

function Check-Backup {

    param ($server, $credential, $vm, $path, $condition)
    Connect-VIServer -Server $server -Credential $credential

    foreach ($line in $vm) {

	    $query = Get-Template -Name '*' | Where-Object { $_.Name -like $condition -and $_.name -like ('*' + $line) } | Sort-Object -Property Name | Select-Object Name
	    $count = $line + ' = ' + @($query).Count
	    $query | Out-File $path -Append
	    $count | Out-File $path -Append
		
    }

    Disconnect-VIServer -Server $server -Confirm:$false

}

Check-Backup -server $server -credential $credential -vm $vm_daily -path $path_check_daily -condition $condition_daily
Check-Backup -server $server -credential $credential -vm $vm_weekly -path $path_check_weekly -condition $condition_weekly
Check-Backup -server $server -credential $credential -vm $vm_monthly -path $path_check_monthly -condition $condition_monthly