. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

$vm = $vm_daily
$path = $path_audit_daily
$condition = $condition_daily

foreach ($line in $vm) {

	#$query = Get-VM -Name '*' | Where-Object { $_.Name -like $condition -and $_.name -like ('*' + $line) } | Sort-Object -Property Name | Select-Object Name
	$query = Get-Template -Name '*' | Where-Object { $_.Name -like $condition -and $_.name -like ('*' + $line) } | Sort-Object -Property Name | Select-Object Name
	$count = $line + ' = ' + @($query).Count
	$query | Out-File $Path -Append
	$count | Out-File $Path -Append
		
}

Disconnect-VIServer -Server $server -Confirm:$false