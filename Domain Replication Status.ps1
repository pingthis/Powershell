#Domain Replication Status

## Active Directory Domain Controller Replication Status##
<#
$domaincontroller = Read-Host 'What is your Domain Controller?'

## Define Objects ##

$report = New-Object PSObject -Property @{

ReplicationPartners = $null

LastReplication = $null

FailureCount = $null

FailureType = $null

FirstFailure = $null

}

## Replication Partners ##

$report.ReplicationPartners = (Get-ADReplicationPartnerMetadata -Target $domaincontroller).Partner

$report.LastReplication = (Get-ADReplicationPartnerMetadata -Target $domaincontroller).LastReplicationSuccess

## Replication Failures ##

$report.FailureCount  = (Get-ADReplicationFailure -Target $domaincontroller).FailureCount

$report.FailureType = (Get-ADReplicationFailure -Target $domaincontroller).FailureType

$report.FirstFailure = (Get-ADReplicationFailure -Target $domaincontroller).FirstFailureTime

## Format Output ##

$report | select ReplicationPartners,LastReplication,FirstFailure,FailureCount,FailureType | Out-GridView

#>

## Script to gather information about Replication Topology ##

## Define Objects ##

$replreport = New-Object PSObject -Property @{

    Domain = $null
    
    }
    
    ## Find Domain Information ##
    
    $replreport.Domain = (Get-ADDomain).DNSroot
    
    ## List down the AD sites in the Domain ##
    
    $a = (Get-ADReplicationSite -Filter *)
    
    Write-Host "########" $replreport.Domain "Domain AD Sites" "########"
    
    $a | Format-Table Description,Name -AutoSize
    
    ## List down Replication Site link Information ##
    
    $b = (Get-ADReplicationSiteLink -Filter *)
    
    Write-Host "########" $replreport.Domain "Domain AD Replication SiteLink Information" "########"
    
    $b | Format-Table Name,Cost,ReplicationFrequencyInMinutes -AutoSize
    
    ## List down SiteLink Bridge Information ##
    
    $c = (Get-ADReplicationSiteLinkBridge -Filter *)
    
    Write-Host "########" $replreport.Domain "Domain AD SiteLink Bridge Information" "########"
    
    $c | select Name,SiteLinksIncluded | Format-List
    
    ## List down Subnet Information ##
    
    $d = (Get-ADReplicationSubnet -Filter * | select Name,Site)
    
    Write-Host "########" $replreport.Domain "Domain Subnet Information" "########"
    
    $d | Format-Table Name,Site -AutoSize
    
    ## List down Prefered BridgeHead Servers ##
    
    $e = ([adsi]"LDAP://CN=IP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC=rebeladmin,DC=com").bridgeheadServerListBL
    
    Write-Host "########" $replreport.Domain "Domain Prefered BridgeHead Servers" "########"
    
    $e
    
    ## End of the Script ##