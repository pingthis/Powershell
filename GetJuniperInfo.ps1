<#Get the details on our Juniper Equipment#>
$Hosts = get-content C:\Support\juniper.csv

#$Hosts = $Hosts -split ","
$Record = @()

Foreach($H in $Hosts){
    Write-host "Testing response from " $h
    
    If(Test-Connection -ComputerName $h -Count 1 -Quiet){
        #Write-Host "Connecting to " $h
        $JUNOS = (Invoke-JunosCommand -Device $h -User mthompson -Command "show version; show chassis hardware; show chassis mac-address" -Password 'PA$$word123')
        $record += [pscustomobject]@{
            "IP Address" = $h
            "Serial Number" = (($JUNOS | Select-String -Pattern "Chassis\W+([A-Z][A-Z]\d{4}.{2}\d{4})").Matches.Value).Substring(39)
            "MAC Address" = ($JUNOS | Select-String -Pattern "(.{2}:.{2}:.{2}:.{2}:.{2}:.{2})").Matches.Value
            #$DESC = ($JUNOS | Select-String -Pattern "(SRX345\-.+)").Matches.Value
            "Asset Name" = ($JUNOS | Select-String -Pattern "([a-z]{5}srx345a)").Matches.Value
            "OS Version" = ($JUNOS | Select-String -Pattern "(Junos: .+)").Matches.Value.Trim().Split(' ')[1]
            }
       }else{
        $unable = $h
        Write-Host "No Response from Device" $h
    }
}

write-host "Exporting records..."

    ForEach($r in $Record){
       $r | Export-Csv -path 'c:\support\hosts.csv'  -NoTypeInformation -Append -Force
        }
        foreach($u in $unable){Add-Content -path 'c:\support\hosts.csv' -Value $u}
