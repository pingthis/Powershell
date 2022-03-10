$Result = Get-ADUser -Filter 'Name -like "*"' -SearchBase 'OU=Disabled Accounts,OU=User Accounts,DC=intra,DC=guardianbpg,DC=com' | % {Set-ADUser $_ -Replace @{msExchHideFromAddressLists=$true}}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# create form

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Users Hidden'
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = 'CenterScreen'
# create OK button
 
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

# create Textbox
$Result = "this is the result" 
$TextBox = New-Object System.Windows.Forms.TextBox
$TextBox.Location = New-Object System.Drawing.Point(60,60)
$TextBox.Size = New-Object System.Drawing.Size(300,100)
$TextBox.Text = $Result 
$form.Controls.Add($TextBox)


 
 $form.Topmost = $true
 $result = $form.ShowDialog()
# SIG # Begin signature block
# MIIJ/QYJKoZIhvcNAQcCoIIJ7jCCCeoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUK6FH/BD2KhR18x/fPaMA//m+
# PTCgggdIMIIHRDCCBfigAwIBAgITTQAAEvSglQ3PtvqKrgABAAAS9DBBBgkqhkiG
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
# hvcNAQkEMRYEFFBIMgeqEER5iUXYAnzosJpfkmbZMA0GCSqGSIb3DQEBAQUABIIB
# AKbp+nzi3/QRQGqtSPveP14I/17Hd9xM5bF6v3Hr2XcNukIkbG+E/XGYYACJ4BOO
# H+6EZyFQuTzhK9TB/uFupi1Hxeb+gSUNoHrOyaY9pwAdUjwkT/V8gwPx3t5NF90V
# zWdk4FHjS5Foj84iDuMEyxSGdqAMgVz1vvvKrBXlI47l170ek3lM4yNhBV43a77x
# lp2IW/3+DND1Z3ZjepBu++Wx3W8uZyYL1avSdb0bCcvpI+p3ynDxwEanlil8QsDg
# +jlS9YEUJwBKCopg4zK6PlXtYOtbFl2NVBVDLdA8gOlE8rpBp3TuXBpCKGQbFkwh
# j8uD9YBbnt9ZAS1EJUGApj8=
# SIG # End signature block
