#Connect to Exchange Online PowerShell
 Param(
    [ValidateSet('y','Y')]
    [ValidateNotNullOrEmpty()] 
    [char]$MFA = (Read-Host 'MFA Required? Y/N'),
    [string]$UserName,  
    [string]$Password,
    [ValidateNotNullOrEmpty()] 
    [string]$WPServiceAccount = (Read-Host "WPCRM Service Account"),
    [ValidateNotNullOrEmpty()] 
    [string]$groupname = (Read-Host "O365 Distribution Group to Apply Impersonation Right Too")	
 )
 Write-Host 'The Group ' $groupname ' must already contain all CRM users in order to apply the sendas permissions as this only applies the permissions during 
 current execution to the current members of the group. Any newly added members to this group will not have the sendas permissions, they will need added manually
  or by running this script again once the user is added to the group.' 

  $P1 = Read-Host -Prompt 'Would you Like to Continue? Y/N'

  if($P1 -match "[nN]") {
  exit
  }
 
 if($MFA -match "[yY]") 
 {
  #Check for MFA module
  Import-Module AzureAD -UseWindowsPowerShell
  $MFAExchangeModule = ((Get-ChildItem -Path $($env:LOCALAPPDATA+"\Apps\2.0\") -ErrorAction SilentlyContinue -Filter CreateExoPSSession.ps1 -Recurse ).FullName | Select-Object -Last 1)
  If ($MFAExchangeModule -eq $null)
  {
   Write-Host  `nPlease install Exchange Online MFA Module.  -ForegroundColor yellow
   Write-Host You can install module using below blog : `nLink `nOR you can install module directly by entering "Y"`n
   $Confirm= Read-Host Are you sure you want to install module directly? [Y] Yes [N] No
   if($Confirm -match "[yY]")
   {
     Write-Host Yes
     Start-Process "iexplore.exe" "https://cmdletpswmodule.blob.core.windows.net/exopsmodule/Microsoft.Online.CSE.PSModule.Client.application"
   }
   else
   {
    Start-Process 'https://o365reports.com/2019/04/17/connect-exchange-online-using-mfa/'
    Exit
   }
   $Confirmation= Read-Host Have you installed Exchange Online MFA Module? [Y] Yes [N] No
   if($Confirmation -match "[yY]")
   {
    $MFAExchangeModule = ((Get-ChildItem -Path $($env:LOCALAPPDATA+"\Apps\2.0\") -Filter CreateExoPSSession.ps1 -Recurse ).FullName | Select-Object -Last 1)
    If ($MFAExchangeModule -eq $null)
    {
     Write-Host Exchange Online MFA module is not available -ForegroundColor red
     Exit
    }
   }
   else
   { 
    Write-Host Exchange Online PowerShell Module is required
    Start-Process 'https://o365reports.com/2019/04/17/connect-exchange-online-using-mfa/'
    Exit
   }   
  }
  
  #Importing Exchange MFA Module
  . "$MFAExchangeModule"
  Connect-EXOPSSession -WarningAction SilentlyContinue | Out-Null
 }
 #Connect Exchnage Online with Non-MFA
 else
 {
 $UserName = (Read-Host "O365 Admin Username")
 $Password = (Read-Host "O365 Admin Password")
  if(($UserName -ne "") -and ($Password -ne "")) 
  { 
   $SecuredPassword = ConvertTo-SecureString -AsPlainText $Password -Force 
   $Credential  = New-Object System.Management.Automation.PSCredential $UserName,$SecuredPassword 
  } 
  else 
  { 
   $Credential=Get-Credential -Credential $null
  } 
  
  $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication Basic -AllowRedirection
  Import-PSSession $Session -DisableNameChecking -AllowClobber -WarningAction SilentlyContinue | Out-Null
 }

 #Check for connectivity
 If ((Get-PSSession | Where-Object { $_.ConfigurationName -like "*Exchange*" }) -ne $null)
 {
  Write-Host `nSuccessfully connected to Exchange Online

  $DG = Get-DistributionGroup $groupname -Filter "RecipientTypeDetails -ne 'GroupMailbox'"
      While ($DG.ID.Count -ne 1 )
    {
        Write-host 'More than one group, must be unique. please try Entering the SamAccountname of the group'
        $groupname = Read-Host -Prompt 'Please Re-Enter the Group you would like to Apply the permissions too'
        $DG = Get-DistributionGroup $groupname -Filter "RecipientTypeDetails -ne 'GroupMailbox'"
    }

  $Members = Get-DistributionGroupMember $DG.SamAccountName | Where-Object { $_.RecipientType -eq 'UserMailbox'}
  write-host 'The permissions will be applied to' $Members.Count 'Users'
  $Answer = Read-host -Prompt 'Would you like to Continue? Y/N'
   If ( $Answer -match "[yY]"){
      Foreach( $member in $Members)
      {
        Add-RecipientPermission -Identity $member.Id  -AccessRights SendAs -Trustee $WPServiceAccount -Confirm:$false 
      }
      }

$ScopeExist = Get-ManagementScope "WPCRM Users" -ErrorAction SilentlyContinue

If ($ScopeExist -ne $null ){
Write-Host 'Mangement Scope Exist'
exit
}

        $Customization = Get-OrganizationConfig | Select IsDehydrated
        If ( $Customization -eq $true)
        {
                    $Answer = Read-host -Prompt 'Organization Customization has not been enable for your tenant. This is required.Please refer to https://docs.microsoft.com/en-us/powershell/module/exchange/enable-organizationcustomization?view=exchange-ps...Would you like to do this? Y/N'
            If ( $Answer -match "[yY]")
            {
                Enable-OrganizationCustomization
            }
            Else
            {
            Exit
            }
        }

write-host 'The Impersonation Scope will effect ' $Members.Count 'Users'

$Answer = Read-host -Prompt 'Would you like to Continue? Y/N'
   If ( $Answer -match "[yY]"){
        New-ManagementScope -Name:"WPCRM Users" -RecipientRestrictionFilter "(MemberOfGroup -eq '$($DG.DistinguishedName)' -and RecipientType -eq 'UserMailbox')"
        New-ManagementRoleAssignment -Name: "WP Email Users" -Role:ApplicationImpersonation -User: $WPServiceAccount -CustomRecipientWriteScope:"WPCRM Users"
    }  
        Remove-PSSession $Session

 }
 else
 {
  Write-Host `nUnable to connect to Exchange Online. Error occurred -ForegroundColor Red
 }
