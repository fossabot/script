. "$PSScriptRoot\Configuration.ps1"

function Notification-Gmail {

    $EmailFrom = 'sendfrom@gmail.com'
    $EmailTo = 'sendto@gmail.com'
    $Subject = 'Powershell Notification'
    $Body = 'Test'
    $SMTPServer = 'smtp.gmail.com'
    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 25)
    $SMTPClient.EnableSsl = $true
    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential('account@gmail.com', 'password');
    $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)

}

Notification-Gmail