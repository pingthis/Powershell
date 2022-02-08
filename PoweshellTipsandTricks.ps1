# Pipe
Get-Command | Where-Object {} | Sort-Object {} | Select-Object

# The && and || Operators
# The && operator executes the command to the right side of the pipe only if the first command was successful.

#  first command succeeds and the second command is executed
Write-Host "Primary Message" && Write-Host "Secondary Message"

# first command fails, the second is not executed
Write-Error "Primary Error" && Write-Host "Secondary Message"

# The || operator executes the command to the right side of the pipe only if the first command was unsuccessful. So it’s the opposite of the previous one.

# first command succeeds, the second command is not executed
Write-Host "Primary Message" || Write-Host "Secondary Message"

# first command fails, so the second command is executed
Write-Error "Primary Error" || Write-Host "Secondary Message"


# Null-coalescing, assignment, and conditional operators
#PowerShell 7 includes Null coalescing operator ??, Null conditional assignment ??=, and Null conditional member access operators ?. and ?[]

$variable = $null

if ($null -eq $variable) {
	"No Value is Found"
} 

$variable = "test"
if($null -eq $variable)
{
	"No Value is Found"
}

if($null -eq $variable) { "Np Value is Found" } else { $variable }


$variable = $null
$variable ?? "No Value is Found"

$variable = "test"
$variable ?? "No Value is Found"
# Basic If Statement
$value = 10
if($value -lt 9) { Write-Host "Value is less than 9" }
if($value -gt 9) { Write-Host "Value is greater than 9" }
if($value -lt 9) { Write-Host "Value is less than 9" } else { Write-Host "Value is greater than 9" }

# Existing If Statements
if () {
    $messageOne = "Matched: This is message one"
} else {
    $messageOne = "Not Matched: This is message one"
}
 
if () {
    $messageTwo = "Matched: This is message two"
} else {
    $messageTwo = "Not Matched: This is message two"
}
 
if () {
    $messageThree = "Matched: This is message three"
} else {
    $messageThree = "Not Matched: This is message three"
}

Write-Host $messageOne
Write-Host $messageTwo
Write-Host $messageThree

[PSCustomObject]@{
    "messageOne" = $messageOne
    "messageTwo" = $messageTwo
    "messageThree" = $messageThree
}

# Ternary Operator
[PSCustomObject]@{
    "messageOne" = (() ? "Matched: This is message one" : "Not Matched: This is message one")
    "messageTwo" = (() ? "Matched: This is message two" : "Not Matched: This is message two")
    "messageThree" = (() ? "Matched: This is message three" : "Not Matched: This is message three")
}

# Switch Statement
$value = Read-Host "Type your favorite car brand"
Switch ($value)
{
    Brand1 {'You typed: Brand 1'}
    Brand2 {'You typed: Brand 2'}
    Brand3 {'You typed: Brand 3'}
    Brand4 {'You typed: Brand 4'}
}

# Switch Statement with Default
$value = Read-Host "Type your favorite car brand"
Switch ($value)
{
    Brand1 {'You typed: Brand 1'}
    Brand2 {'You typed: Brand 2'}
    Brand3 {'You typed: Brand 3'}
    Brand4 {'You typed: Brand 4'}
    default {'You did not type any brand'}
}

# Multiple Switch Statement with Default
$brand1 = Read-Host "Type your first favorite car brand"
$brand2 = Read-Host "Type your second favorite car brand"
Switch ($brand1, $brand2)
{
    Brand1 {'You typed: Brand 1'}
    Brand2 {'You typed: Brand 2'}
    Brand3 {'You typed: Brand 3'}
    Brand4 {'You typed: Brand 4'}
    default {'You did not type any brand'}
}
# Select objects by property
Get-Process | Select-Object -Property ProcessName, Id, WS
Get-Process | Select-Object -Property ProcessName

# Select objects by property and format the results$variable
Get-Process Explorer | Select-Object -Property ProcessName -ExpandProperty Modules | Format-List

# Select processes using the most memory
Get-Process | Sort-Object -Property WS | Select-Object -Last 5

# Select unique characters from an array
"One","Two","Three","One","One","Two" | Select-Object -Unique

# Select all but the first object
"One","Two","Three","One","One","Two" | Select-Object -Skip 1

# Demonstrate the intricacies of the -ExpandProperty parameter
$object = [pscustomobject]@{Name="MyObject";Expand=@("One","Two","Three","Four","Five")}
$object | Select-Object -ExpandProperty Expand -Property Name
$object | Select-Object -ExpandProperty Expand -Property Name | Get-Member

# View Members for an object
Get-Service
Get-Service -ServiceName 'Dnscache' | Get-Member

# Get the type of object
Get-Service | Get-Member -MemberType Property

# Get the properties of the object
Get-Service -ServiceName 'Dnscache' | Select-Object -Property 'StartType'

# Retrieve alias value
Get-Service | Get-Member -MemberType 'AliasProperty'

# Populate variable with object
$Svc = Get-Service -ServiceName 'Dnscache'
$Svc.Name
$Svc.RequiredServices

# View the methods for an object
Get-Service | Get-Member -MemberType 'Method'

# Selecting values from a PowerShell Object
Get-Service -ServiceName * | Select-Object -Property 'Status','DisplayName'
Get-Service -ServiceName *

# Sorting values from Object
Get-Service -ServiceName * | Select-Object -Property 'Status','DisplayName' |
    Sort-Object -Property 'Status' -Descending
    # Create functions
Function Display-Message()
{
	Write-Host "My Message" 
}

Function Display-Message($Text)
{
	Write-Host $Text
}

# Change the function to use arguments
Function Display-Message()
{
	[String]$Value1 = $args[0]
	[String]$Value2 = $args[1]

	Write-Host $Value1 $Value2
}

# Change the function to use parameter
Function Display-Message()
{
	Param(
    		[parameter(Mandatory=$true)]
    		[String]$Text
	)
	Write-Host $Text
}

Function Display-Message()
{
	Param(
    		[parameter(Mandatory=$true)]
            [ValidateSet("Lexus","Porsche","Toyota","Mercedes-Benz","BMW","Honda","Ford","Chevrolet")]
    		[String]$Text
	)
	Write-Host "I like to drive a "$Text
}
# View Members for an object
Get-Service -ServiceName 'Dnscache' | Get-Member

# Get the type of object
Get-Service | Get-Member -MemberType Property

# Get the properties of the object
Get-Service -ServiceName 'Dnscache' | Select-Object -Property 'StartType'

# Retrieve alias value
Get-Service | Get-Member -MemberType 'AliasProperty'

# Populate variable with object
$svc = Get-Service -ServiceName 'Dnscache'
$svc.Name
$svc.RequiredServices

# View the methods for an object
Get-Service | Get-Member -MemberType 'Method'

# Selecting values from a PowerShell Object
Get-Service -ServiceName * | Select-Object -Property 'Status','DisplayName'

# Sorting values from Object
Get-Service -ServiceName * | Select-Object -Property 'Status','DisplayName' |
    Sort-Object -Property 'Status' -Descending
    
# Filtering the objects
Get-Service * | Select-Object -Property 'Status','DisplayName' |
Where-Object -FilterScript {$_.Status -eq 'Running' -and $_.DisplayName -like "Windows*" |
    Sort-Object -Property 'DisplayName' -Descending | Format-Table -AutoSize

# Generate JSON
systeminfo /fo CSV | ConvertFrom-Csv | convertto-json | Out-File  "$($Location)\ComputerInfo.json"

# Load JSON
Get-Content -Path "$($Location)\ComputerInfo.json" | ConvertFrom-JSON

# Load JSON into a Grid View
Get-Content -Path "$($Location)\ComputerInfo.json" | ConvertFrom-JSON | Out-GridView

# Populate Variable with JSON and use Values
$jsonObject = Get-Content -Path "$($Location)\ComputerInfo.json" | ConvertFrom-JSON

$jsonObject.'Host Name'
$jsonObject.'Windows Directory'

# Manually Creating JSON
$jsonObject = @{}
$arrayList = New-Object System.Collections.ArrayList

$arrayList.Add(@{"Name"="Reid";"Surname"="Randolph";"Gender"="M";})
$arrayList.Add(@{"Name"="Scott";"Surname"="Best";"Gender"="M";})
$arrayList.Add(@{"Name"="Isabel";"Surname"="Mays";"Gender"="F";})
$arrayList.Add(@{"Name"="Marcia";"Surname"="Clark";"Gender"="F";})

$employees = @{"Employees"=$arrayList;}

$jsonObject.Add("Data",$employees)
$jsonObject | ConvertTo-Json -Depth 10 

# Import the members of a module into the current session
Import-Module -Name PSDiagnostics

# Import all modules specified by the module path
Get-Module -ListAvailable | Import-Module

# Import the members of several modules into the current session
$module = Get-Module -ListAvailable PSDiagnostics, Dism
Import-Module -ModuleInfo $module

# Restrict module members imported into a session
Import-Module PSDiagnostics -Function Disable-PSTrace, Enable-PSTrace
(Get-Module PSDiagnostics).ExportedCommands

# Import the members of a module and add a prefix
Import-Module PSDiagnostics -Prefix x -PassThru

# Import a module from a remote computer
$session = New-PSSession -ComputerName Server01
Get-Module -PSSession $session -ListAvailable -Name NetSecurity


# Explicit Loading
Import-Module -Name 'AzureAD' -UseWindowsPowerShell

# Implicit Loading
Import-Module -Name 'ServerManager'
Get-Module -Name 'ServerManager'

