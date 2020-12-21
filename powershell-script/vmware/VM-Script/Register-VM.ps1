. "$PSScriptRoot\Configuration.ps1"

function Register-VM {

    param ($server, $credential, $datastore, $condition)
    Connect-VIServer -Server $server -Credential $credential

    foreach ($line in $datastore) {

	    $ds = Get-Datastore -Name $datastore | %{Get-View $_.Id}
	    $SearchSpec = New-Object VMware.Vim.HostDatastoreBrowserSearchSpec
	    $SearchSpec.matchpattern = '*.vmx'
	    $dsBrowser = Get-View $ds.browser
	    $DatastorePath = '[' + $datastore + ']'
	    $SearchResult = $dsBrowser.SearchDatastoreSubFolders($DatastorePath, $SearchSpec) | where {$_.FolderPath -notmatch '.snapshot'} | %{$_.FolderPath + ($_.File | select Path).Path}

	    foreach ($vmx in $SearchResult) {

            if ($vmx -match $condition) {
                New-VM -VMFilePath $vmx -VMHost $vmhost -ResourcePool $resourcepool -Location $folder -RunAsync
                break
            }

	    }

    }

    Disconnect-VIServer -Server $server -Confirm:$false

}

$name = Read-Host 'VM Name'
$datastore = Read-Host 'DS Name'

Register-VM -server $server -credential $credential -datastore $datastore -condition $name