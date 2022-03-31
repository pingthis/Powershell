<#Digitally Sign script with CA Cert#>

$cert=(currentuser\my\ -CodeSigningCert)

$Scriptname = 'C:\Support\Scripts\Desktops\Remove-UnwantedCrap.ps1'

Set-AuthenticodeSignature -FilePath $Scriptname -Certificate $cert -TimestampServer http://timestamp.comodoca.com/Authenticode