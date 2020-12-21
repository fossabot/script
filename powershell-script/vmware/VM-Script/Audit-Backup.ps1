. "$PSScriptRoot\Configuration.ps1"

function Audit-Backup {

    param ($server, $credential, $vm, $path, $condition)
    Connect-VIServer -Server $server -Credential $credential

    foreach ($line in $vm) {

	    $query = Get-Template -Name '*' | Where-Object { $_.Name -like $condition -and $_.name -like ('*' + $line) } | Sort-Object -Property Name | Select-Object Name
	    $count = $line + ' = ' + @($query).Count
	    $query | Out-File $Path -Append
	    $count | Out-File $Path -Append
		
    }

    Disconnect-VIServer -Server $server -Confirm:$false

}

Audit-Backup -server $server -credential $credential -vm $vm_daily -path $path_audit_daily -condition $condition_daily
Audit-Backup -server $server -credential $credential -vm $vm_weekly -path $path_audit_weekly -condition $condition_weekly
Audit-Backup -server $server -credential $credential -vm $vm_monthly -path $path_audit_monthly -condition $condition_monthly