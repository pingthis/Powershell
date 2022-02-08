#You will need the ExchangeOnlineManagement Module to make this work.
#It will search all Mailboxes for the Subject
#**********MODIFY AS NEEDED************************************
$JobUser = 'adm_thom7010@CameronAshley.onmicrosoft.com'
$JobName = 'FreeInvoice Phishing'
$SubjectQuery = 'Keep or change password' 
$DateBegin = '12/1/2020'
$DateEnd = '23/28/2020'
$Remove = '$FALSE' #$TRUE Or $FALSE

#This is a HARDDELETE, there is no manual recovering the email, you can still get it but you gotta write code.
#***********DO NOT MODIFY BELOW THIS LINE***********************
Find-Module AzureAD | Install-Module -AllowPrerelease
Find-Module ExchangeOnlineManagement | Install-Module -AllowPrerelease

Install-Module -Name ExchangeOnlineManagement
Update-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.4-Preview2 -AllowPrerelease


Import-Module ExchangeOnlineManagement
Import-Module AzureAD

$credentials = get-credential -UserName "adm_thom7010@CameronAshley.onmicrosoft.com" -Message "doit"

#Connect-ExchangeOnline -Credential $credentials -EnableErrorReporting -LogDirectoryPath "C:\Support\scripts" -LogLevel All
#$SccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -AllowRedirection -Authentication Basic -Credential $credentials
Connect-IPPSSession -UserPrincipalName "adm_thom7010@CameronAshley.onmicrosoft.com" -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/    
Import-PSSession $SccSession -Prefix cc

#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credentials -Authentication Basic –AllowRedirection
Connect-IPPSSession -UserPrincipalName "adm_thom7010@CameronAshley.onmicrosoft.com" -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/    
Import-PSSession $Session
#Connect-IPPSSession -UserPrincipalName $JobUser

#Create the Search 
$Search=New-ComplianceSearch -Name $JobName -ExchangeLocation All -ContentMatchQuery "(Received:$DateBegin..$DateEnd) AND (Subject: $SubjectQuery)"
#Start with above criteria
Start-ComplianceSearch -Identity $Search.Identity
#Get the results
get-ComplianceSearch -Identity $JobName | Out-GridView

if($Remove){
New-ComplianceSearchAction -SearchName $JobName -Purge -PurgeType HardDelete
}

Disconnect-ExchangeOnline
