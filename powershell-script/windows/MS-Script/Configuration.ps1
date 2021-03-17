Import-module msrcsecurityupdates

# General Setting
$Global:root = "C:\powershell-script\"
$Global:date = Get-Date -Format yyyyMMdd
$Global:month = Get-Date -Format MMM
$Global:year = Get-Date -Format yyyy
$Global:interest = $year + '-' + $month

# MS-Path
$Global:path_video = 'E:\Video'

# MS-Report
$Global:report_msrc = $root + 'MS-Report\MSRC\MSRC-' + $date + '.html'

# MSRC
$Global:secret_key = 'IOOcQITxbtHaLJ9QMXqRFm2vfaDhvwIdCQg8v9z2T9n'