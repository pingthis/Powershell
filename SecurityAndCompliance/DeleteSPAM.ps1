#You will need the ExchangeOnlineManagement Module to make this work.
#It will search all Mailboxes for the the supplied info.
#**********MODIFY AS NEEDED************************************
$JobUser = 'markthompson@cameronashleybp.com'
$Subject = 'joined the Houston Orders group'
$From = ''
$CC = ''
$To = ''
$Query = ''
#IF TRUE THIS IS A HARD DELETE AND CANNOT BE RECOVERED#
#$Remove = '$FALSE' #$TRUE Or $FALSE    -PurgeType SoftDelete
#####################DO NOT CHANGE#################################
Import-Module ExchangeOnlineManagement
function Connect-EX {
    
    param ($User)
    
    Connect-ExchangeOnline -UserPrincipalName $JobUser
    Connect-IPPSSession -UserPrincipalName $JobUser -ConnectionUri "https://nam11b.ps.compliance.protection.outlook.com/Powershell-LiveId?BasicAuthToOAuthConversion=true;PSVersion=5.1.19041.906"

}
#Build Query string
if ($Subject.Length -gt 1) {
    $Query = "subject:" + $Subject
   } 
if ($Query.Length -lt 1){
    $Query = 'from:' + $From
} Else {
    if ($From.length -gt 1){
    $Query = $Query + ' AND ' + 'from:' + $From
        }
}
if ($Query.Length -lt 1){
    $Query = 'to:' + $To
} Else {
    if ($To.length -gt 1){
    $Query = $Query, ' AND ' + 'to:' + $To
    }
}
if ($Query.Length -lt 1){
    $Query = $CC
} Else {
    if ($CC.length -gt 1){
    $Query = $Query + ' AND ' + 'cc:' + $CC
    }
}
if ($Query.Length -lt 1){
    write-host 'NO Query to Run'
    end 
} 
$JobName = -join ((get-date -Format 'mmddyyyyhhmmss'), ' - JOB: Spam-Seek_and_Destroy')
#$ContinueJob = Form_revQuery $JobName,$Query
$ContinueJob = $TRUE
if ($ContinueJob -eq $TRUE){
    
    Main
} else {

    exit
}

#write-host 'Query is:', $Query,`n, 'Job Name is:', $JobName

Function Main{
#Create the Search AND PLACE THE RETURNED OBJECT INTO A VARIABLE TO TRACK
Connect-EX $Jobuser
$Search = New-ComplianceSearch -Name $JobName -ExchangeLocation All -ContentMatchQuery "($Query)" 
Start-ComplianceSearch -Identity $Search.Identity

    do {
        $Status = get-ComplianceSearch $JobName
    }until ($Status.Status -eq "Completed") 
        if ($Status.Items -gt 0){
                $Search = New-ComplianceSearchAction -SearchName $JobName -Purge -PurgeType SoftDelete -Confirm:$False
                    }else{
                Write-host JOB FAILED
                end
            }
        
    do {
        $Status = get-ComplianceSearchAction -Identity $Search.Identity
    } until ($Status.Status -eq "Completed") 

    write-Host (-join $Status.Name, "`n" ,' -Action: ', $Status.Action,"`n",'-Run by: ', $Status.RunBy, "`n", '-End Time: ', $Status.JobEndTime,"`n",'-Job Status: ', $Status.status,"`n", '-Job Results: ', $Status.Results)
 # rform (-join $Status.Name, "`n" ,' -Action: ', $Status.Action,"`n",'-Run by: ', $Status.RunBy, "`n", '-End Time: ', $Status.JobEndTime,"`n",'-Job Status: ', $Status.status,"`n", '-Job Results: ', $Status.Results)
    $Subject = $NULL
    $From = $NULL
    $CC = $NULL
    $To = $NULL
    $Query = $NULL


    Disconnect-ExchangeOnline -Confirm:$False

}