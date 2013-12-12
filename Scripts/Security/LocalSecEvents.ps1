#Turn on the auditing
auditpol /set /subcategory:"Security State Change" /success:enable /failure:enable 
auditpol /set /subcategory:"Security System Extension" /success:enable /failure:enable
auditpol /set /subcategory:"System Integrity" /success:enable /failure:enable
auditpol /set /subcategory:"IPsec Driver" /success:disable /failure:disable
auditpol /set /subcategory:"Other System Events" /success:enable /failure:enable
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Logoff" /success:enable /failure:enable
auditpol /set /subcategory:"Account Lockout" /success:enable /failure:enable
auditpol /set /subcategory:"IPsec Main Mode" /success:disable /failure:disable
auditpol /set /subcategory:"IPsec Quick Mode" /success:disable /failure:disable
auditpol /set /subcategory:"IPsec Extended Mode" /success:disable /failure:disable
auditpol /set /subcategory:"Special Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Other Logon/Logoff Events" /success:enable /failure:enable
auditpol /set /subcategory:"Network Policy Server" /success:enable /failure:enable
auditpol /set /subcategory:"File System" /success:enable /failure:enable
auditpol /set /subcategory:"Registry" /success:enable /failure:enable
auditpol /set /subcategory:"Kernel Object" /success:enable /failure:enable
auditpol /set /subcategory:"SAM" /success:disable /failure:disable
auditpol /set /subcategory:"Certification Services" /success:enable /failure:enable
auditpol /set /subcategory:"Application Generated" /success:enable /failure:enable
auditpol /set /subcategory:"Handle Manipulation" /success:disable /failure:disable
auditpol /set /subcategory:"File Share" /success:enable /failure:enable
auditpol /set /subcategory:"Filtering Platform Packet Drop" /success:disable /failure:disable
auditpol /set /subcategory:"Filtering Platform Connection" /success:disable /failure:disable
auditpol /set /subcategory:"Other Object Access Events" /success:disable /failure:disable
auditpol /set /subcategory:"Sensitive Privilege Use" /success:disable /failure:disable
auditpol /set /subcategory:"Non Sensitive Privilege Use" /success:disable /failure:disable
auditpol /set /subcategory:"Other Privilege Use Events" /success:disable /failure:disable
auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable
auditpol /set /subcategory:"Process Termination" /success:enable /failure:enable
auditpol /set /subcategory:"DPAPI Activity" /success:disable /failure:disable
auditpol /set /subcategory:"RPC Events" /success:enable /failure:enable
auditpol /set /subcategory:"Audit Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Authentication Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Authorization Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"MPSSVC Rule-Level Policy Change" /success:disable /failure:disable
auditpol /set /subcategory:"Filtering Platform Policy Change" /success:disable /failure:disable
auditpol /set /subcategory:"Other Policy Change Events" /success:enable /failure:enable
auditpol /set /subcategory:"User Account Management" /success:enable /failure:enable
auditpol /set /subcategory:"Computer Account Management" /success:enable /failure:enable
auditpol /set /subcategory:"Security Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Distribution Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Application Group Management" /success:enable /failure:enable
auditpol /set /subcategory:"Other Account Management Events" /success:enable /failure:enable
auditpol /set /subcategory:"Directory Service Access" /success:enable /failure:enable
auditpol /set /subcategory:"Directory Service Changes" /success:enable /failure:enable
auditpol /set /subcategory:"Directory Service Replication" /success:disable /failure:disable
auditpol /set /subcategory:"Detailed Directory Service Replication" /success:disable /failure:disable
auditpol /set /subcategory:"Credential Validation" /success:enable /failure:enable
auditpol /set /subcategory:"Kerberos Service Ticket Operations" /success:enable /failure:enable
auditpol /set /subcategory:"Other Account Logon Events" /success:enable /failure:enable
auditpol /set /subcategory:"Kerberos Authentication Service" /success:enable /failure:enable




#Look for these events...
$eventIds = @(1102, 1104, 1105, 1108, 4608, 4609, 4610, 4611, 4612, 4614, 4615, 4616, 4621, 4622, 4624, 4625, 4634, 4647, 4648, 4649, 4657, 4663, 4670, 4671, 4672, 4675, 4688, 4689, 4695, 4696, 4697, 4698, 4699, 4700, 4701, 4702, 4704, 4705, 4706, 4707, 4713, 4714, 4715, 4716, 4717, 4718, 4719, 4720, 4722, 4723, 4724, 4725, 4726, 4727, 4728, 4729, 4730, 4731, 4732, 4733, 4734, 4735, 4737, 4738, 4739, 4740, 4741, 4742, 4743, 4744, 4745, 4746, 4747, 4748, 4749, 4750, 4751, 4752, 4753, 4754, 4755, 4756, 4757, 4758, 4759, 4760, 4761, 4762, 4763, 4764, 4767, 4768, 4769, 4770, 4771, 4774, 4775, 4776, 4778, 4779, 4780, 4781, 4783, 4784, 4785, 4786, 4787, 4788, 4789, 4790, 4791, 4792, 4794, 4800, 4801, 4802, 4803, 4817, 4865, 4866, 4867, 4882, 4885, 4887, 4895, 4900, 4906, 4907, 4908, 4909, 4910, 4946, 4947, 4948, 4949, 4949, 4950, 4951, 4952, 4954, 4957, 4958, 4964, 5024, 5025, 5027, 5028, 5029, 5030, 5032, 5033, 5034, 5035, 5037, 5050, 5058, 5059, 5136, 5137, 5138, 5139, 5140, 5141, 5142, 5143, 5144, 5148, 5149, 5168, 5376, 5377, 6406, 6407, 6408)
$events = Get-EventLog -LogName Security -InstanceId $eventIds -After ([DateTime]::Today)
$events.Count
