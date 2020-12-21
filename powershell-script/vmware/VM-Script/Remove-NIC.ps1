. "$PSScriptRoot\Configuration.ps1"

function Remove-NIC {

    param ($server, $credential, $condition)
    Connect-VIServer -Server $server -Credential $credential

    $nic = Get-NetworkAdapter -VM $condition
    Remove-NetworkAdapter -NetworkAdapter $nic

    Disconnect-VIServer -Server $server -Confirm:$false

}

$name = Read-Host 'VM Name'

Remove-NIC -server $server -credential $credential -condition $name