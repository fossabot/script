. "$PSScriptRoot\Configuration.ps1"

function Notification-Line {

    param ($policy, $all, $count)

    $msg = $policy + ' : ' + $date + "`r`n" + 'All VM Backup : ' + $all + "`r`n" + 'Count VM Backup Successfully : ' + $count
    $uri = 'https://notify-api.line.me/api/notify'
    $token = 'Bearer ' + $secret_key
    $header = @{Authorization = $token}
    $body = @{message = $msg}
    $res = Invoke-RestMethod -Uri $uri -Method Post -Headers $header -Body $body 
    echo $res

}

Notification-Line -policy $policy -all $all -count $count