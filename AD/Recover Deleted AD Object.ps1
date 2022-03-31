#Recover Deleted AD Object

$objName = "Salesv*"

$name = ((Get-ADObject -ldapFilter:"(msDS-LastKnownRDN=$objName)" -IncludeDeletedObjects).DistinguishedName.split("\").split("="))[1]

Get-ADObject -Filter {displayName -eq $Name} -IncludeDeletedObjects | Restore-ADObject
