. "$PSScriptRoot\Configuration.ps1"

function Report-Summary {

    param ($server, $credential, $path)
    Connect-VIServer -Server $server -Credential $credential

    $obj = New-Object System.Collections.ArrayList
    $Clusters = Get-Cluster
    $TotalClusters = (Get-Cluster).Count
    $TotalVMHosts = (Get-VMHost).Count
    $TotalVMs = (Get-VM).Count
    $TotalVMsON = (Get-VM | Where-Object {$_.PowerState -eq "PoweredOn"}).Count
    $TotalVMsOFF = (Get-VM | Where-Object {$_.PowerState -eq "PoweredOff"}).Count
    
    foreach ($Cluster in $Clusters) {
        $AverageVMsPerCluster = [math]::round(($TotalVMs / $TotalVMHosts), 1)
    }

    $obj.Add(@{'Server Name' = $DefaultVIServer; 'Total Cluster' = $TotalClusters; 'Total Host' = $TotalVMHosts; 'Total VM' = $TotalVMs; 'Total VM/ON' = $TotalVMsON; 'Total VM/OFF' = $TotalVMsOFF; 'Total VM/Host' = $AverageVMsPerCluster})

    foreach ($data in $obj) {
	    $data | Out-File $path -Append
    }

    Disconnect-VIServer -Server $server -Confirm:$false

}

Report-Summary -server $server -credential $credential -path $report_summary