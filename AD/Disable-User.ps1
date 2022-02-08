filter timestamp {"$(Get-Date -Format G): $_"}
  
 
Function Connection {
[cmdletbinding()]
Param (
[parameter(Mandatory=$true)]
[string]$Username,
[string]$Password
)
# End of Parameters
 Process {
       $Pass = ConvertTo-SecureString $Password -AsPlainText -Force
       $Cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $Username, $Pass
       return $Cred
 }
}
 
 
Function Exception {
 
      
     return $_.Exception.Message
      
}
 
 
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
 
# create form
 
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Disabling User'
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = 'CenterScreen'
 
# create checkbox for Office365
$checkbox1 = new-object System.Windows.Forms.checkbox
$checkbox1.Location = new-object System.Drawing.Size(10,70)
$checkbox1.Size = new-object System.Drawing.Size(175,50)
$checkbox1.Text = "Disable Office 365 User"
#$checkbox1.Checked = $true
$Form.Controls.Add($checkbox1) 
 
 
# create checkbox for Office365 shared mailbox
 
$checkbox2 = new-object System.Windows.Forms.checkbox
$checkbox2.Location = new-object System.Drawing.Size(200,70)
$checkbox2.Size = new-object System.Drawing.Size(175,50)
$checkbox2.Text = "Convert to shared mailbox"
#$checkbox2.Checked = $true
 
 
# create OK button
 
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)
 
# create label
 
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(390,30)
$label.Text = 'Please enter Name of user you want to disable (for example Tony Stark):'
$form.Controls.Add($label)
 
# create cancel button
 
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(250,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)
 
# create text box
 
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,50)
$textBox.Size = New-Object System.Drawing.Size(360,20)
$form.Controls.Add($textBox)
 
# Show checkbox $checkboxs if $checkbox1 is checked
 
$checkbox1.Add_Click({
    If ($checkbox1.Checked -eq $true){
         $Form.Controls.Add($checkbox2)
    }
 
    else{
        $checkbox2.Checked = $false
        $Form.Controls.Remove($checkbox2)
    }
})
 
 
$form.Controls.Add($checkbox1)
 
$form.Topmost = $true
 
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()
 
 
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $name = $textBox.Text
 
    $check = $checkbox1.Checked
 
    $shared = $checkbox2.Checked
}
 
else{
     
    Return
}
 
 
$VerbosePreference="Continue"
 
$LogFile = "C:Script\script.log"
 
  
 
Try{
   $CSV_F = UnProtect-CmsMessage -To "cn=youralias@emailaddress.com" -Path "C:\Users\user\Desktop\1.csv.cms"
   $Data = $CSV_F | ConvertFrom-Csv
}
 
Catch{
 
   Write-Host -ForegroundColor Red (Exception)
   Return
}
 
 
 
# Get First and last name
            
# Remove whitespace
            
$name = $name.Trim()
 
# Get first name only
    
$fname = $name.Split(" ")[0]
            
# Get last name only
 
$lname = $name.Split(" ")[1]
               
# construct email address/username
           
$email = $fname.ToLower() + "." + $lname.ToLower() + "@example.com"
 
# construct samAccoutName
 
$samaccountname = $fname.ToLower() + "." + $lname.ToLower()
 
# if name contains 3 strings, for example Robert Downey Jr
 
if($name.split('  ').Count -eq 3){
 
  $fname = $name.split('  ')[0]
 
  $lname = $name.Split('  ')[1] + ' ' + $name.Split('  ')[2]
 
  $samaccountname = $name.Split('  ')[0].ToLower() + '.' + $name.Split('  ')[1].ToLower()
  
  $email = $name.Split('  ')[0].ToLower() + '.' + $name.Split('  ')[1].ToLower() + '.' + $name.Split('  ')[2].ToLower() + "@example.com"
}
 
 
# Disabling AD user
 
write-output "Checking if user $samaccountname exist and if it's disabled.." | timestamp >> $LogFile
Write-Verbose "Checking if user $samaccountname exist and if it's disabled.."
 
# select domain controller
  
$dc = Get-ADDomainController -DomainName example.local -Discover -NextClosestSite
 
# check if user exists and if it's enabled, if yes, reset password to default one, remove from all AD groups except Domain Users and move it to Disabled OU
if ([bool] (Get-ADUser -Server $dc.HostName[0] -Filter "SamAccountName -eq '$samaccountname'")){
  Try{
     if( [bool] (Get-ADUser -Server $dc.HostName[0] -Filter "SamAccountName -eq '$samaccountname'" | select -ExpandProperty enabled)){
         Set-ADAccountPassword $samaccountname -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $Data[2].password -Force)
         Get-AdPrincipalGroupMembership -Identity $samaccountname | Where-Object -Property Name -Ne -Value 'Domain Users' | Remove-AdGroupMember -Members $samaccountname -Confirm:$false
         Disable-ADAccount -Identity $samaccountname
         Get-ADUser -Identity $samaccountname |  Move-ADObject -TargetPath "OU=DisabledUsers,OU=Users,DC=example,DC=local"
         Write-Verbose "Active directory user $samaccountname disabled"
         write-output "Active directory user $samaccountname disabled" | timestamp >> $LogFile
      }
      else{
         Write-Verbose "No actions taken, user $samaccountname already disabled or doesn't exist"
         write-output "No actions taken, user $samaccountname already disabled or doesn't exist" | timestamp >> $LogFile
      }
     }
   Catch{
     Exception
     
 }
}
else{
    Write-Verbose "AD user $samaccountname doesn't exist, or it's disabled already"
    write-output "Active directory user $samaccountname doesn't exist, or it's disabled already" | timestamp >> $LogFile
}
 
 
 
 
if ($check){
 
# If check box checked, remove Office 365 user
 
     Try{
        write-output "############### Starting Script for disabling user $name ##############" | timestamp >> $LogFile
        write-output "Connecting to Office 365" | timestamp >> $LogFile
        Write-Verbose "Connecting to Office 365"
        $O365cred = Connection -Username $Data[0].user -Password $Data[0].password
        $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $O365cred -Authentication Basic -AllowRedirection
        Import-PSSession $Session -AllowClobber
        Connect-MsolService -Credential $O365cred
        # Connect to Azure 
        # Write-Verbose "Connecting to Azure..."
        # Connect-AzureAD -Credential $O365cred
        # Write-Verbose "Connection to Azure completed." 
        write-output "Connection to Office 365 completed." | timestamp >> $LogFile
        Write-Verbose "Connection to Office 365 completed."
        }
     Catch {
       Exception
      } 
 
     #-------------------Removing Office 365 user-----------------------
 
 
  
     # If user doesn't exist, exit script
  
  
     $found = Get-MsolUser -UserPrincipalName $email -ErrorAction SilentlyContinue
      
     if (!$found){     
        Write-Verbose "User $email doesn't exist, exiting"
        write-output "User $email doesn't exist, exiting" | timestamp >> $LogFile
        Return
     }  
                       
     # If user exists and is not blocked
  
 
     if ((-not [bool](get-msoluser -userprincipalname $email).blockcredential) -and $found) {
      
      
# If member of any Distribution list, remove it
 
Try{
     
    write-output "Checking if user $email is member of any DL..." | timestamp >> $LogFile
    Write-Verbose "Checking if user $email is member of any DL..."
    $dgs = Get-DistributionGroup -ResultSize unlimited
    foreach($dg in $dgs){
      $DGMs = Get-DistributionGroupMember -identity $dg.DistinguishedName
      if(Get-DistributionGroupMember $dg.DistinguishedName | Where WindowsliveID -eq $email){
           Remove-DistributionGroupMember $dg.DistinguishedName -Member $email -confirm:$false
           write-output "User $email removed from DL $dg" | timestamp >> $LogFile
           Write-Verbose "User $email removed from DL $dg"
      }
   }
 }
 Catch{
   Exception
    
}
 
 
Try{
   # If member of any Office365 groups, remove it
    
   Write-Verbose "Checking if user $email is member of any Office365 group..."
   write-output "Checking if user $email is member of any Office365 group..." | timestamp >> $LogFile             
   $O365groups = get-UnifiedGroup -ResultSize unlimited
   foreach($O365Group in $O365Groups){
       if (Get-UnifiedGroupLinks -Identity $O365Group.Name -LinkType Members | Where WindowsliveID -eq $email){
          Remove-UnifiedGroupLinks -Identity $O365Group.Name -LinkType Member -Links $email -confirm:$false
          write-output "User $email removed from Office365 group $O365Group" | timestamp >> $LogFile
          Write-Verbose "User $email removed from Office365 group $O365Group"  
    }
   }
  }
Catch{
     Exception
  }
 
   # if checkbox for converting to shared mailbox is checked and user has a license, convert it to shared mailbox
    if(($shared) -and ([bool] (Get-MsolUser -UserPrincipalName $email | Select-Object -ExpandProperty isLicensed))){
       Try{       
       write-output "Checking if $email is already shared mailbox..." | timestamp >> $LogFile
       Write-Verbose "Checking if $email is already shared mailbox..."
        
       # Check if shared mailbox already exists, if not convert mailbox to shared
        
       $isshared = Get-Mailbox -RecipientTypeDetails SharedMailbox | where PrimarySmtpAddress -eq $email
       if (!$isshared){
             Set-Mailbox -Identity $email -Type Shared -ProhibitSendQuota 49.5gb -IssueWarningQuota 49.5gb
             write-output "Mailbox $email converted to shared mailbox, waiting for few seconds..." | timestamp >> $LogFile
             Write-Verbose "Mailbox $email converted to shared mailbox, waiting for few seconds..."
             Sleep 7
       }
       
     } 
     Catch{
     Exception
  }
    }
 
   # Remove license if exists
 
  if ([bool] (Get-MsolUser -UserPrincipalName $email | Select-Object -ExpandProperty isLicensed)){
  Try{ 
       write-output "User $email has license,removing it" | timestamp >> $LogFile
       Write-Verbose "User $email has license,removing it"
       (get-MsolUser -UserPrincipalName $email).licenses.AccountSkuId |
         foreach{
          Set-MsolUserLicense -UserPrincipalName $email -RemoveLicenses $_
       } 
       write-output "All Office365 licenses removed for user $email" | timestamp >> $LogFile
       Write-Verbose "All Office365 licenses removed for user $email"
      }
     Catch{
     Exception
     }
    }
 
 
 
   # Disable user
   if (-not [bool](get-msoluser -userprincipalname $email).blockcredential){
   Try{
      Set-MsolUser -UserPrincipalName $email -BlockCredential $true
      write-output "User $email disabled" | timestamp >> $LogFile
      Write-Verbose "User $email disabled"
      write-output "############### Script for disabling user $name finished ##############" | timestamp >> $LogFile
   }
   Catch{
     Exception
   }
  }
 }
}