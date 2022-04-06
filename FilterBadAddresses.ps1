
Function Set-IPSECFilter {
	param(
		[Parameter(Mandatory)]
		[string] $DSTAddress,
		[Parameter(Mandatory)]
		[string] $DSTMask
		)
	Process {
			#netsh ipsec static add filter filterlist=BlockIPs srcaddr=0.0.0.0 srcmask=0.0.0.0 dstaddr=$DSTAddress dstmask=$DSTMask protocol=ANY mirrored=yes
	
	
	write-host "Set-IPSECFilter -DSTAddress $DSTAddress -DSTMask $DSTMask"
	}
}

$Content = (Invoke-WebRequest -Uri "https://www.spamhaus.org/drop/drop.txt" -Method GET -UseBasicParsing).content

For($a = 5;$a -lt $Content.Length ;$a++){
write-host $a
$pro = [Math]::Round([Math]::Ceiling(($a/$Content.Length) * 100) / 100, 2)
Write-Progress -Activity "Update Progress" -Status "$pro% Complete:" -PercentComplete $pro;

#Set-IPSECFilter -DSTAddress "2.56.192.0" -DSTMask "22"
write-host $($content[$a])


}

for ($counter = 1; $counter -le 100; $counter++ )
{
		# ADD YOUR CODE HERE
    Write-Progress -Activity "Update Progress" -Status "$counter% Complete:" -PercentComplete $counter;
}