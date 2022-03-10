<#Export exchange mailbox infor sort by Size#>
$FilePath = "C:\Support\ExchangeOnlineUsage.csv"
$Username = "markthompson@cameronashleybp.com"
Function Connect-ExchangeOnline {
    [CmdletBinding()]
	param(
        [Parameter()]
        [string]$uname
    )
    $office365Credential = Get-Credential $uname
    $global:office365= New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $office365Credential  -Authentication Basic   –AllowRedirection
    Import-PSSession $office365
    }
    
    Function Disconnect-ExchangeOnline {
    Get-PSSession | Where-Object {$_.ConfigurationName -eq “Microsoft.Exchange”} | Remove-PSSession
    }
Main(
Connect-ExchangeOnline $Username

Get-Mailbox | Get-MailboxStatistics | Select-Object DisplayName, IsArchiveMailbox, ItemCount, TotalItemSize | Export-CSV -Path $FilePath

Disconnect-ExchangeOnline
)

Main