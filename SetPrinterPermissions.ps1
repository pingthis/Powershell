<#Set Printer permissions
Run this on the Print server#>

# Get the Security on the Printer you configured with the GUI
$SDDL = (get-printer -Name 'Greenville P1' -Full).PermissionSDDL

#Create an array with the printer objects that you want to modify.
$Printers = get-printer | Where-Object{$_.Shared -eq "True"}

#loop through the Printer Array
foreach($Pri in $Printers){
    #Set the Security on each of the printers in the Array
    Set-Printer -Name $Pri.Name -PermissionSDDL $SDDL

}

<#Quick and dirty
$p1 = (get-printer -Name 'Albuquerque P3' -full).PermissionSDDL
$Printers = get-printer | where-object{$_.Shared -eq 'True'}
foreach($Pri in $Printers){Set-Printer -Name $Pri.Name -PermissionSDDL $p1}
#>
   

