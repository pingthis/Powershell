#$Username = "markthompson@cameronashleybp.com"
$searcher = [adsisearcher]"(samaccountname=$env:USERNAME)"
$Username = $searcher.FindOne().Properties.mail

$DomainN = @(
    'intouchmail.com'
    'westernunion.com'
    'salesforce.com'
)
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
        #Get-PSSession | Where-Object {$_.ConfigurationName -eq “Microsoft.Exchange”} | Remove-PSSession
        Remove-PSSession $office365
        }
    

        Connect-ExchangeOnline $Username

        $TransportR = Get-TransportRule "INBOUND - SAFE_DOMAIN"
        #$CDomainN = $TransportR | Select-Object -ExpandProperty SenderDomainIs
        $TransportR | Set-TransportRule -SenderDomainIs $DomainN







