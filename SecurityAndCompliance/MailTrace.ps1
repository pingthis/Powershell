Import-Module ExchangeOnlineManagement
$SMTPServer = 'csseg2.cameronbp.com'
$JobUser = 'markthompson@cameronashleybp.com'
$eMailAddress = 'notificacioneswf@arauco.com'
function Get-IsValidEmailAddress {
    param
    (
        [Parameter(ValueFromPipeline = $true)]
        [string[]]$PassedEmailAddressArray = @()
    )
    BEGIN {
        Write-Verbose "Started running $($MyInvocation.MyCommand)"
    }
    PROCESS {
        Write-Verbose "Checking for Validity on the following Email Addresseses"
        if ($PassedEmailAddressArray -eq $Null) {
            Return "No Email address supplied!"
        }
        $IsValidEmailAddress = $True
        ForEach ($EmailAddress in $PassedEmailAddressArray) {
            Try {
                New-Object System.Net.Mail.MailAddress($EmailAddress) > $null
            }
            Catch {
                $IsValidEmailAddress = $False
            }
        }
        Return $IsValidEmailAddress
    }
    END {
        Write-Verbose "Stopped running $($MyInvocation.MyCommand)"
    }
}
# Get-MessageTraceDetail for more detail
# Get-HistoricalSearch for stuff older than 10 days
function Connect-EX {
    
    param ($User)
    Connect-ExchangeOnline -UserPrincipalName $User
    Connect-IPPSSession -UserPrincipalName $User -ConnectionUri "https://nam11b.ps.compliance.protection.outlook.com/Powershell-LiveId?BasicAuthToOAuthConversion=true;PSVersion=5.1.19041.906"
}

if (Get-IsValidEmailAddress $eMailAddress) {
    Write-Host "This is a VALID email address"
    Connect-EX $Jobuser
    $Messages = Get-MessageTrace -RecipientAddress $eMailAddress -StartDate ([datetime]::Now).AddDays(-10) -EndDate ([datetime]::Now) | Out-String
}
else {
    write-host "Oh NO! INVALID EMAIL ADDRESS"
}
Disconnect-ExchangeOnline -Confirm:$False
Send-MailMessage -To "Markthompson@cameronashleybp.com"  -From 'MarkThompson@CAMERONASHLEYBP.COM' -SmtpServer $SMTPServer -Subject "Mail Trace for $eMailAddress" -Body $Messages -DeliveryNotificationOption 2
