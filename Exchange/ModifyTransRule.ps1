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
        <#
        $IN_Block_Domain = Get-TransportRule "INBOUND - BLOCK_DOMAIN"
        $OUT_Force_ENCRYPT = Get-TransportRule "OUTBOUND - FORCE_ENCRYPT"
        $IN_Bypass_ATP_IP_ADDRESS = Get-TransportRule "INBOUND - BYPASS_ATP-IP_ADDRESS"
        $IN_Safe_DOMAIN = Get-TransportRule "INBOUND - SAFE_DOMAIN"
        $OUT_Legal_Disclaimer = Get-TransportRule "OUTBOUND - Legal Disclaimer"
        $INBOUND_Disclaimer = Get-TransportRule "INBOUND - Disclaimer"
        #>
        $TransportR = Get-TransportRule
        $Result = $TransportR | Out-GridView -PassThru
        $Result = $Result.SenderIpRanges | Out-GridView -PassThru 



            <#Identity INBOUND - BYPASS_ATP-IP_ADDRESS SenderIpRanges
            #>


        $TransportR = Get-TransportRule "INBOUND - SAFE_DOMAIN"
        #$CDomainN = $TransportR | Select-Object -ExpandProperty SenderDomainIs
        $TransportR | Set-TransportRule -SenderDomainIs $DomainN







