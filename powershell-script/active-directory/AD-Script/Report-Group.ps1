. "$PSScriptRoot\Configuration.ps1"

$path = $path_group

$query = Get-ADGroup -Filter * | Get-ADGroupMember | Select-Object Name, objectClass, distinguishedname
$query | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8