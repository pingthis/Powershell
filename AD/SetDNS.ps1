Get-NetAdapter | Select-Object InterfaceAlias , InterfaceIndex
 
Get-DnsClientServerAddress -InterfaceIndex 9
 
set-DnsClientServerAddress -InterfaceIndex 9 -ServerAddresses ("10.10.10.100")