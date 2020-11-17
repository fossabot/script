# VMware Powershell Script
Documentation for administrator vmware and organization not have money

# Sturcture Path
#### Credential
This folder keep credential of VMware ESXi include username and hash password for run script task schedule without input password

#### VM-Audit
This folder keep recheck and timestamp by manual
* recheck (folder seperate by frequency backup)
* timestamp (text file is ccc.txt)

Note : CCC (Client Confirmation Checklist) 

#### VM-List
This folder keep list vm name for backup seperate text file by frequency backup
* daily.txt (retention 7 days)
* weekly.txt (retention 4 weeks)
* monthly.txt (retention 4 months)

#### VM-Script
This folder keep powershell script for run script task schedule seperate script file by frequency backup and type of run script seperate by one time, task schedule and manual
* audit script (manual)
* backup script (task schedule)
* check script (task schedule)
* create credentail script (one time)
* delete script (task schedule)
* report datastore script (task schedule)
* report vm script (task schedule)
* timestamp (manual)

## License
Codeinsane License.