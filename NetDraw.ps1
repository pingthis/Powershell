$RawData = @{}
$HostIP = @{}
$Count = 0
$RawData = import-csv -Path 'C:\Support\netdraw\qs1_nettraffic.csv'
$File = "C:\Support\NetDraw\out.csv"
#$ErrorActionPreference = 'SilentlyContinue'

Function Set-Record($IPAddress){
    
    if ($HostIP.Contains($IPAddress)){break}
    $HostIP.Add($IPAddress, $Count)
    
}
ForEach($Server in $RawData){
    $Server | Add-Member -NotePropertyName Key -NotePropertyValue Done
    $Server | Add-Member -NotePropertyName Refs -NotePropertyValue Done
    $Record = $Server
    #$Server.Status
    Switch($Server.Status){
        ("Connected") { 
            $SourceAddressPort = ($Server).'Source Address' + ':' + ($Server).'Source Port'
            $DestinationAddressPort = ($Server).'Destination Address' + ':' + ($Server).'Destination Port'
            
                $Count++
                Set-Record $SourceAddressPort
                $Count++
                Set-Record $DestinationAddressPort
            
            if ($HostIP.Contains($SourceAddressPort)) {
                
                    $SRCKey = $HostIP.$SourceAddressPort -as [int] 
                    $DSTKey = $HostIP.$DestinationAddressPort -as [int] 
                    
                    $tmpSRCPort = (($Server).'Source Port') -as [int]
                    $tmpDSTPort = (($Server).'Destination Port') -as [int]
                        if ($tmpSRCPort -lt $tmpDSTPort) {
                           <# write-host -ForegroundColor Green "Host is a Dest"
                             write-host $tmpSRCPort "<-" $tmpDSTPort#>
                            write-host $SRCKey"<-"$DSTKey 
                            $Record.Key = $DSTKey
                            $Record.Refs = $SRCKey
                            #$Record | Select-Object 'Source Address',Key,Refs | Export-csv -Path $File -NoTypeInformation -Append
                            
                        }ELSE{
                            <#$tmpSRCPort
                            write-host -ForegroundColor Blue "Host is a Source"
                             write-host $tmpSRCPort "->" $tmpDSTPort#>
                            write-host $SRCKey"->"$DSTKey 
                            $Record.Key = $SRCKey
                            $Record.Refs = $DSTKey
                            #$Record | Select-Object 'Source Address','Destination Address','Source Port','Destination Port','Process ID','Process Filename',Key,Refs  | Export-csv -Path $File -NoTypeInformation -Append
                            
                }
                 
                <# if ($HostIP.Contains(($Server).'Destination Address')) {
                    $DSTIP = ($Server).'Destination Address'
                    $RefKey = $HostIP.$DSTIP
                } 
                    write-host $SourceIP" from "$DestinationIP #>
                }     
           }  
        }
}
