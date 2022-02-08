
$Computer1 = 'MADAMSW10.intra.guardianbpg.com'
$Computer2 = 'dhogan2w10.intra.guardianbpg.com'
$Computer3 = 'cw10.intra.guardianbpg.com'
$process1 = Get-WmiObject -Query "SELECT * FROM Meta_Class WHERE __Class = 'Win32_Process'" -namespace "root\cimv2" -computername $Computer1
$process2 = Get-WmiObject -Query "SELECT * FROM Meta_Class WHERE __Class = 'Win32_Process'" -namespace "root\cimv2" -computername $Computer2
$process3 = Get-WmiObject -Query "SELECT * FROM Meta_Class WHERE __Class = 'Win32_Process'" -namespace "root\cimv2" -computername $Computer3

$process1.Create( "notepad.exe" )
$process2.Create( "notepad.exe" )
$process3.Create( "notepad.exe" )
1..10 | % {
$process1.Create( "notepad.exe" )
$process2.Create( "notepad.exe" )
}

$Scriptblock = {$process1 = Get-WmiObject -Query "SELECT * FROM Meta_Class WHERE __Class = 'Win32_Process'" -namespace "root\cimv2"
$process1.Create( "notepad.exe" )
}

invoke-ascurrentuser 