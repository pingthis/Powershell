<#Get-Computer information from AD imported from csv#>
$ErrorActionPreference= 'silentlycontinue'
$computers = import-csv -Path C:\Users\thom7010\Downloads\ManagedComputerSummary.csv

foreach($comp in $Computers){
    #write-host $comp.'Computer Name'
    Get-ADComputer $comp.'Computer Name' | Select-Object DNSHostName, Enabled
}

