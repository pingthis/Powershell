#Domain Replication Status

## Active Directory Domain Controller Replication Status##
<#
$domaincontroller = Read-Host 'What is your Domain Controller?'

$DCs = (Get-ADDomain).ReplicaDirectoryServers

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
function Get-ADSystem {
          
    [CmdletBinding()]
    [OutputType([Array])] 
    param
    (
        [Parameter(Position=0, Mandatory = $true, HelpMessage="Provide server names", ValueFromPipeline = $true)]
        $Server
    )
 
    $SystemArray = @()
 
        $Server = $Server.trim()
        $Object = '' | Select-Object ServerName, BootUpTime, UpTime, "Physical RAM", "C: Free Space", "Memory Usage", "CPU usage"
                         
        $Object.ServerName = $Server
 
        # Get OS details using WMI query
        $os = Get-WmiObject win32_operatingsystem -ComputerName $Server -ErrorAction SilentlyContinue | Select-Object LastBootUpTime,LocalDateTime
                         
        If($os)
        {
            # Get bootup time and local date time  
            $LastBootUpTime = [Management.ManagementDateTimeConverter]::ToDateTime(($os).LastBootUpTime)
            $LocalDateTime = [Management.ManagementDateTimeConverter]::ToDateTime(($os).LocalDateTime)
 
            # Calculate uptime - this is automatically a timespan
            $up = $LocalDateTime - $LastBootUpTime
            $uptime = "$($up.Days) days, $($up.Hours)h, $($up.Minutes)mins"
 
            $Object.BootUpTime = $LastBootUpTime
            $Object.UpTime = $uptime
        }
        Else
        {
            $Object.BootUpTime = "(null)"
                $Object.UpTime = "(null)"
        }
 
        # Checking RAM, memory and cpu usage and C: drive free space
        $PhysicalRAM = (Get-WMIObject -class Win32_PhysicalMemory -ComputerName $server | Measure-Object -Property capacity -Sum | % {[Math]::Round(($_.sum / 1GB),2)})
                         
        If($PhysicalRAM)
        {
            $PhysicalRAM = ("$PhysicalRAM" + " GB")
            $Object."Physical RAM"= $PhysicalRAM
        }
        Else
        {
            $Object.UpTime = "(null)"
        }
    
        $Mem = (Get-WmiObject -Class win32_operatingsystem -ComputerName $Server  | Select-Object @{Name = "MemoryUsage"; Expression = { “{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize)}}).MemoryUsage
                        
        If($Mem)
        {
            $Mem = ("$Mem" + " %")
            $Object."Memory Usage"= $Mem
        }
        Else
        {
            $Object."Memory Usage" = "(null)"
        }
 
        $Cpu =  (Get-WmiObject win32_processor -ComputerName $Server  |  Measure-Object -property LoadPercentage -Average | Select Average).Average 
                         
        If($PhysicalRAM)
        {
            $Cpu = ("$Cpu" + " %")
            $Object."CPU usage"= $Cpu
        }
        Else
        {
            $Object."CPU Usage" = "(null)"
        }
 
        $FreeSpace =  (Get-WmiObject win32_logicaldisk -ComputerName $Server -ErrorAction SilentlyContinue  | Where-Object {$_.deviceID -eq "C:"} | select @{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}}).freespace 
                         
        If($FreeSpace)
        {
            $FreeSpace = ("$FreeSpace" + " GB")
            $Object."C: Free Space"= $FreeSpace
        }
        Else
        {
            $Object."C: Free Space" = "(null)"
        }
 
        $SystemArray += $Object
  
        $SystemArray
} 

## Script to gather information about Replication Topology ##


## Define Objects ##
foreach($domaincontroller in $DCs){
    Write-Host $domaincontroller
    (Get-ADReplicationPartnerMetadata -Target $domaincontroller).Partner}

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