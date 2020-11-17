. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

$vm = $vm_weekly
$path = $path_check_weekly
$condition = $condition_weekly

foreach ($line in $vm) {

	#$query = Get-VM -Name '*' | Where-Object { $_.Name -like $condition -and $_.name -like ('*' + $line) } | Sort-Object -Property Name | Select-Object Name
	$query = Get-Template -Name '*' | Where-Object { $_.Name -like $condition -and $_.name -like ('*' + $line) } | Sort-Object -Property Name | Select-Object Name
	$count = $line + ' = ' + @($query).Count
	$query | Out-File $path -Append
	$count | Out-File $path -Append
		
}

Disconnect-VIServer -Server $server -Confirm:$false