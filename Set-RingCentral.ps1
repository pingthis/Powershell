#! DSCP Actions:
#! 10 - AF11 (Reserved for Customer Critical Markings)
#! 18 - AF21 (RingCentral traffic not otherwise classified)
#! 26 - AF31 (SIP Signaling Traffic)
#! 34 - AF41 (Video Real-Time Traffic)
#! 46 – EF (Voice Real-Time Traffic)
New-Item HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Qos -force
New-ItemProperty -path HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Qos -Name "Do not use NLA" -Value 1 -Force
Remove-NetQosPolicy -Name RCMeetingOut_1 -Confirm:$false
Remove-NetQosPolicy -Name RCMeetingOut_2 -Confirm:$false
Remove-NetQosPolicy -Name RCMeetingOut_3 -Confirm:$false
Remove-NetQosPolicy -Name RCMeetingOut_4 -Confirm:$false
Remove-NetQosPolicy -Name RCMeetingOut_5 -Confirm:$false
Remove-NetQosPolicy -Name RCMeetingOut_6 -Confirm:$false
Remove-NetQosPolicy -Name RCMeetingOut_7 -Confirm:$false
New-NetQosPolicy -Name RCMeetingOut_1 -AppPathNameMatchCondition RingCentralMeetings.exe -Precedence 127 -DSCPAction 26 -IPProtocolMatchCondition Both -IPDstPortStartMatchCondition 3000 -IPDstPortEndMatchCondition 4000
New-NetQosPolicy -Name RCMeetingOut_2 -AppPathNameMatchCondition RingCentralMeetings.exe -Precedence 127 -DSCPAction 26 -IPProtocolMatchCondition Both  -IPDstPortStartMatchCondition 5060 -IPDstPortEndMatchCondition 5061
New-NetQosPolicy -Name RCMeetingOut_4 -AppPathNameMatchCondition RingCentralMeetings.exe -Precedence 127 -DSCPAction 26 -IPProtocolMatchCondition TCP  -IPDstPortMatchCondition 1702
New-NetQosPolicy -Name RCMeetingOut_5 -AppPathNameMatchCondition RingCentralMeetings.exe -Precedence 127 -DSCPAction 34 -IPProtocolMatchCondition TCP  -IPDstPortMatchCondition 443
New-NetQosPolicy -Name RCMeetingOut_3 -AppPathNameMatchCondition RingCentralMeetings.exe -Precedence 127 -DSCPAction 34 -IPProtocolMatchCondition Both  -IPDstPortMatchCondition 8801
New-NetQosPolicy -Name RCMeetingOut_6 -AppPathNameMatchCondition RingCentralMeetings.exe -Precedence 127 -DSCPAction 46 -IPProtocolMatchCondition UDP  -IPDstPortStartMatchCondition 9000 -IPDstPortEndMatchCondition 10000
New-NetQosPolicy -Name RCMeetingOut_7 -AppPathNameMatchCondition RingCentralMeetings.exe -Precedence 127 -DSCPAction 46 -IPProtocolMatchCondition UDP  -IPDstPortStartMatchCondition 5090 -IPDstPortEndMatchCondition 5099
#! Softphone.exe
Remove-NetQosPolicy -Name RCSPhoneOut_1 -Confirm:$false
Remove-NetQosPolicy -Name RCSPhoneOut_2 -Confirm:$false
Remove-NetQosPolicy -Name RCSPhoneOut_3 -Confirm:$false
Remove-NetQosPolicy -Name RCSPhoneOut_4 -Confirm:$false
Remove-NetQosPolicy -Name RCSPhoneOut_5 -Confirm:$false
Remove-NetQosPolicy -Name RCSPhoneOut_6 -Confirm:$false
Remove-NetQosPolicy -Name RCSPhoneOut_7 -Confirm:$false
New-NetQosPolicy -Name RCSPhoneOut_1 -AppPathNameMatchCondition Softphone.exe -DSCPAction 18 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 80                   
New-NetQosPolicy -Name RCSPhoneOut_2 -AppPathNameMatchCondition Softphone.exe -DSCPAction 18 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 443
New-NetQosPolicy -Name RCSPhoneOut_3 -AppPathNameMatchCondition Softphone.exe -DSCPAction 18 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 636
New-NetQosPolicy -Name RCSPhoneOut_4 -AppPathNameMatchCondition Softphone.exe -DSCPAction 26 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 5091
New-NetQosPolicy -Name RCSPhoneOut_5 -AppPathNameMatchCondition Softphone.exe -DSCPAction 26 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 5097
New-NetQosPolicy -Name RCSPhoneOut_6 -AppPathNameMatchCondition Softphone.exe -DSCPAction 46 -Precedence 127 -IPProtocolMatchCondition UDP -IPDstPortStartMatchCondition 50000 -IPDstPortEndMatchCondition 59999
New-NetQosPolicy -Name RCSPhoneOut_7 -AppPathNameMatchCondition Softphone.exe -DSCPAction 46 -Precedence 127 -IPProtocolMatchCondition UDP -IPDstPortStartMatchCondition 60000 -IPDstPortEndMatchCondition 64999
New-NetQosPolicy -Name RCSPhoneOut_2 -AppPathNameMatchCondition Softphone.exe -DSCPAction 18 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 443
New-NetQosPolicy -Name RCSPhoneOut_3 -AppPathNameMatchCondition Softphone.exe -DSCPAction 18 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 636
New-NetQosPolicy -Name RCSPhoneOut_4 -AppPathNameMatchCondition Softphone.exe -DSCPAction 26  -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 5091
New-NetQosPolicy -Name RCSPhoneOut_5 -AppPathNameMatchCondition Softphone.exe -DSCPAction 26 -Precedence 127 -IPProtocolMatchCondition TCP -IPDstPortMatchCondition 5097
New-NetQosPolicy -Name RCSPhoneOut_6 -AppPathNameMatchCondition Softphone.exe -DSCPAction 46 -Precedence 127 -IPProtocolMatchCondition UDP -IPDstPortStartMatchCondition 50000 -IPDstPortEndMatchCondition 59999
New-NetQosPolicy -Name RCSPhoneOut_7 -AppPathNameMatchCondition Softphone.exe -DSCPAction 46 -Precedence 127 -IPProtocolMatchCondition UDP -IPDstPortStartMatchCondition 60000 -IPDstPortEndMatchCondition 64999
#! Glip.exe
Remove-NetQosPolicy -Name RCGlipOut_1 -Confirm:$false
New-NetQosPolicy -Name RCGlipOut_1 -AppPathNameMatchCondition Glip.exe -DSCPAction 34 -Precedence 127 -IPProtocolMatchCondition Both
<#! CustomerCritical.exe (fix program name to use)
#! Duplicate as needed and increment trailing number
Remove-NetQosPolicy -Name CustomerCritical_1 -Confirm:$false
New-NetQosPolicy -Name CustomerCritical_1 -AppPathNameMatchCondition CustomerCritical_1.exe -DSCPAction 10 -Precedence 127 -IPProtocolMatchCondition Both
#>