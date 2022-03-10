
#Password Warning script
#Set up common variables
$SMTPServer = 'csseg2.cameronbp.com'

#Create warning dates for future password expiration
$FifteenDayWarnDate = (get-date).adddays(15).ToLongDateString()
$SevenDayWarnDate = (get-date).adddays(7).ToLongDateString()
$ThreeDayWarnDate = (get-date).adddays(3).ToLongDateString()
$OneDayWarnDate = (get-date).adddays(1).ToLongDateString()

#Import AD Module
Import-Module ActiveDirectory
Function NotifyUsers([string] $userName,[string] $eMailAddress, [int] $days, [string] $date, [string] $Subject ){
                
            $EmailStub1 = 'This is an automated email. You are being informed that your network password'
            $EmailStub2 = 'will expire in'
            $EmailStub3 = 'days on'
            $EmailStub4 = '. Please contact the helpdesk if you need assistance changing your password. DO NOT REPLY TO THIS EMAIL.'
            $EmailBody = $EmailStub1, $user.name, $EmailStub2, $days, $EmailStub3, $Date, $EmailStub4 -join ' '

            $MailSender = " Password AutoBot <helpdesk@cameronashleybp.com>"
            #$user.EmailAddress
            #Send-MailMessage -To $eMailAddress  -From $MailSender -SmtpServer $SMTPServer -Subject $Subject -Body $EmailBody
            Write-Host $user.name, $user.Address, $days, $FifteenDayWarnDate, "$days days to go " $user.name
            
}
#Find accounts that are enabled and have expiring passwords and have email addresses
$users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False -and PasswordLastSet -gt 0} `
 -Properties "Name", "EmailAddress", "msDS-UserPasswordExpiryTimeComputed" | ` Select-Object -Property "Name", "EmailAddress", `
 @{Name = "PasswordExpiry"; Expression = {[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed").tolongdatestring() }}

foreach ($user in $users) {
    #write-host $user
    
    if ($user.PasswordExpiry -eq $FifteenDayWarnDate) {
        #Write-host "15 Days to go " $user.name
        $days = 15
        $Subject = "FYI - Your account password will expire on $FifteenDayWarnDate"
        NotifyUsers $user.name, $user.Address, $days, $FifteenDayWarnDate, "$days days to go " $user.name
    }
    elseif ($user.PasswordExpiry -eq $SevenDayWarnDate) {
        #Write-host "7 Days to go " $user.name
        $days = 7
        $Subject = "FYI - Your account password will expire very soon on $SevenDayWarnDate"
        NotifyUsers $user.name, $user.Address, $days, $SevenDayWarnDate, "$days days to go " $user.name
    }
    elseif ($user.PasswordExpiry -eq $ThreeDayWarnDate) {
        #Write-host "3 Days to go " $user.name
        $days = 3
        $Subject = "FYI - Your account password will expire shortly on $ThreeDayWarnDate"
        NotifyUsers $user.name, $user.Address, $days, $ThreeDayWarnDate, "$days days to go " $user.name
    }
    elseif ($user.PasswordExpiry -eq $oneDayWarnDate) {
        Write-host "1 Day to go $user.name. Cutting it a little close."
        $days = 1
        $Subject = 'FYI - Your account password will expire TOMMOROW!'
        NotifyUsers $user.name, $user.Address, $days, $oneDayWarnDate, "$days days to go " $user.name
    }
    #>
    
}







