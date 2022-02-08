$cert = (Get-ChildItem cert:\CurrentUser\My -CodeSigning)

Set-AuthenticodeSignature "C:\Support\Scripts\SecurityAndCompliance\List-InstalledSW.ps1" $cert  