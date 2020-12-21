. "$PSScriptRoot\Configuration.ps1"

function Export-CustomAttribute {

    param ($server, $credential, $path, $condition)
    Connect-VIServer -Server $server -Credential $credential

    $vm = Import-CSV $path

    foreach ($line in $vm) {

        If ($line.Name -eq $condition) {

            Get-VM -Name $line.Name | Set-Annotation -CustomAttribute "CreateBy" -Value $line.CreateBy
            Get-VM -Name $line.Name | Set-Annotation -CustomAttribute "CreateOn" -Value $line.CreateOn
            Get-VM -Name $line.Name | Set-Annotation -CustomAttribute "Department" -Value $line.Department
            Get-VM -Name $line.Name | Set-Annotation -CustomAttribute "Environment" -Value $line.Environment
            Get-VM -Name $line.Name | Set-Annotation -CustomAttribute "Owner" -Value $line.Owner
            Get-VM -Name $line.Name | Set-Annotation -CustomAttribute "Status" -Value $line.Status
            break
        
        }

    }

    Disconnect-VIServer -Server $server -Confirm:$false

}

$name = Read-Host 'VM Name'

Export-CustomAttribute -server $server -credential $credential -path $report_customattribute -condition $name