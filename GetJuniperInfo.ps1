<#Get the details on our Juniper Equipment#>
$Hosts ="10.185.0.32, 10.185.0.41"
$Hosts = $Hosts -split ","
$Record = @()


    

Foreach($H in $Hosts){
    Write-host "Testing response from "$h.trim().ToString()
    
    If(Test-Connection -ComputerName $h.trim().ToString() -Count 1 -Quiet){
        Write-host "Recieved response..."
        Write-Host "Connecting to " $h.trim().ToString()
        $JUNOS = (Invoke-JunosCommand -Device $h.trim().ToString() -User mthompson -Command "show version; show chassis hardware; show chassis mac-address" -Password 'PA$$word123')
        write-host "Creating Device Record"
       
            $device = New-Object psobject
            $device | Add-Member NoteProperty -Name "SerialNumber" -Value ($JUNOS | Select-String -Pattern "Chassis\W+([A-Z][A-Z]\d{4}.{2}\d{4})").Matches.Value.Substring(39) -force
            $device | Add-Member NoteProperty -Name "MAC_Address" -Value ($JUNOS | Select-String -Pattern "(.{2}:.{2}:.{2}:.{2}:.{2}:.{2})").Matches.Value
            #$device | Add-Member NoteProperty -Name "Description" -Value ($JUNOS | Select-String -Pattern "(SRX345\-.+)").Matches.Groups[2].Value
            $device | Add-Member NoteProperty -Name "Device_Name" -Value ($JUNOS | Select-String -Pattern "([a-z]{5}..x.+)").Matches.Value
            $device | Add-Member NoteProperty -Name "OS_Ver" -Value ($JUNOS | Select-String -Pattern "(\d\d\..{3}-.\d\..)").Matches.Groups[1].Value 
            
        
        write-host "Adding Record"
          $record += $device
       
   
        <#
        $Device.SerialNumber = (($JUNOS | Select-String -Pattern "Chassis\W+([A-Z][A-Z]\d{4}.{2}\d{4})").Matches.Value).Substring(39)
        $Device.MAC_Address= ($JUNOS | Select-String -Pattern "(.{2}:.{2}:.{2}:.{2}:.{2}:.{2})").Matches.Value
        $Device.Description = ($JUNOS | Select-String -Pattern "(SRX345\-.+)").Matches.Groups[2].Value
        $Device.Device_Name = ($JUNOS | Select-String -Pattern "([a-z]{5}..x.+)").Matches.Value
        $Device.OS_Ver = ($JUNOS | Select-String -Pattern "(\d\d\..{3}-.\d\..)").Matches.Groups[1].Value
        
        #>
    }else{
        Write-Host "No Response from Device" $h.trim().ToString()
    }
    $Record | Export-Csv -path 'c:\support\hosts.csv'  -NoTypeInformation -Append -Force


}


<#
$SN = (($JUNOS | Select-String -Pattern "Chassis\W+([A-Z][A-Z]\d{4}.{2}\d{4})").Matches.Value).Substring(39)
$MAC = ($JUNOS | Select-String -Pattern "(.{2}:.{2}:.{2}:.{2}:.{2}:.{2})").Matches.Value
$DESC = ($JUNOS | Select-String -Pattern "(SRX345\-.+)").Matches.Value
$DevName = ($JUNOS | Select-String -Pattern "([a-z]{5}srx345a)").Matches.Value
$OSVer = ($JUNOS | Select-String -Pattern "(\d\d\..{3}-.\d\..)").Matches.Groups[1].Value
#>