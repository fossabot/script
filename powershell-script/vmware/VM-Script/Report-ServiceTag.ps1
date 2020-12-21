. "$PSScriptRoot\Configuration.ps1"

function Report-ServiceTag {

	param ($server, $credential, $path)
    Connect-VIServer -Server $server -Credential $credential

    $query = New-Object System.Collections.ArrayList
    $list = Get-View -ViewType HostSystem -Property Name, Hardware.SystemInfo

    foreach ($line in $list) {

	    $hostname = $line.Name
	    $oem = $line.Hardware.SystemInfo.Vendor
	    $model = $line.Hardware.SystemInfo.Model
	    $service_tag = $($line.Hardware.SystemInfo.OtherIdentifyingInfo | where {$_.IdentifierType.Key -eq "ServiceTag" }).IdentifierValue

	    $obj = New-Object PSObject
	    $obj | Add-Member -MemberType NoteProperty -Name VMHost -Value $hostname
	    $obj | Add-Member -MemberType NoteProperty -Name OEM -Value $oem
	    $obj | Add-Member -MemberType NoteProperty -Name Model -Value $model
	    $obj | Add-Member -MemberType NoteProperty -Name ServiceTag -Value $service_tag
	    $query.Add($obj)

    }

    $query | Export-Csv -Path $path -NoTypeInformation
    Disconnect-VIServer -Server $server -Confirm:$false

}

Report-ServiceTag -server $server -credential $credential -path $report_servicetag