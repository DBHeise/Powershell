$logFolder = Join-Path $pwd $env:computername
if (!(Test-Path $logFolder)) { mkdir $logFolder | Out-Null }

$logFile = Join-Path $logFolder "log.txt"
Add-Type -AssemblyName System.Core

#Beging Logging information
[DateTime]::Now.ToString() | Add-Content $logFile
gci env: | % { $_.Name + ' = ' + $_.Value } | Add-Content $logFile

#Backup Security Event Log First
$outputFile = Join-Path $logFolder "sec.evtx"
wevtutil epl Security $outputFile
#$els = New-Object System.Diagnostics.Eventing.Reader.EventLogSession
#$els.ExportLogAndMessages("Security", [System.Diagnostics.Eventing.Reader.PathType]::LogName, "*", $outputFile, $false, [System.Globalization.CultureInfo]::CurrentCulture)

#Backup the AuditPolicy Settings
$backupAuditFile = Join-Path $logFolder 'audit.backup.csv'
auditpol /backup /file:$backupAuditFile

#Alter the Security Event Log
Limit-EventLog -LogName Security -MaximumSize 1GB
Clear-EventLog -LogName Security

#New Audit Settings
$SubCategories2Enable = @("System Integrity", "Logon", "Logoff", "Account Lockout", "Other System Events", "Special Logon", "Other Logon/Logoff Events", "Network Policy Server", "File System", "Registry", "Kernel Object", "Certification Services", "Application Generated", "File Share", "Process Creation", "Process Termination", "RPC Events", "Audit Policy Change", "Authentication Policy Change", "Authorization Policy Change", "Other Policy Change Events", "User Account Management", "Computer Account Management", "Security Group Management", "Distribution Group Management", "Application Group Management", "Other Account Management Events", "Directory Service Access", "Directory Service Changes", "Credential Validation", "Kerberos Service Ticket Operations", "Other Account Logon Events", "Kerberos Authentication Service" )
$SubCategories2Disable = @("IPsec Driver", "IPsec Main Mode", "IPsec Quick Mode", "IPsec Extended Mode", "SAM", "Handle Manipulation", "Filtering Platform Packet Drop", "Filtering Platform Connection", "Other Object Access Events", "Sensitive Privilege Use", "Non Sensitive Privilege Use", "Other Privilege Use Events", "DPAPI Activity", "MPSSVC Rule-Level Policy Change", "Filtering Platform Policy Change", "Directory Service Replication", "Detailed Directory Service Replication")

$SubCategories2Enable | % { auditpol /get /subcategory:$_ | Add-Content $logFile }
$SubCategories2Disable | % { auditpol /get /subcategory:$_ | Add-Content $logFile }

$SubCategories2Enable | % { auditpol /set /subcategory:$_ /success:enable /failure:enable | Out-Null }
$SubCategories2Disable | % { auditpol /set /subcategory:$_ /success:disable /failure:disable | Out-Null }