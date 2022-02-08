#$Computer = Get-Content "C:\Support\Scripts\SoftwareDelivery\ComputerSummary.csv"
$Computer = Get-ADComputer -Filter {Name -like "*train*"}
$Domain = 'Intra.Guardianbpg.Com'
$Admin  = 'Intra\adm_Thom7010'
$Admin_Pass = 'NT AUTHORITY\System'


Begin{
    foreach ($comp in $Computer)
        {   $Comp =  ($Comp.DNSHostName)
            if ($Comp.Length -lt 1){break}
            if(Test-Connection -ComputerName $comp -Count 2 -Quiet )
        {
                write-host PING_REPLIED for $comp
                Test-NetConnection -ComputerName $comp 
                
                <#
                foreach($item in $items)
                    {
                        $path = $item.FullName
                        Write-Host ...Adding AdminGroup to $path -Fore Green
                        Get-Item -force $path | Set-Owner -Account 'XYZ\Domain Admins'
                        Get-Item -force $path | Add-Ace -Account 'BUILTIN\Administrators' -AccessRights FullControl
                    }
                #>
        }else {
            write-host PING_FAILED for $comp
        }

    }
}
<#
03201W10.Intra.Guardianbpg.Com
03214W10.Intra.Guardianbpg.Com
032TRAINER.Intra.Guardianbpg.
03401W10.Intra.Guardianbpg.Com
 #>