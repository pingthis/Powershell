$Cname = "."
$Proc = "avp"

Get-Process $Proc -ComputerName $Cname `
 | Format-Table `
        Processname, ID, MachineName,
        @{Label = "CPU(s)"; Expression = {if ($_.CPU) {$_.CPU.ToString("N")}}},
        @{Label = "NPM(K)"; Expression = {[int]($_.NPM / 1024)}},
        @{Label = "PM(M)"; Expression = {[int]($_.PM / 1024)}},
        @{Label = "Company"; Expression = {[string]($_.Company)}},
        @{Label = "Ver"; Expression = {[string]($_.Fileversion)}}
        -AutoSize
		
		
Get-Process -Id 1176 -IncludeUserName


$a[3..$a.count] | ConvertFrom-String | select p2,p3,p4,p5,p6 | where p5 -eq 'established' | Format-Table -AutoSize


#Access a network share in a remote session
Enable-WSManCredSSP -Role Client -DelegateComputer Server02
    $s = New-PSSession Server02
    Invoke-Command -Session $s -ScriptBlock {Enable-WSManCredSSP -Role Server -Force}
    $parameters = @{
      Session = $s
      ScriptBlock = { Get-Item \\Net03\Scripts\LogFiles.ps1 }
      Authentication = "CredSSP"
      Credential = "Domain01\Admin01"
    }
    Invoke-Command @parameters
	
#	Start scripts on many remote computers ------
   
    $parameters = @{
      ComputerName = (Get-Content -Path C:\Test\Servers.txt)
      InDisconnectedSession = $true
      FilePath = "\\Scripts\Public\ConfigInventory.ps1"
      SessionOption = @{OutputBufferingMode="Drop";IdleTimeout=43200000}
    }
    Invoke-Command @parameters
	
	#Enable WinRM
  $prof = Get-NetConnectionProfile | where NetworkCategory -eq "Public"
  Set-NetConnectionProfile -InterfaceIndex $prof.InterfaceIndex -NetworkCategory Private
	Enable-PSRemoting -Force
	Set-Item wsman:\localhost\client\trustedhosts *
  Restart-Service WinRM

$max = New-PSSessionOption -MaximumRedirection 1
    $parameters = @{
      ConnectionUri = "https://ps.exchangelabs.com/PowerShell"
      ScriptBlock = { Get-Mailbox dan }
      AllowRedirection = $true
      SessionOption = $max
    }
    Invoke-Command @parameters	
	
	
SERVER CORE
Turn the GUI OFF
Uninstall-WindowsFeature Server-Gui-Shell
Uninstall-WindowsFeature Server-Gui-Mgmt-Infra –Restart
Turn the GUI ON
Install-WindowsFeature Server-Gui-Shell, Server-Gui-Mgmt-Infra –Restart

AutoUpdate as a job
Automate Update-help
 $jobParams = @{
      Name = 'UpdateHelpJob'
      Credential = 'intra\Thom7010'
      ScriptBlock = {Update-Help}
      Trigger = (New-JobTrigger -Daily -At "3 AM")
    }
    Register-ScheduledJob @jobParams
	
	 Connect-AzAccount -Credential $Credential

Account                              SubscriptionName TenantId                             Environment
-------                              ---------------- --------                             -----------
adm_markthompson@cameronashleybp.com                  549ab248-06e0-4025-acb6-91f408ff217f AzureCloud

 M()nst3r@gnvl_864!
 
 ENABLE or DISABLE -NetAdapterBinding -Name "Adapter Name" -ComponentID ms_tcpip6
 Copy-Item –Path C:\Folder1\file1.txt –Destination 'C:\' –ToSession $session
 PowerShell functions to automatically block specific websites in your hosts file.

<# Function BlockSiteHosts ( [Parameter(Mandatory=$true)]$Url) 
	{
		$hosts = 'C:\Windows\System32\drivers\etc\hosts'
		$is_blocked = Get-Content -Path $hosts | Select-String -Pattern ([regex]::Escape($Url))
	If(-not $is_blocked) {
		$hoststr = "127.0.0.1” + $Url
		Add-Content -Path $hosts -Value $hoststr
		}
Function UnBlockSiteHosts ( [Parameter(Mandatory=$true)]$Url) {
$hosts = 'C:\Windows\System32\drivers\etc\hosts'
$is_blocked = Get-Content -Path $hosts |
Select-String -Pattern ([regex]::Escape($Url))
If($is_blocked) {
$newhosts = Get-Content -Path $hosts |
Where-Object {
$_ -notmatch ([regex]::Escape($Url))for
}
Set-Content -Path $hosts -Value $newhosts
}
}
 #>
<# New-NetFirewallRule -DisplayName "Block Site" -Direction Outbound –LocalPort Any -Protocol Any -Action Block -RemoteAddress 104.244.42.129, 104.244.42.0/24
 
Get-NetFirewallrule | where{$_.DisplayName -like "*v6*"} | foreach{Set-NetFirewallRule $_.name -Direction  Outbound -Action Block -Profile Any}
Get-NetFirewallrule | where{$_.Descriptio -like "*v6*"} | foreach{Set-NetFirewallRule $_.name -Direction  Outbound -Action Block -Profile Any}
Get-NetFirewallrule | where{$_.DisplayName -like "*v6*"} | foreach{Set-NetFirewallRule $_.name -Direction  InBound-Action Block -Profile Any}
Get-NetFirewallrule | where{$_.Descriptio -like "*v6*"} | foreach{Set-NetFirewallRule $_.name -Direction  Inbound -Action Block -Profile Any}
 #>
function NoFunction()	{
***************************************************************************************************
secedit /export /cfg c:\secpol.cfg
(gc .\secpol.cfg).replace("AuditObjectAccess = 0", "AuditObjectAccess = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditSystemEvents = 0", "AuditSystemEvents = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditLogonEvents = 0", "AuditLogonEvents = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditPrivilegeUse = 0", "AuditPrivilegeUse = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditPolicyChange = 0", "AuditPolicyChange = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditObjectAccess = 0", "AuditObjectAccess = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditAccountManage = 0", "AuditAccountManage = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditDSAccess = 0", "AuditDSAccess = 1") | out-file .\secpol.cfg
(gc .\secpol.cfg).replace("AuditAccountLogon = 0", "AuditAccountLogon = 1") | out-file .\secpol.cfg
secedit /configure /db c:\windows\security\local.sdb /cfg c:\cy\secpol.cfg

[Unicode]
Unicode=yes
[System Access]
MinimumPasswordAge = 0
MaximumPasswordAge = 90
MinimumPasswordLength = 8
PasswordComplexity = 1
PasswordHistorySize = 8
LockoutBadCount = 10
ResetLockoutCount = 5
LockoutDuration = 5
RequireLogonToChangePassword = 0
ForceLogoffWhenHourExpire = 0
NewAdministratorName = "Administrator"
NewGuestName = "Guest"
ClearTextPassword = 0
LSAAnonymousNameLookup = 0
EnableAdminAccount = 1
EnableGuestAccount = 0
[Event Audit]
AuditSystemEvents = 0
AuditLogonEvents = 0
AuditObjectAccess = 0
AuditPrivilegeUse = 0
AuditPolicyChange = 0
AuditAccountManage = 0
AuditProcessTracking = 0
AuditDSAccess = 0
AuditAccountLogon = 0
[Registry Values]
MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\CachedLogonsCount=1,"10"
MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ForceUnlockLogon=4,0
MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\PasswordExpiryWarning=4,10
MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ScRemoveOption=1,"0"
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin=4,5
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorUser=4,3
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName=4,0
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableInstallerDetection=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableSecureUIAPaths=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableUIADesktopToggle=4,0
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableVirtualization=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\FilterAdministratorToken=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\LegalNoticeCaption=1,""
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\LegalNoticeText=7,
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ScForceOption=4,0
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\UndockWithoutLogon=4,1
MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ValidateAdminCodeSignatures=4,0
MACHINE\Software\Policies\Microsoft\Windows\Safer\CodeIdentifiers\AuthenticodeEnabled=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\AuditBaseObjects=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\CrashOnAuditFail=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\DisableDomainCreds=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\EveryoneIncludesAnonymous=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy\Enabled=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\ForceGuest=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\FullPrivilegeAuditing=3,0
MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse=4,1
MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\NTLMMinClientSec=4,536870912
MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\NTLMMinServerSec=4,536870912
MACHINE\System\CurrentControlSet\Control\Lsa\NoLMHash=4,1
MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymous=4,0
MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM=4,1
MACHINE\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers=4,0
MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths\Machine=7,System\CurrentControlSet\Control\ProductOptions,System\CurrentControlSet\Control\Server Applications,Software\Microsoft\Windows NT\CurrentVersion
MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths\Machine=7,System\CurrentControlSet\Control\Print\Printers,System\CurrentControlSet\Services\Eventlog,Software\Microsoft\OLAP Server,Software\Microsoft\Windows NT\CurrentVersion\Print,Software\Microsoft\Windows NT\CurrentVersion\Windows,System\CurrentControlSet\Control\ContentIndex,System\CurrentControlSet\Control\Terminal Server,System\CurrentControlSet\Control\Terminal Server\UserConfig,System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration,Software\Microsoft\Windows NT\CurrentVersion\Perflib,System\CurrentControlSet\Services\SysmonLog
MACHINE\System\CurrentControlSet\Control\Session Manager\Kernel\ObCaseInsensitive=4,1
MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management\ClearPageFileAtShutdown=4,0
MACHINE\System\CurrentControlSet\Control\Session Manager\ProtectionMode=4,1
MACHINE\System\CurrentControlSet\Control\Session Manager\SubSystems\optional=7,
MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\EnableForcedLogOff=4,1
MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\EnableSecuritySignature=4,0
MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\NullSessionPipes=7,
MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RequireSecuritySignature=4,0
MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\RestrictNullSessAccess=4,1
MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\EnablePlainTextPassword=4,0
MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\EnableSecuritySignature=4,1
MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\RequireSecuritySignature=4,0
MACHINE\System\CurrentControlSet\Services\LDAP\LDAPClientIntegrity=4,1
MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\DisablePasswordChange=4,0
MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\MaximumPasswordAge=4,30
MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireSignOrSeal=4,1
MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RequireStrongKey=4,1
MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\SealSecureChannel=4,1
MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\SignSecureChannel=4,1
[Privilege Rights]
SeNetworkLogonRight = *S-1-1-0,ASPNET,*S-1-5-32-544,*S-1-5-32-545,*S-1-5-32-551
SeBackupPrivilege = *S-1-5-32-544,*S-1-5-32-551
SeChangeNotifyPrivilege = *S-1-1-0,*S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-32-545,*S-1-5-32-551
SeSystemtimePrivilege = *S-1-5-19,*S-1-5-32-544,*S-1-5-80-3169285310-278349998-1452333686-3865143136-4212226833
SeCreatePagefilePrivilege = *S-1-5-32-544
SeDebugPrivilege = *S-1-5-32-544
SeRemoteShutdownPrivilege = *S-1-5-32-544
SeAuditPrivilege = *S-1-5-19,*S-1-5-20
SeIncreaseQuotaPrivilege = *S-1-5-19,*S-1-5-20,*S-1-5-32-544
SeIncreaseBasePriorityPrivilege = *S-1-5-32-544,*S-1-5-90-0
SeLoadDriverPrivilege = *S-1-5-32-544
SeBatchLogonRight = ASPNET,*S-1-5-32-544,*S-1-5-32-551,*S-1-5-32-559
SeServiceLogonRight = ASPNET,*S-1-5-80-0,*S-1-5-80-3169285310-278349998-1452333686-3865143136-4212226833
SeInteractiveLogonRight = Guest,*S-1-5-32-544,*S-1-5-32-545,*S-1-5-32-551
SeSecurityPrivilege = *S-1-5-21-823518204-2049760794-725345543-45796
SeSystemEnvironmentPrivilege = *S-1-5-32-544
SeProfileSingleProcessPrivilege = *S-1-5-32-544
SeSystemProfilePrivilege = *S-1-5-32-544,*S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420
SeAssignPrimaryTokenPrivilege = *S-1-5-19,*S-1-5-20
SeRestorePrivilege = *S-1-5-32-544,*S-1-5-32-551
SeShutdownPrivilege = *S-1-5-32-544,*S-1-5-32-545,*S-1-5-32-551
SeTakeOwnershipPrivilege = *S-1-5-32-544
SeDenyNetworkLogonRight = Guest
SeDenyInteractiveLogonRight = ASPNET,Guest
SeUndockPrivilege = *S-1-5-32-544,*S-1-5-32-545
SeManageVolumePrivilege = *S-1-5-32-544
SeRemoteInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-555
SeDenyRemoteInteractiveLogonRight = ASPNET
SeImpersonatePrivilege = *S-1-5-19,*S-1-5-20,ASPNET,*S-1-5-32-544,*S-1-5-6
SeCreateGlobalPrivilege = *S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-6
SeIncreaseWorkingSetPrivilege = *S-1-5-32-545
SeTimeZonePrivilege = *S-1-5-19,*S-1-5-32-544,*S-1-5-32-545
SeCreateSymbolicLinkPrivilege = *S-1-5-32-544
SeDelegateSessionUserImpersonatePrivilege = *S-1-5-32-544
[Version]
signature="$CHICAGO$"
Revision=1
******************************************************************************************************
	}


<# Enable Repmoting
Change the Connection Profile to Private
Disable IPv6 #>
Enable-PSRemoting -SkipNetworkProfileCheck -Force
Set-NetConnectionProfile -NetworkCategory Private
Disable-NetAdapterBinding -InterfaceAlias "Local Area Connection* 13" -ComponentID ms_tcpip6


<# Get a list of files with sizes and show the last accessed date #>
Get-ChildItem -path c:\users -ErrorAction silentlycontinue -Recurse | Sort-Object -Property length -Descending | Format-Table -autosize -wrap -property @{Label="Last access";Expression={($_.lastwritetime).ToshortDateString()}},@{label="size in megabytes";Expression={"{0:N2}" -f ($_.Length / 1MB)}}, Fullname | Sort-Object "size in megabytes" | Out-GridView
Get-WmiObject -Class Win32_logicaldisk -Filter "DriveType = '3'" | Select-Object -Property DeviceID, DriveType, VolumeName, @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}}, @{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}}
Set-NetFirewallProfile –Name Public –DefaultInboundAction Block
Set-NetFireWallProfile -Profile Domain -LogBlocked True -LogMaxSize 20000 -LogFileName ‘%systemroot%\system32\LogFiles\Firewall\pfirewall.log’

#New FW Rule
New-NetFirewallRule -DisplayName 'HTTP-Inbound' -Profile @('Domain', 'Private') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('80', '443')
#allow or block network access for an app
New-NetFirewallRule -Program “C:\Program Files (x86)\Mozilla Firefox\firefox.exe” -Action Block -Profile Domain, Private -DisplayName “Block Firefox browser” -Description “Block Firefox browser” -Direction Outbound
#Allow RDP from one address
New-NetFirewallRule -DisplayName "AllowRDP" –RemoteAddress 192.168.2.200 -Direction Inbound -Protocol TCP –LocalPort 3389 -Action Allow
#allow ping (ICMP) for addresses from the specified IP subnet or IP range
$ips = @(”10.191.0.0/16”, ”10.176.0.0/16”, ”10.185.0.0/16”)
New-NetFirewallRule -DisplayName "Allow inbound ICMPv4" -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -RemoteAddress $ips -Action Allow

Get-ChildItem -path c:\users -ErrorAction silentlycontinue -Recurse | Sort-Object -Property length -Descending | Format-Table -autosize -wrap -property `@{Label="Last access";Expression={($_.lastwritetime).ToshortDateString()}},@{label="size in megabytes"}

New-NetFirewallRule -Program "C:\Program Files (x86)\Teamviewer\TeamViewer_Service.exe" -action block -Profile Domain, Private, Public -Displayname "BLOCK-TEAMVIEWER-out" -Description "BLOCK-TEAMVIEWER-out" -Direction Outbound
New-NetFirewallRule -Program "C:\Program Files (x86)\Teamviewer\TeamViewer_Service.exe" -action block -Profile Domain, Private, Public -Displayname "BLOCK-TEAMVIEWER-in" -Description "BLOCK-TEAMVIEWER-in" -Direction Inbound
netsh advfirewall set domainprofile settings remotemanagement enable
 c:\Windows\System32\winrm.cmd qc -quiet


 New-NetFirewallRule  -Displayname "ALLOW-255-SERVERNET-in" -Description "ALLOW-255-SERVERNET-in" -action Allow -Direction INBOUND -Profile DOMAIN -RemoteAddress 10.191.255.0/24
 New-NetFirewallRule  -Displayname "ALLOW-200-SERVERNET-in" -Description "ALLOW-200-SERVERNET-in" -action Allow -Direction INBOUND -Profile DOMAIN -RemoteAddress 10.191.200.0/24

 netsh advfirewall firewall add rule name="Allow from CDC3" dir=in action=allow protocol=ANY remoteip=10.191.255.248
 netsh advfirewall firewall add rule name="Allow from CDC4" dir=in action=allow protocol=ANY remoteip=10.191.255.253
 netsh advfirewall firewall add rule name="Allow from CDC5" dir=in action=allow protocol=ANY remoteip=10.191.255.245
 netsh advfirewall firewall add rule name="Allow from AUDIT" dir=in action=allow protocol=ANY remoteip=10.191.255.50
 netsh advfirewall firewall add rule name="Allow from KSC" dir=in action=allow protocol=ANY remoteip=10.191.255.58
 netsh advfirewall firewall add rule name="Allow from LANSWEEPER" dir=in action=allow protocol=ANY remoteip=10.191.255.83
 netsh advfirewall firewall add rule name="Allow from NETMON" dir=in action=allow protocol=ANY remoteip=10.191.255.42
 netsh advfirewall firewall add rule name="Allow from PATCH" dir=in action=allow protocol=ANY remoteip=10.191.255.49