. "$PSScriptRoot\Configuration.ps1"

$path = $path_groupmember
$query = New-Object System.Collections.ArrayList

$list = Get-ADGroup -Filter *

foreach ($ou in $list) {

	$member = Get-ADGroupMember -identity $ou

	foreach ($line in $member) {
		
		if($line.objectClass -eq "User") {

			$group = $ou.name
			$user = $line.samaccountname

			$obj = New-Object PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Group -Value $group
			$obj | Add-Member -MemberType NoteProperty -Name Member -Value $user
			$query.Add($obj)

		}

	}

}

$query | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8