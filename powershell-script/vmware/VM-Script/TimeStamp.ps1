. "$PSScriptRoot\Configuration.ps1"
Connect-VIServer -Server $server -Credential $credential

$note = Read-Host 'Note'

if (!$note -eq '') {

	$timestamp = $date_audit + ' -- ' + $note

} else {

	$timestamp = $date_audit + ' -- CHECK SCRIPT BACKUP OK'

}

$timestamp | Out-File $path_audit_ccc -Append

Disconnect-VIServer -Server $server -Confirm:$false