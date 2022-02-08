
$JobUser = 'intra\adm_thom7010'
$password = ConvertTo-SecureString 'PA$$word123' -AsPlainText -Force
$Computername = 'gnvl-cdc3.intra.guardianbpg.com'
#$Cred = Get-Credential -UserName $JobUser -Message 'Enter Password' 
$Cred = New-Object System.Management.Automation.PSCredential ($JobUser, $password)

function Set-RingCentral-GPO{
    param(
    $ComputerName,
    $Credential 
    )
        #Import the Powershell Module for Active Directory and Group Policy
        Import-Module ActiveDirectory,GroupPolicy
        <#
        Create a new Group Policy Object (GPO) that will be applied to the Organizational Units (OU's) that contain the computer objects that will be used by RingCentral users.
        The value "RingCentral client - QoS" can be modified to fit your needs or naming standards
        New-GPO -Name "CABP_SW_RingCentral-Client-QoS"  -Comment "QoS/DSCP markings for RingCentral media traffic. That contain the computer objects that will be used by the RingCentral users." 
        Create Registry Value to enable TCP/IP QoS on the computer
        Set-GPPrefRegistryValue -Name "RingCentral Client - QoS" -Context Computer -Key "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -ValueName "Do not use NLA" -Value "1" -Type String -Action Update
        Create Registry Value for RingCentral client Audio QoS in the "RingCentral Client - QoS" GPO
        Set-GPRegistryValue -Name "RingCentral Client - QoS" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RingCentral Audio QoS - Softphone.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Softphone.exe", "*", "50000:50019", "*", "*", "*", "*", "*", "46", "-1"
        Create Registry Value for RingCentral client Video QoS in the "RingCentral Client - QoS" GPO
        Set-GPRegistryValue -Name "RingCentral Client - Qos" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RingCentral Video QoS - Softphone.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Softphone.exe", "*", "*", "*", "*", "*", "*", "*", "34", "-1"
        Create Registry Value for RingCentral client Application Sharing QoS in the "RingCentral Client - QoS" GPO
        Set-GPRegistryValue -Name "RingCentral Client - Qos" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RingCentral App Sharing QoS - Softphone.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Softphone.exe", "*", "50040:50059", "*", "*", "*", "*", "*", "24", "-1"
        Create Registry Value for RingCentral client File Transfer QoS in the "RingCentral Client - QoS" GPO
        Set-GPRegistryValue -Name "RingCentral Client - Qos" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RingCentral File Transfer QoS - Softphone.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Softphone.exe", "*", "50040:50059", "*", "*", "*", "*", "*", "24", "-1"
        #>
        
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            New-GPO -Name "CABP_SW_RingCentral-Client-QoS"  -Comment "QoS/DSCP markings for RingCentral media traffic. That contain the computer objects that will be used by the RingCentral users." 
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                               #"V",  "App",          Pro,LP, LIP,LPL, RP, RIP,RPL,DSCP,Pre     Throttle 
            Set-GPRegistryValue -Name "RCSPhoneOut_1" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_1" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","*","*","*","*","80","*","*","18","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_2" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_2" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","3","*","*","*","443","*","*","18","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_3" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_3" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","3","*","*","*","636","*","*","18","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_4" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_4" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","3","*","*","*","5091","*","*","26","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_5" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_5" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","3","*","*","*","5097","*","*","26","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_6" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_6" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","2","60000","*","*","64999","*","*","46","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_6" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_6" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","*","*","*","*","80","*","*","18","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_7" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_7" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","*","*","*","*","80","*","*","18","127","-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {                                                                                                                                                                                                                                                                                  
            Set-GPRegistryValue -Name "RCSPhoneOut_7" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\RCSPhoneOut_7" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Precedence", "Throttle Rate" -Type String -Value "1.0","Softphone.exe","*","*","*","*","80","*","*","18","127","-1"
        } -Credential $Credential

}

Set-RingCentral-GPO $Computername, $Cred