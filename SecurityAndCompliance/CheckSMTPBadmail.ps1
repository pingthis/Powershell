
$Folder = '\\SMTPrelay.intra.guardianbpg.com\badmail\'
$SMTPServer = 'csseg2.cameronbp.com'

$files =  Get-ChildItem -Path $Folder -filter "*.bad" -File
$EmailAddress = @()

foreach ($File in $files){
		$Textfile = get-content $file.FullName 
		$Addresses = (Select-String -InputObject $Textfile -Pattern '\w+@\w+\.\w+' -AllMatches).Matches
		
		foreach ($address in $Addresses){ 
                if (($address.value).substring($address.length - 20) -eq 'mail.cameronashleybp') {
                    ($address.value).substring($address.length - 20)
                    #$EmailAddress += $address
                }Elseif($address.value -eq 'EDIAdmins@BP.Guardian'){
                    $address.value
                }
                Elseif($address.value -eq 'EDIAdmins@GuardianBP.com'){
                    #write-host '*****************'
                }
                Elseif($address.value -eq 'postmaster@SMTPrelay.intra'){
                }Else{
#                    $EmailAddress += $address
                }
            
        }
        
    }
if ($EmailAddress.count -lt 1) {$email = " NONE FOUND"
}else {
    
$email = $EmailAddress  | Group-Object -NoElement -property value | Select-Object name -Unique | Out-String 
}
Send-MailMessage -To "Markthompson@cameronashleybp.com"  -From 'badmail@cameronashleybp.com' -SmtpServer $SMTPServer -Subject 'Bad Mail' -Body $email
