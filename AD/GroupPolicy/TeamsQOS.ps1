
$JobUser = 'intra\adm_thom7010'
$password = ConvertTo-SecureString 'PA$$word123' -AsPlainText -Force
$Computername = 'gnvl-cdc3.intra.guardianbpg.com'
#$Cred = Get-Credential -UserName $JobUser -Message 'Enter Password' 
$Cred = New-Object System.Management.Automation.PSCredential ($JobUser, $password)

function Set-Teams-GPO{
    param(
    $ComputerName,
    $Credential 
    )
        #Import the Powershell Module for Active Directory and Group Policy
        Import-Module ActiveDirectory,GroupPolicy
        <#
        Create a new Group Policy Object (GPO) that will be applied to the Organizational Units (OU's) that contain the computer objects that will be used by Teams users.
        The value "Teams client - QoS" can be modified to fit your needs or naming standards
        New-GPO -Name "CABP_SW_Teams-Client-QoS"  -Comment "QoS/DSCP markings for Teams media traffic. That contain the computer objects that will be used by the Teams users." 
        Create Registry Value to enable TCP/IP QoS on the computer
        Set-GPPrefRegistryValue -Name "Teams Client - QoS" -Context Computer -Key "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -ValueName "Do not use NLA" -Value "1" -Type String -Action Update
        Create Registry Value for Teams client Audio QoS in the "Teams Client - QoS" GPO
        Set-GPRegistryValue -Name "Teams Client - QoS" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams Audio QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50000:50019", "*", "*", "*", "*", "*", "46", "-1"
        Create Registry Value for Teams client Video QoS in the "Teams Client - QoS" GPO
        Set-GPRegistryValue -Name "Teams Client - Qos" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams Video QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50020:50039", "*", "*", "*", "*", "*", "34", "-1"
        Create Registry Value for Teams client Application Sharing QoS in the "Teams Client - QoS" GPO
        Set-GPRegistryValue -Name "Teams Client - Qos" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams App Sharing QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50040:50059", "*", "*", "*", "*", "*", "24", "-1"
        Create Registry Value for Teams client File Transfer QoS in the "Teams Client - QoS" GPO
        Set-GPRegistryValue -Name "Teams Client - Qos" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams File Transfer QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50040:50059", "*", "*", "*", "*", "*", "24", "-1"
        #>
        
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            New-GPO -Name "CABP_SW_Teams-Client-QoS"  -Comment "QoS/DSCP markings for Teams media traffic. That contain the computer objects that will be used by the Teams users." 
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Set-GPRegistryValue -Name "CABP_SW_Teams-Client-QoS" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams Video QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50020:50039", "*", "*", "*", "*", "*", "34", "-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Set-GPRegistryValue -Name "CABP_SW_Teams-Client-QoS" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams Video QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50020:50039", "*", "*", "*", "*", "*", "34", "-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Set-GPRegistryValue -Name "CABP_SW_Teams-Client-QoS" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams App Sharing QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50040:50059", "*", "*", "*", "*", "*", "24", "-1"
        } -Credential $Credential
        $null = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Set-GPRegistryValue -Name "CABP_SW_Teams-Client-QoS" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS\Teams File Transfer QoS - Teams.exe" -ValueName "Version", "Application Name", "Protocol", "Local Port", "Local IP", "Local IP Prefix Length", "Remote Port", "Remote IP", "Remote IP Prefix Length", "DSCP Value", "Throttle Rate" -Type String -Value "1.0", "Teams.exe", "*", "50040:50059", "*", "*", "*", "*", "*", "24", "-1"
        } -Credential $Credential
}

Set-Teams-GPO $Computername, $Cred