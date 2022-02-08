$JobUser = 'markthompson@cameronashleybp.com'
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName $JobUser
Connect-IPPSSession -UserPrincipalName $JobUser -ConnectionUri "https://nam11b.ps.compliance.protection.outlook.com/Powershell-LiveId?BasicAuthToOAuthConversion=true;PSVersion=5.1.18362.1171"


get-ComplianceSearch -Identity "EORTIZ6@roadrunner.com SPAM"

New-ComplianceSearchAction -SearchName $JobName -Purge -PurgeType HardDelete -Confirm:$false