<#Be sure to run the commands in Powershell.  (To launch Powershell, open an Administrator Command Prompt and type "start powershell" and press enter)
View all preinstalled:
    Get-AppxPackage -AllUsers

Remove all pre-installed apps for Windows 10:
	Get-AppxPackage -AllUsers | Remove-AppxPackage

To prevent these pre-installed apps from reinstalling for new users:
	Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage –online

To prevent all pre-installed apps from reinstalling for new users except store:
#>
#Get-AppxProvisionedPackage –online | where {$_.packagename –notlike “*store*”} | Remove-AppxProvisionedPackage -online
#Get-AppxProvisionedPackage -online | where {$_.packagename -like "Microsoft.Microsoft*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.G*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.Web*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsMaps*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsAlarms*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsCamera*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsFeedbackHub*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsMaps*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.Messaging*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.MixedReality.Portal*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.X*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.Z*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.O*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.P*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.S*"} | Remove-AppxProvisionedPackage -online

get-appxpackage *3dbuilder* | remove-appxpackage
get-appxpackage *alarms* | remove-appxpackage
get-appxpackage *bing* | remove-appxpackage
#get-appxpackage *calculator* | remove-appxpackage
get-appxpackage *camera* | remove-appxpackage
get-appxpackage *commsphone* | remove-appxpackage
get-appxpackage *communicationsapps* | remove-appxpackage
get-appxpackage *getstarted* | remove-appxpackage
get-appxpackage *maps* | remove-appxpackage
get-appxpackage *messaging* | remove-appxpackage
#get-appxpackage *officehub* | remove-appxpackage
#get-appxpackage *onenote* | remove-appxpackage
#get-appxpackage *people* | remove-appxpackage
get-appxpackage *phone* | remove-appxpackage
get-appxpackage *photos* | remove-appxpackage
get-appxpackage *skypeapp* | remove-appxpackage
get-appxpackage *solitaire* | remove-appxpackage
get-appxpackage *soundrecorder* | remove-appxpackage
get-appxpackage *sway* | remove-appxpackage
get-appxpackage *windowsphone* | remove-appxpackage
get-appxpackage *windowsstore* | remove-appxpackage
#get-appxpackage *xbox* | remove-appxpackage
get-appxpackage *zune* | remove-appxpackage
get-appxpackage *zunemusic* | remove-appxpackage
get-appxpackage *zunevideo* | remove-appxpackage

# SIG # Begin signature block
# MIIJ/QYJKoZIhvcNAQcCoIIJ7jCCCeoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUyqAQo9uPXqQQ2wQ5UOwkyCZ+
# MXegggdIMIIHRDCCBfigAwIBAgITTQAAEvSglQ3PtvqKrgABAAAS9DBBBgkqhkiG
# 9w0BAQowNKAPMA0GCWCGSAFlAwQCAQUAoRwwGgYJKoZIhvcNAQEIMA0GCWCGSAFl
# AwQCAQUAogMCASAwZzETMBEGCgmSJomT8ixkARkWA2NvbTEbMBkGCgmSJomT8ixk
# ARkWC2d1YXJkaWFuYnBnMRUwEwYKCZImiZPyLGQBGRYFaW50cmExHDAaBgNVBAMT
# E2ludHJhLUdOVkwtQ0ExLUNBLTEwHhcNMjIwMTA1MjEyNTA1WhcNMjMwMTA1MjEy
# NTA1WjCBojETMBEGCgmSJomT8ixkARkWA2NvbTEbMBkGCgmSJomT8ixkARkWC2d1
# YXJkaWFuYnBnMRUwEwYKCZImiZPyLGQBGRYFaW50cmExFjAUBgNVBAsTDVVzZXIg
# QWNjb3VudHMxEzARBgNVBAsTCkNBQlAgVXNlcnMxEjAQBgNVBAsTCUNvcnBvcmF0
# ZTEWMBQGA1UEAxMNTWFyayBUaG9tcHNvbjCCASIwDQYJKoZIhvcNAQEBBQADggEP
# ADCCAQoCggEBAMLopJEioG/acScu0DIS3ReFfd1KKbwNJgGclilNgsopf/ncgY8v
# yykyZCWxB/fOA0W1h95oHFlUwmGMeGsd5YbfMWXTaHm7c2L/2YwcRPlf3vJb47O/
# LC97aR73sA/j1UYSi/z4xVhQXbD8UkoV0p5YTb2NxdR8tzm96LskV7qA3ZJRiLsP
# yI6pwJdP5UvxDdK6c0w/ROzLqUNpsZCc7pU7fY4/qCHb1RewhHMh8Osvuij+RHGB
# 0TBRL2tc9fAy60UBjzv6WmKt8LdIk+uEoKuxwZsQSHRY3Uk0N+BKd/r5C6L8oUPY
# GdeM4ONxIAZv78JUDesq7AC+NwZ8MKB3FIUCAwEAAaOCA0MwggM/MCUGCSsGAQQB
# gjcUAgQYHhYAQwBvAGQAZQBTAGkAZwBuAGkAbgBnMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMA4GA1UdDwEB/wQEAwIHgDAdBgNVHQ4EFgQUd0IMLN+iH4xOUReFpxkXs3u9
# J8wwHwYDVR0jBBgwFoAUvcvpkrwhU7oQ5itPiBbI47dZICEwggErBgNVHR8EggEi
# MIIBHjCCARqgggEWoIIBEoaBwmxkYXA6Ly8vQ049aW50cmEtR05WTC1DQTEtQ0Et
# MSgxKSxDTj1HTlZMLUNBMSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
# ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ndWFyZGlhbmJwZyxE
# Qz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
# PWNSTERpc3RyaWJ1dGlvblBvaW50hktodHRwOi8vR05WTC1DQTEuaW50cmEuZ3Vh
# cmRpYW5icGcuY29tL0NlcnRFbnJvbGwvaW50cmEtR05WTC1DQTEtQ0EtMSgxKS5j
# cmwwggFDBggrBgEFBQcBAQSCATUwggExMIG2BggrBgEFBQcwAoaBqWxkYXA6Ly8v
# Q049aW50cmEtR05WTC1DQTEtQ0EtMSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIw
# U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ndWFyZGlh
# bmJwZyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRp
# ZmljYXRpb25BdXRob3JpdHkwdgYIKwYBBQUHMAKGamh0dHA6Ly9HTlZMLUNBMS5p
# bnRyYS5ndWFyZGlhbmJwZy5jb20vQ2VydEVucm9sbC9HTlZMLUNBMS5pbnRyYS5n
# dWFyZGlhbmJwZy5jb21faW50cmEtR05WTC1DQTEtQ0EtMSgxKS5jcnQwOwYDVR0R
# BDQwMqAwBgorBgEEAYI3FAIDoCIMIG1hcmt0aG9tcHNvbkBDYW1lcm9uQXNobGV5
# QlAuY29tMEEGCSqGSIb3DQEBCjA0oA8wDQYJYIZIAWUDBAIBBQChHDAaBgkqhkiG
# 9w0BAQgwDQYJYIZIAWUDBAIBBQCiAwIBIAOCAQEArmZ6oT1H4ld0rGg0R9g1DKvv
# q8PxQfmJQKAiFAYupu770+Sl5/Yc84oMKKMAP/GiuXKnJKrxlkaijb9vDfDXotXq
# vRGxLgFEjrBwbTCfLKC3LsL9ILtqrxIsY3W6hqmkWdE6iUlb6s0rBpaIWZC8uMi8
# gsx8rzH2IMJHGvbcxuIpUFISqJdZZW8WRpKEvU8ZX+dCe8bxsOY3Gg4y1OpJmDKu
# XXEgPrg3ZrRGWI6r99CHTkguD8tGySQMS4aVJnMD4fuCGKxeUeI47XBXVcOvoI7V
# qXa1FXXKrtST457WGjeBTkEDnclRuMMWlt+yWC+tPiJ9Nakepsk/TWcAyfzAqTGC
# Ah8wggIbAgEBMH4wZzETMBEGCgmSJomT8ixkARkWA2NvbTEbMBkGCgmSJomT8ixk
# ARkWC2d1YXJkaWFuYnBnMRUwEwYKCZImiZPyLGQBGRYFaW50cmExHDAaBgNVBAMT
# E2ludHJhLUdOVkwtQ0ExLUNBLTECE00AABL0oJUNz7b6iq4AAQAAEvQwCQYFKw4D
# AhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZI
# hvcNAQkEMRYEFCGuAJOxpYow7xlCtNMyT/EQuKwfMA0GCSqGSIb3DQEBAQUABIIB
# AKI7RGGGB4F0NQlPyKU3bpIwsAyDiKzcnxRsL/FHGWPXCCAmoST76WL9Y6mYt0be
# IYfxb5To+tnhyYx3OR9Mq5Yefl2bgESvgxgAns8nnjhpGOZeqJ9eUfV5VRxUssuP
# ole3ATkYUxEpVV8neUZYlvdpasMgnFuvvUTxA44Iu34S3gRyDogjI5GeBccU9BnB
# rsdj+0N8hypPYIVmogkRXMOP5fxQjgTV2bALZNfY6t9cPE/J8rwLOY5n7jQu9XBR
# o4MKxY3Yob6obpVbR46dukbD+AYEZO0OSFQh+cLpXIp8RTnSHo9RTcg/R48wCLsA
# 3PXqOjMLmkSEJx0vLpbYDKE=
# SIG # End signature block
