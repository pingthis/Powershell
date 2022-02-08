# Current list of CA IP ranges can be found at \\intra.guardianbpg.com\netlogon\IpRanges.txt
<#
import-module grouppolicy
$IpAddressListFile = '\\intra.guardianbpg.com\netlogon\IpRanges.txt'
$CACampusIps = New-Object Collections.Generic.List[String]
$lines = Get-Content $IpAddressListFile
foreach ($line in $lines) {
   if ($line -match "^s*#") {
      continue
   }
   elseif ($line -match "^s*$") {
      continue
   }
   elseif ($line -match "^([0-9./:a-f]{7,25})s*(#.*)?$") {
      Write-Output $matches[1] $UwCampusIps.Add($line)
   }
   else {
       Write-Output ("IGNORED: " + $line)
   }
}
#
# to create a GPO called "Alexandria: Firewall TCP 8888" which allows inbound TCP 8888 from  Alexandria IPs and link it to the OU of Delegated/Alexandria
#
$FwRule = "Allow TCP 8888 - Alexandria"
$GpoName = "Alexandria: Firewall TCP 8888"
$TargetOU = "OU=pottery,OU=Delegated,DC=netid,DC=washington,DC=edu"
$PolicyStoreName = "netid.washington.edu\" + $GpoName
New-Gpo -Name $GpoName | New-Gplink -target $TargetOU
$GpoSessionName = Open-NetGPO –PolicyStore $PolicyStoreName
#>
$FwRule = "Allow TCP 8888 - Alexandria" 


New-NetFirewallRule -DisplayName $FwRule -RemoteAddress $UwCampusIps -Direction Inbound -Protocol TCP -LocalPort 8888
