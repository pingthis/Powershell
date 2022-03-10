function Get-DCDiag {
          
    [CmdletBinding()]
    [OutputType([Array])] 
    param
    (
        [Parameter(Position=0, Mandatory = $true, HelpMessage="Provide server names", ValueFromPipeline = $true)]
        $Computername
    )
    $DCDiagArray = @()
 
            # DCDIAG ===========================================================================================
            $Dcdiag = (Dcdiag.exe /s:$Computername) -split ('[\r\n]')
            $Results = New-Object Object
            $Results | Add-Member -Type NoteProperty -Name "ServerName" -Value $Computername
            $Dcdiag | %{ 
            Switch -RegEx ($_) 
            { 
                "Starting test"      { $TestName   = ($_ -Replace ".*Starting test: ").Trim() } 
                "passed test|failed test" { If ($_ -Match "passed test") {  
                $TestStatus = "Passed" 
                # $TestName 
                # $_ 
                }  
                Else 
                {  
                $TestStatus = "Failed" 
                # $TestName 
                # $_ 
                } 
                } 
            } 
            If ($TestName -ne $Null -And $TestStatus -ne $Null) 
            { 
                $Results | Add-Member -Name $("$TestName".Trim()) -Value $TestStatus -Type NoteProperty -force
                $TestName = $Null; $TestStatus = $Null
            } 
            } 
            $DCDiagArray += $Results
 
    $DCDiagArray
}             

Get-DCDiag gnvl-dc10
# SIG # Begin signature block
# MIIJ/QYJKoZIhvcNAQcCoIIJ7jCCCeoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUWviBWdhMwLpgFU3Q15RqpPb3
# XrqgggdIMIIHRDCCBfigAwIBAgITTQAAEvSglQ3PtvqKrgABAAAS9DBBBgkqhkiG
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
# hvcNAQkEMRYEFJ2Cm49VPmp4nW2ZwVnKRY4hcm0EMA0GCSqGSIb3DQEBAQUABIIB
# ACGjbWrVt+r0pjJjMuJti8vZqgHfeVTRAw3Ymv5P+QSxf6YRAfS7P4lRGpttOe2n
# MvHoRrVIerDR6iVTIVUUgl6vOONk6R3SYe0lWrb8lxL59g1byIt0LaFwpaQoXGc7
# lh6/+rLmi1x2PkSi8z4ophUilHaY9eUZZ+DlthRBm+5Svmu3dGe9K5YTlhmFVhy7
# K99Y3gPARxOhhGlGbIIR1RW+DMRt/nIj5tU6da6U3+tsLMq0eaMBI+HDFLTBlCE/
# lTHJRSCyvtT7AK35FCWGYPiu7bgGKG1YYe0t1F151wP/3Cz5q0elvfgZYa0sB9vv
# f2LaJQg75fcisi5rX34kbus=
# SIG # End signature block
