Import-Module ActiveDirectory

# AD Parameter
$Global:root = "C:\powershell-script\"
$Global:date = Get-Date -Format yyyyMMdd
$Global:server = 'lab-dc.lab.local'
$Global:domain = 'DC=lab,DC=local'

# Report-User
$Global:path_user = $root + 'AD-Report\User\User-' + $date + '.csv'

# Report-Group
$Global:path_group = $root + 'AD-Report\Group\Group-' + $date + '.csv'

# Report-GroupMember
$Global:path_groupmember = $root + 'AD-Report\GroupMember\GroupMember-' + $date + '.csv'

# vCard
$Global:path_vCard = $root + 'AD-Report\vCard\vCard-' + $date + '.vcf'