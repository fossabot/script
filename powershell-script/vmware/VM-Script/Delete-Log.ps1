. "$PSScriptRoot\Configuration.ps1"

function Delete-Log {

    param ($path_check, $path_audit, $path_log, $lastdate, $policy)

    $path_check = $path_check + $policy
    $path_audit = $path_audit + $policy
    $path_log = $path_log + $policy

    $file_check = Get-ChildItem -Path $path_check -Recurse
    $file_audit = Get-ChildItem -Path $path_audit -Recurse
    $file_log = Get-ChildItem -Path $path_log -Recurse

    foreach ($line in $file_check) {

        $name = $line.Basename
        $word = $name -split "-"

        if ($word[2] -lt $lastdate) {
            $path = $path_check + '\' + $line
            Remove-Item -path $path
        }

    }

    foreach ($line in $file_audit) {

        $name = $line.Basename
        $word = $name -split "-"

        if ($word[2] -lt $lastdate) {
            $path = $path_audit + '\' + $line
            Remove-Item -path $path
        }

    }

    foreach ($line in $file_log) {

        $name = $line.Basename
        $word = $name -split "-"

        if ($word[2] -lt $lastdate) {
            $path = $path_log + '\' + $line
            Remove-Item -path $path
        }

    }

}

Delete-Log -path_check $path_delete_check -path_audit $path_delete_audit -path_log $path_delete_log -lastdate $lastdate_log -policy 'Archive'
Delete-Log -path_check $path_delete_check -path_audit $path_delete_audit -path_log $path_delete_log -lastdate $lastdate_log -policy 'Daily'
Delete-Log -path_check $path_delete_check -path_audit $path_delete_audit -path_log $path_delete_log -lastdate $lastdate_log -policy 'Weekly'
Delete-Log -path_check $path_delete_check -path_audit $path_delete_audit -path_log $path_delete_log -lastdate $lastdate_log -policy 'Monthly'