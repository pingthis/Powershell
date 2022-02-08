# PRTG-Ubiquiti Sensors
#
# Uses the Ubiquiti Controller REST-Api to collect additional information about the WLAN
#  Send a main Feedback about the Sensor itself and global values
# Additional HTTPPush Sensors are used to send Datra per SSID and Channel
#
# 20170512 Ver 0.7  FC  Initial Version with REST-API
# 20170515 Ver 1.0  FC  First version with additional HTTPPush sensors 
# 20170531 Ver 1.1  FC  Remove custom Unit String
# 20170710 Ver 1.2  FC  Enforce TLS 1.1

[CMdLetBinding()]
param(
	[string]$controlleruri = "https://192.168.178.8:8443",  # Url to access the ubiqiti controller Service
	[string]$site = 'default',           # name of the ubiquiti site to query
	[string]$Username = 'RESTAPI',       # valid User account of an Admin (ReadOnly is fine)
	[string]$password = 'RESTPASS',     # corresponding password
	[string]$httppushurl = 'http://192.168.178.11:5050/ubiquitiy-',  #prefix of HTTP-Sensors
	[int]$maxretries = 3                 # maximum numbers of retries to grab authToken and JSON_Data
)

Write-verbose "PRTG-Ubiquiti-MSXFAQ:Start"
#Ignore SSL Errors
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}  
Add-Type -AssemblyName system.web  # required for URL Enconding 
$ValidTLS = [System.Net.SecurityProtocolType]'Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $ValidTLS

Write-verbose "PRTG-Ubiquiti-MSXFAQ:Check PS-Version"
# Confirm Powershell Version.
if ($PSVersionTable.PSVersion.Major -lt 3) {
	Write-Output "<prtg>"
	Write-Output "<error>1</error>"
	Write-Output "<text>Powershell Version is $($PSVersionTable.PSVersion.Major) Requires at least 3. </text>"
	Write-Output "</prtg>"
	Write-Output "PRTG-Ubiquiti-MSXFAQ:Check PS-Version failed"
	Exit
}

# ComCreate $controller and $credential using multiple variables/parameters.
[string]$credential = "`{`"Username`":`"$Username`",`"password`":`"$password`"`}"

# Start debug timer
$queryMeasurement = [System.Diagnostics.Stopwatch]::StartNew()

# Perform the authentication and store the token to myWebSession
$myWebSession=$null
$trycount=1
while ($trycount -lt $maxretries) {
	try {
		Write-verbose "PRTG-Ubiquiti-MSXFAQ:Download Login Token from Controller, try $trycount"
		$null = Invoke-Restmethod `
			-Uri "$controlleruri/api/login" `
			-method POST `
			-body $credential `
			-ContentType "application/json; charset=utf-8" `
			-SessionVariable myWebSession
		$trycount=$maxretries
	}
	catch{
		$trycount++
	}
}

if (!$myWebSession) {
	Write-Output "<prtg>"
	Write-Output "<error>1</error>"
	Write-Output "<text>Authentication Failed: $($_.Exception.Message)</text>"
	Write-Output "</prtg>"
	Write-Output "PRTG-Ubiquiti-MSXFAQ:Download Login Token failed"
	Exit
}

#Query API providing token from first query.
$jsonresult=$null
$trycount=1
while ($trycount -lt 3) {
	try {
		Write-verbose "PRTG-Ubiquiti-MSXFAQ:Download Controller Data from $controlleruri try $trycount"
		$jsonresult = Invoke-Restmethod -Uri "$controlleruri/api/s/$site/stat/device/" -WebSession $myWebSession
		$trycount=$maxretries
	}
	catch{
		$trycount++
	}
}

if (!$jsonresult) {
	Write-Output "<prtg>"
	Write-Output "<error>1</error>"
	Write-Output "<text>API Query Failed: $($_.Exception.Message)</text>"
	Write-Output "</prtg>"
	Write-Output "PRTG-Ubiquiti-MSXFAQ: Download Controller Data FAILED"
	Exit
}

# Stop debug timer
$queryMeasurement.Stop()

Write-verbose "PRTG-Ubiquiti-MSXFAQ:Generating Data"

foreach ($entry in $jsonresult.data.vap_table) {
	Write-verbose "-----------------------------------------------------"
	Write-verbose "PRTG-Ubiquiti-MSXFAQ:  WLAN    $($entry.essid) on $($entry.radio) "
	Write-verbose "PRTG-Ubiquiti-MSXFAQ:  Clients $($entry.num_sta)"
	Write-verbose "PRTG-Ubiquiti-MSXFAQ:  Channel $($entry.channel)"

	$prtgresult = '<?xml version="1.0" encoding="UTF-8" ?>
	<prtg>
	   <result>
			<channel>TotalClients</channel>
			<value>'+($entry.'num_sta')+'</value>
			<float>0</float>
	   </result>
	   <result>
		  <channel>Channel</channel>
		  <value>'+($entry.'channel')+'</value>
		  <float>0</float>
	   </result>
	   <result>
		  <channel>RX-Bytes</channel>
		  <value>'+($entry.'rx_bytes') +'</value>
		  <float>0</float>
		  <mode>Difference</mode>
		  <CustomUnit>Bytes</CustomUnit>
		</result>
		<result>
		  <channel>RX-Errors</channel>
		  <value>'+($entry.'rx_errors') +'</value>
		  <float>0</float>
		  <mode>Difference</mode>
		  <CustomUnit>Pakete</CustomUnit>
	   </result>
		<result>
		  <channel>RX-dropped</channel>
		  <value>'+($entry.'rx_dropped') +'</value>
		  <float>0</float>
		  <mode>Difference</mode>
		  <CustomUnit>Pakete</CustomUnit>
	   </result>
		<result>
		  <channel>TX-Bytes</channel>
		  <value>'+($entry.'tx_bytes') +'</value>
		  <float>0</float>
		  <mode>Difference</mode>
		  <CustomUnit>Bytes</CustomUnit>
	   </result>
		<result>
		  <channel>TX-Errors</channel>
		  <value>'+($entry.'tx_errors') +'</value>
		  <float>0</float>
		  <mode>Difference</mode>
		  <CustomUnit>Pakete</CustomUnit>
	   </result>
		<result>
		  <channel>TX-dropped</channel>
		  <value>'+($entry.'tx_dropped') +'</value>
		  <float>0</float>
		  <mode>Difference</mode>
		  <CustomUnit>Pakete</CustomUnit>
	   </result>
	</prtg>'
	#$prtgresult
	$uri = ($httppushurl+$guid+$($entry.essid)+"-"+$($entry.radio))
	Write-verbose "PRTG-Ubiquiti-MSXFAQ:  Sending Data to $uri"
	#$debugfile = ([string](get-date).tostring("hhmmssfff") + ".txt")
	#Write-verbose "PRTG-Ubiquiti-MSXFAQ:  Sending Debug to $debugfile"
	#$prtgresult | out-file $debugfile
	$Answer=Invoke-Webrequest `
		-method 'GET' `
		-URI ($uri + "?content="+[System.Web.HttpUtility]::UrlEncode($prtgresult)) `
		-usebasicparsing
	Write-verbose "WebRequest $($answer.rawcontent)"
	if ($answer.Statuscode -ne 200) {
		write-warning 'Request to PRTG failed'
		exit 1
	}
	
}
Write-verbose "PRTG-Ubiquiti-MSXFAQ: Done sending individual WLANs"

Write-verbose "PRTG-Ubiquiti-MSXFAQ: Start generating summary"
$apCount = 0
Foreach ($entry in ($jsonresult.data | where-object { $_.state -eq "1" -and $_.type -like "uap"})){
	$apCount ++
}

$apUpgradeable = 0
Foreach ($entry in ($jsonresult.data | where-object { $_.state -eq "1" -and $_.type -like "uap" -and $_.upgradable -eq "true"})){
	$apUpgradeable ++
}

$UserCount = 0
Foreach ($entry in ($jsonresult.data | where-object { $_.type -like "uap"})){
	$UserCount += $entry.'ng-num_sta'
}

$guestCount = 0
Foreach ($entry in ($jsonresult.data | where-object { $_.type -like "uap"})){
	$guestCount += $entry.'ng-guest-num_sta'
}

#Write Results
Write-Output "<?xml version="1.0" encoding="UTF-8" ?>"
Write-Output "<prtg>"
Write-Output "  <result>"
Write-Output "    <channel>Clients (Total)</channel>"
Write-Output "    <value>$($UserCount)</value>"
Write-Output "  </result>"
Write-Output "  <result>"
Write-Output "    <channel>Access Points Connected</channel>"
Write-Output "    <value>$($apCount)</value>"
Write-Output "  </result>"
Write-Output "  <result>"
Write-Output "    <channel>Access Points Upgradeable</channel>"
Write-Output "    <value>$($apUpgradeable)</value>"
Write-Output "  </result>"
Write-Output "  <result>"
Write-Output "    <channel>Guests</channel>"
Write-Output "    <value>$($guestCount)</value>"
Write-Output "  </result>"
Write-Output "  <result>"
Write-Output "    <channel>Load</channel>"
Write-Output "    <value>$($jsonresult.data.sys_stats.loadavg_5)</value>"
Write-Output "  </result>"
Write-Output "  <result>"
Write-Output "    <channel>Response Time</channel>"
Write-Output "    <value>$($queryMeasurement.ElapsedMilliseconds)</value>"
Write-Output "    <CustomUnit>msecs</CustomUnit>"
Write-Output "  </result>"
Write-Output "</prtg>"

Write-Verbose "PRTG-Ubiquiti-MSXFAQ:End"