<#Digitally Sign script with CA Cert#>

$cert=(dir cert:currentuser\my\ -CodeSigningCert)

$Scriptname = "C:\Support\Scripts\AD\AD Users Hide from Address List.ps1"

Set-AuthenticodeSignature -FilePath $Scriptname -Certificate $cert -TimestampServer http://timestamp.comodoca.com/Authenticode