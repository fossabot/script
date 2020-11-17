. "$PSScriptRoot\Configuration.ps1"

$path = $path_user
$dc = $domain
$ou = 'OU=NIDA'

$query = Get-ADUser -Filter * -SearchBase "$ou,$dc" -Properties * | Select-Object sAMAccountName,givenName,sn,mail,employeeType,company,Department,@{n='OU';e={$_.distinguishedname -replace "CN=$($_.cn),",""}}
$query | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8