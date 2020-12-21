. "$PSScriptRoot\Configuration.ps1"

function Export-CustomAttribute {

    param ($server, $credential, $report)
    Connect-VIServer -Server $server -Credential $credential

    $query = Get-VM -Name '*' | Sort-Object Name | Select-Object Name, ID,
	    @{N="CreateBy";E={$_.CustomFields.Item('CreateBy')}},
	    @{N="CreateOn";E={$_.CustomFields.Item('CreateOn')}},
        @{N="Department";E={$_.CustomFields.Item('Department')}},
        @{N="Environment";E={$_.CustomFields.Item('Environment')}},
	    @{N="Owner";E={$_.CustomFields.Item('Owner')}},
        @{N="Status";E={$_.CustomFields.Item('Status')}}

    $query | Export-Csv -Path $report -NoTypeInformation
    Disconnect-VIServer -Server $server -Confirm:$false

}

Export-CustomAttribute -server $server -credential $credential -report $report_customattribute