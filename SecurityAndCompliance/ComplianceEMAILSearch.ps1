#You will need the ExchangeOnlineManagement Module to make this work.
#It will search all Mailboxes for the Subject 'adm_thom7010@CameronAshley.onmicrosoft.com'
#**********MODIFY AS NEEDED************************************
$JobUser = 'adm_thom7010@CameronAshley.onmicrosoft.com'
$JobName = 'igor at gmail2'
$SubjectQuery = 'RE: Quick Reply ' 
$DateBegin = '1/1/2020'
$DateEnd = '1/15/2020'
$Remove = '$FALSE' #$TRUE Or $FALSE  "(Received:$DateBegin..$DateEnd) AND
# to:pilarp@contoso.com
# from:'igorcastelobc@gmail.com'
# bcc:pilarp@contoso.com
# cc:pilarp@contoso.com
# category:"Red Category"
# participants:garthf@contoso.com "all items in the specified mailbox folder that were sent or received by garthf@contoso.com"
# importance:high
# isread:true
# kind:email OR kind:im OR kind:voicemail OR kind:externaldata
# received:04/15/2016
# received>=01/01/2016 AND received<=03/31/2016
# sent:04/15/2016
# sent>=01/01/2016 AND sent<=03/31/2016
# recipients:garthf@contoso.com
# size>26214400 and size>2..6214400
# subject:"Quarterly Financials"
# attachmentnames:annualreport.ppt
# https://docs.microsoft.com/en-us/microsoft-365/compliance/keyword-queries-and-search-conditions?view=o365-worldwide
#
#
#
#
#
#
#
#
#This is a HARDDELETE, there is no manual recovering the email, you can still get it but you gotta write code.
#***********DO NOT MODIFY BELOW THIS LINE***********************


$UserCredential = Get-Credential -UserName $JobUser -Message "Do It!" 
Connect-IPPSSession -Credential $UserCredential
Import-Module ExchangeOnlineManagement 
#Create the Search 
$Search=New-ComplianceSearch -Name $JobName -ExchangeLocation All -ContentMatchQuery  "(Received:$DateBegin..$DateEnd) AND (Subject: $SubjectQuery)"
#Start with above criteria
Start-ComplianceSearch -Identity $Search.Identity
#Get the results
get-ComplianceSearch -Identity $JobName

if($Remove){
New-ComplianceSearchAction -SearchName $JobName -Purge -PurgeType HardDelete -Confirm:$FALSE
}

#Disconnect-ExchangeOnline -Confirm:$FALSE

