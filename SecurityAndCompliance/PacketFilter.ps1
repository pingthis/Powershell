$pcs = get-adcomputer -filter * -property Name,OperatingSystem,Operatingsystemversion,IPV4Address
$pfrules = @()
$i=0
foreach ($pc in $pcs) {
    $i+=1
    write-host $i
    $tempval = new-object psobject
    if (Test-Connection -ComputerName $pc.DNSHostName -count 2 -Quiet) {
    $fwrules = Get-NetFirewallRule -cimsession $pc.DNSHostName -PolicyStore activestore
    foreach ( $rule in $fwrules ) {
        $pf = $rule | get-netfirewallportfilter
        $tempval = new-object psobject
        $tempval = $rule | Select-Object displayname, description, enabled, profile, direction, action, policystoresource, policystoresourcetype
        $tempval | add-member -membertype noteproperty -name Protocol -value $pf.protocol
        $tempval | add-member -membertype noteproperty -name LocalPort -value $pf.LocalPort
        $tempval | add-member -membertype noteproperty -name RemotePort -value $pf.RemotePort
        $tempval | add-member -membertype noteproperty -name ICMPType -value $pf.ICMPType
        $tempval | add-member -membertype noteproperty -name DynamicTarget -value $pf.DynamicTarget
        $tempval | add-member -membertype noteproperty -name HostName -value $pc.dnshostname
        $tempval | add-member -membertype noteproperty -name OperatingSystem -value $pc.OperatingSystem
        $tempval | add-member -membertype noteproperty -name IpAddress -value $pc.IPV4Address
        $pfrules += $tempval
        if($i -eq 10){break}
        }
    }
}
$pfrules | export-csv -path 'c:\support\fw-packetfilterrules.csv'