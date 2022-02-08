$INTRA_JobUser = 'adm_thom7010@intra'
$CAMERONBP_JobUser = 'thom7010@cameronbp'

$INTRA_Cred = Get-Credential -credential $INTRA_JobUser
$CAMERONBP_Cred = Get-Credential -credential $CAMERONBP_JobUser
$INTRA = New-PSSession -ComputerName gnvl-dhcp1.intra.guardianbpg.com -Credential $INTRA_Cred
$CAMERONBP = New-PSSession –ComputerName CABP-GNVL-DHCP1.cameronbp.com -Credential $CAMERONBP_Cred

Invoke-Command -Session $INTRA -ScriptBlock {
    Export-DhcpServer -ComputerName 'gnvl-dhcp1.intra.guardianbpg.com' -File 'C:\Support\gnvl-dhcp1-export.xml'
}
Copy-Item -FromSession $INTRA -Path 'C:\Support\gnvl-dhcp1-export.xml' -Destination 'C:\Support\'

Invoke-Command -Session $CAMERONBP -ScriptBlock {
        Export-DhcpServer -ComputerName 'cabp-gnvl-dhcp1.cameronbp.com' - 'C:\Support\cabp-gnvl-dhcp1-export.xml'
}