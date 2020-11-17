Import-Module VMware.VimAutomation.Core

# VMware Parameter
$Global:root = "C:\powershell-script\"
$Global:date = Get-Date -Format yyyyMMdd
$Global:server = 'vcsa.lab.local'
$Global:vmhost = '10.10.10.20'
$Global:datacenter = 'Datacenter'
$Global:cluster = 'Cluster'
$Global:resourcepool = 'Resourcepool'
$Global:datastore = 'Datastore'
$Global:folder_daily = 'Daily'
$Global:folder_weekly = 'Weekly'
$Global:folder_monthly = 'Monthly'
$Global:folder_archive = 'Archive'

# Credential
$Global:logon = 'LAB\administrator'
$Global:credential = Import-clixml ($root + 'Credential\vcsa.lab.local.clixml')
$Global:path_credential = $root + 'Credential\vcsa.lab.local.clixml'

# VM-List
$Global:vm_daily = Get-Content ($root + 'VM-List\Daily.txt')
$Global:vm_weekly = Get-Content ($root + 'VM-List\Weekly.txt')
$Global:vm_monthly = Get-Content ($root + 'VM-List\Monthly.txt')
$Global:vm_archive = Get-Content ($root + 'VM-List\Archive.txt')
$Global:vm_ova = Get-Content ($root + 'VM-List\OVA.txt')

# VM-Log
$Global:path_log_daily = $root + 'VM-Log\Daily\Backup-Daily-' + $date + '.log'
$Global:path_log_weekly = $root + 'VM-Log\Weekly\Backup-Weekly-' + $date + '.log'
$Global:path_log_monthly = $root + 'VM-Log\Monthly\Backup-Monthly-' + $date + '.log'
$Global:path_log_archive = $root + 'VM-Log\Archive\Backup-Archive-' + $date + '.log'

# VM-Check
$Global:path_check_daily = $root + 'VM-Check\Daily\Check-Daily-' + $date + '.txt'
$Global:path_check_weekly = $root + 'VM-Check\Weekly\Check-Weekly-' + $date + '.txt'
$Global:path_check_monthly = $root + 'VM-Check\Monthly\Check-Monthly-' + $date + '.txt'

# VM-Audit
$Global:path_audit_daily = $root + 'VM-Audit\Daily\Audit-Daily-' + $date + '.txt'
$Global:path_audit_weekly = $root + 'VM-Audit\Weekly\Audit-Weekly-' + $date + '.txt'
$Global:path_audit_monthly = $root + 'VM-Audit\Monthly\Audit-Monthly-' + $date + '.txt'

# VM-Export
$Global:path_export_ova = $root + 'VM-Export\OVA\'

# VM-Report
$Global:report_servicetag = $root + 'VM-Report\ServiceTag\ServiceTag-' + $date + '.csv'
$Global:report_vm = $root + 'VM-Report\VM\Report-VM-' + $date + '.csv'
$Global:report_datastore = $root + 'VM-Report\Datastore\Report-Datastore-' + $date + '.csv'

# PowerBI
$Global:powerbi_vm = $root + 'PowerBI\Dataset\Dataset-VM.csv'
$Global:powerbi_datastore = $root + 'PowerBI\Dataset\Dataset-Datastore.csv'

# TimeStamp
$Global:path_audit_ccc = $root + 'VM-Audit\CCC.txt'

# Data Retention
$Global:lastdate_daily = (Get-Date (Get-Date).AddDays(-7) -Format yyyyMMdd)
$Global:lastdate_weekly = (Get-Date (Get-Date).AddDays(-28) -Format yyyyMMdd)
$Global:lastdate_monthly = (Get-Date (Get-Date).AddMonths(-3) -Format yyyyMMdd)

# Line Notification
$Global:secret_key = 'IOOcQITxbtHaLJ9QMXqRFm2vfaDhvwIdCQg8v9z2T9n'
$Global:all = 0
$Global:success = 0