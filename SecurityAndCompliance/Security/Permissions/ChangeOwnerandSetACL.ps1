$a = Get-Content "C:\Support\Scripts\SecurityAndCompliance\Security\Permissions\MERC_PROF.txt"
$Owner_Name = 'intra\Domain Admins'
$Local_Admin  = 'BUILTIN\Administrators'
$Local_System = 'NT AUTHORITY\System'
$User
$SA01_Admin = 'adm_thom7010'
$SA02_Admin = 'adm_'
$SA03_Admin = 'adm_'


foreach ($i in $a)
{
    if(test-path $i)
  {
        write-host Taking ownership of Directory $i -fore Green 
        get-item $i | set-owner -Account $Owner_Name
        get-item $i | add-ace -account $Local_Admin -AccessRights FullControl
        get-item $i | Add-Ace -Account $Local_System -AccessRights FullControl
        get-item $i | Add-Ace -Account 'XYZ\willf' -AccessRights FullControl
 
        $items = @()
        $items = $null
        $path = $null
        $items = get-childitem $i -recurse -force
        foreach($item in $items)
            {
                $path = $item.FullName
                Write-Host ...Adding AdminGroup to $path -Fore Green
                Get-Item -force $path | Set-Owner -Account 'XYZ\Domain Admins'
                Get-Item -force $path | Add-Ace -Account 'BUILTIN\Administrators' -AccessRights FullControl
            }
   }
}