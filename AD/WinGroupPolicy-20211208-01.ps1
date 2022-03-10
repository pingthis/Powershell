<#
## This script is to implment a QoS GPO.  It will work ONLY on machines that are part of a domain.  It must be executed on a domain controller.
##
## Type or paste the the following line into PowerShell before running this script to ensure scripts are allowed to run for this process only!!!!
## It is enclosed in a comment block, so it will have no effect when the script is run by PowerShell.
##
Set-ExecutionPolicy -Force -ExecutionPolicy Unrestricted -Scope Process
#>

## >>>>>>>>>>>> Script starts here <<<<<<<<<<<< ##

Import-Module ActiveDirectory,GroupPolicy

# ################# Create GPO to contain the QoS policy #################
New-GPO -Name "CABP_SW-RingCentral-VOIP" -Comment "QoS/DSCP markings for RingCentral traffic. Rev 20211208-01"
 
Set-GPPrefRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Context Computer -Key "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -ValueName "Do not use NLA" -Value "1" -Type String -Action Update

# ################# Real-Time Audio #################
Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-01-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "64.81.240.0", "20", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-01-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "64.81.240.0", "20", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-02-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "80.81.128.0", "20", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-02-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "80.81.128.0", "20", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-03-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "103.44.68.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-03-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "103.44.68.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-04-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "104.245.56.0", "21", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-04-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "104.245.56.0", "21", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-05-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "185.23.248.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-05-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "185.23.248.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-06-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "192.209.24.0", "21", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-06-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "192.209.24.0", "21", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-07-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "199.68.212.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-07-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "199.68.212.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-08-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "199.255.120.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-08-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "199.255.120.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-09-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "20000:64999", "*", "*", "*", "208.87.40.0", "22", "46", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-01-09-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "8803", "*", "*", "*", "208.87.40.0", "22", "46", "-1"

# ################# Real-Time Video #################
Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-01-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "64.81.240.0", "20", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-01-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "64.81.240.0", "20", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-02-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "80.81.128.0", "20", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-02-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "80.81.128.0", "20", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-03-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "103.44.68.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-03-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "103.44.68.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-04-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "104.245.56.0", "21", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-04-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "104.245.56.0", "21", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-05-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "185.23.248.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-05-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "185.23.248.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-06-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "192.209.24.0", "21", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-06-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "192.209.24.0", "21", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-07-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "199.68.212.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-07-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "199.68.212.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-08-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "199.255.120.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-08-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "199.255.120.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-09-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "UDP", "10000:19999", "*", "*", "*", "208.87.40.0", "22", "34", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-09-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "8801:8802", "*", "*", "*", "208.87.40.0", "22", "34", "-1"

#   PtP for RCM
Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-02-99-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "8850:8869", "*", "*", "*", "*", "*", "34", "-1"

# ################# Signaling #################
Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-01-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "64.81.240.0", "20", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-01-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "64.81.240.0", "20", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-01-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "64.81.240.0", "20", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-02-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "80.81.128.0", "20", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-02-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "80.81.128.0", "20", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-02-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "80.81.128.0", "20", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-03-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "103.44.68.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-03-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "103.44.68.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-03-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "103.44.68.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-04-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "104.245.56.0", "21", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-04-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "104.245.56.0", "21", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-04-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "104.245.56.0", "21", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-05-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "185.23.248.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-05-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "185.23.248.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-05-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "185.23.248.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-06-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "192.209.24.0", "21", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-06-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "192.209.24.0", "21", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-06-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "192.209.24.0", "21", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-07-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "199.68.212.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-07-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "199.68.212.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-07-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "199.68.212.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-08-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "199.255.120.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-08-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "199.255.120.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-08-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "199.255.120.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-09-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5090:5099", "*", "*", "*", "208.87.40.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-09-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP and UDP", "5060:5061", "*", "*", "*", "208.87.40.0", "22", "26", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-03-09-03" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "TCP", "8083:8090", "*", "*", "*", "208.87.40.0", "22", "26", "-1"

# ################# Miscellaneous #################
Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-01-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "64.81.240.0", "20", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-02-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "80.81.128.0", "20", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-03-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "103.44.68.0", "22", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-04-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "104.245.56.0", "21", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-05-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "185.23.248.0", "22", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-06-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "192.209.24.0", "21", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-07-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "199.68.212.0", "22", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-08-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "199.255.120.0", "22", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-09-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "*", "*", "*", "*", "*", "*", "208.87.40.0", "22", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-90-01" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "RingCentral.exe", "*", "*", "*", "*", "*", "*", "*", "18", "-1"

Set-GPRegistryValue -Name "CABP_SW-RingCentral-VOIP" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\CABP_SW-RingCentral-VOIP-99-90-02" `
	-ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate"	`
	-Type String -Value "1.0", "Softphone.exe", "*", "*", "*", "*", "*", "*", "*", "18", "-1"



# SIG # Begin signature block
# MIIJ/QYJKoZIhvcNAQcCoIIJ7jCCCeoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUXd5InsHWzvG4yT01XyeQqoGU
# rkqgggdIMIIHRDCCBfigAwIBAgITTQAAEvSglQ3PtvqKrgABAAAS9DBBBgkqhkiG
# 9w0BAQowNKAPMA0GCWCGSAFlAwQCAQUAoRwwGgYJKoZIhvcNAQEIMA0GCWCGSAFl
# AwQCAQUAogMCASAwZzETMBEGCgmSJomT8ixkARkWA2NvbTEbMBkGCgmSJomT8ixk
# ARkWC2d1YXJkaWFuYnBnMRUwEwYKCZImiZPyLGQBGRYFaW50cmExHDAaBgNVBAMT
# E2ludHJhLUdOVkwtQ0ExLUNBLTEwHhcNMjIwMTA1MjEyNTA1WhcNMjMwMTA1MjEy
# NTA1WjCBojETMBEGCgmSJomT8ixkARkWA2NvbTEbMBkGCgmSJomT8ixkARkWC2d1
# YXJkaWFuYnBnMRUwEwYKCZImiZPyLGQBGRYFaW50cmExFjAUBgNVBAsTDVVzZXIg
# QWNjb3VudHMxEzARBgNVBAsTCkNBQlAgVXNlcnMxEjAQBgNVBAsTCUNvcnBvcmF0
# ZTEWMBQGA1UEAxMNTWFyayBUaG9tcHNvbjCCASIwDQYJKoZIhvcNAQEBBQADggEP
# ADCCAQoCggEBAMLopJEioG/acScu0DIS3ReFfd1KKbwNJgGclilNgsopf/ncgY8v
# yykyZCWxB/fOA0W1h95oHFlUwmGMeGsd5YbfMWXTaHm7c2L/2YwcRPlf3vJb47O/
# LC97aR73sA/j1UYSi/z4xVhQXbD8UkoV0p5YTb2NxdR8tzm96LskV7qA3ZJRiLsP
# yI6pwJdP5UvxDdK6c0w/ROzLqUNpsZCc7pU7fY4/qCHb1RewhHMh8Osvuij+RHGB
# 0TBRL2tc9fAy60UBjzv6WmKt8LdIk+uEoKuxwZsQSHRY3Uk0N+BKd/r5C6L8oUPY
# GdeM4ONxIAZv78JUDesq7AC+NwZ8MKB3FIUCAwEAAaOCA0MwggM/MCUGCSsGAQQB
# gjcUAgQYHhYAQwBvAGQAZQBTAGkAZwBuAGkAbgBnMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMA4GA1UdDwEB/wQEAwIHgDAdBgNVHQ4EFgQUd0IMLN+iH4xOUReFpxkXs3u9
# J8wwHwYDVR0jBBgwFoAUvcvpkrwhU7oQ5itPiBbI47dZICEwggErBgNVHR8EggEi
# MIIBHjCCARqgggEWoIIBEoaBwmxkYXA6Ly8vQ049aW50cmEtR05WTC1DQTEtQ0Et
# MSgxKSxDTj1HTlZMLUNBMSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
# ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ndWFyZGlhbmJwZyxE
# Qz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
# PWNSTERpc3RyaWJ1dGlvblBvaW50hktodHRwOi8vR05WTC1DQTEuaW50cmEuZ3Vh
# cmRpYW5icGcuY29tL0NlcnRFbnJvbGwvaW50cmEtR05WTC1DQTEtQ0EtMSgxKS5j
# cmwwggFDBggrBgEFBQcBAQSCATUwggExMIG2BggrBgEFBQcwAoaBqWxkYXA6Ly8v
# Q049aW50cmEtR05WTC1DQTEtQ0EtMSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIw
# U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ndWFyZGlh
# bmJwZyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
# ZmljYXRpb25BdXRob3JpdHkwdgYIKwYBBQUHMAKGamh0dHA6Ly9HTlZMLUNBMS5p
# bnRyYS5ndWFyZGlhbmJwZy5jb20vQ2VydEVucm9sbC9HTlZMLUNBMS5pbnRyYS5n
# dWFyZGlhbmJwZy5jb21faW50cmEtR05WTC1DQTEtQ0EtMSgxKS5jcnQwOwYDVR0R
# BDQwMqAwBgorBgEEAYI3FAIDoCIMIG1hcmt0aG9tcHNvbkBDYW1lcm9uQXNobGV5
# QlAuY29tMEEGCSqGSIb3DQEBCjA0oA8wDQYJYIZIAWUDBAIBBQChHDAaBgkqhkiG
# 9w0BAQgwDQYJYIZIAWUDBAIBBQCiAwIBIAOCAQEArmZ6oT1H4ld0rGg0R9g1DKvv
# q8PxQfmJQKAiFAYupu770+Sl5/Yc84oMKKMAP/GiuXKnJKrxlkaijb9vDfDXotXq
# vRGxLgFEjrBwbTCfLKC3LsL9ILtqrxIsY3W6hqmkWdE6iUlb6s0rBpaIWZC8uMi8
# gsx8rzH2IMJHGvbcxuIpUFISqJdZZW8WRpKEvU8ZX+dCe8bxsOY3Gg4y1OpJmDKu
# XXEgPrg3ZrRGWI6r99CHTkguD8tGySQMS4aVJnMD4fuCGKxeUeI47XBXVcOvoI7V
# qXa1FXXKrtST457WGjeBTkEDnclRuMMWlt+yWC+tPiJ9Nakepsk/TWcAyfzAqTGC
# Ah8wggIbAgEBMH4wZzETMBEGCgmSJomT8ixkARkWA2NvbTEbMBkGCgmSJomT8ixk
# ARkWC2d1YXJkaWFuYnBnMRUwEwYKCZImiZPyLGQBGRYFaW50cmExHDAaBgNVBAMT
# E2ludHJhLUdOVkwtQ0ExLUNBLTECE00AABL0oJUNz7b6iq4AAQAAEvQwCQYFKw4D
# AhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZI
# hvcNAQkEMRYEFL/tGyAHuZANN0CnEsgB0Jv5aDlsMA0GCSqGSIb3DQEBAQUABIIB
# AF89J8UVXfu9Dr9yIvL+r0Ab04k3PHtph30vFL2+dRqvOdEQBcC6/GRHxUE9H0Al
# X4745NWyRHaC3Jqtz3ik9kpbp2YYY8AhBbg31U+vr0JMIse6DMSGySqNLCvTBkLL
# B1V2/IjIYPowIpzxC1hQKL3OJAhQLLYT14hhkLRA08Cc31iOSYcICKKgKHT99eHX
# tTxotr7C3kBEzceS/JBIyG8+p04t5tNZaQbUxnl6iXEl0QzH5Ha63B5xeF+ZsPDb
# S1nKqWZ59rGxj+bGoImpPx3uKO8QWCdrcU/3XXpua14h0tRSk3chUcj+fpTqImVm
# VzRm9q8xkf3lKs9icxXDgK8=
# SIG # End signature block
