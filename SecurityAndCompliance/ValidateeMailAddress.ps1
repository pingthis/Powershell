function Get-IsValidEmailAddress
{
    param
    (
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$PassedEmailAddressArray=@()
    )
    BEGIN
    {
        Write-Verbose "Started running $($MyInvocation.MyCommand)"
    }
    PROCESS
    {
        Write-Verbose "Checking for Validity on the following Email Addresseses"
        if ($PassedEmailAddressArray -eq $Null)
        {
            Return "No Email address supplied!"
        }
        $IsValidEmailAddress=$True
        ForEach ($EmailAddress in $PassedEmailAddressArray)
        {
            Try
            {
                New-Object System.Net.Mail.MailAddress($EmailAddress) > $null
            }
            Catch
            {
                $IsValidEmailAddress=$False
            }
        }
        Return $IsValidEmailAddress
    }
    END
    {
        Write-Verbose "Stopped running $($MyInvocation.MyCommand)"
    }
}

Get-IsValidEmailAddress "thaynes@hbl2.com"