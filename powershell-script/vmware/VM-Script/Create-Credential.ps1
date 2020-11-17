. "$PSScriptRoot\Configuration.ps1"
Get-Credential –Credential $logon | Export-Clixml $path_credential