
param(
    [Parameter()]
    [string]$ComputerName
    )
Write-Host "************************************" 
Write-Host "PROCESS SCRIPT Running for $ComputerName" 
Write-Host "************************************" 
$Proc = "avp"
Get-Process $Proc -ComputerName $ComputerName `
 | Format-Table `
        Processname, ID, MachineName,
        @{Label = "CPU(s)"; Expression = {if ($_.CPU) {$_.CPU.ToString("N")}}},
        @{Label = "NPM(K)"; Expression = {[int]($_.NPM / 1024)}},
        @{Label = "PM(M)"; Expression = {[int]($_.PM / 1024)}},
        @{Label = "Company"; Expression = {[string]($_.Company)}},
        @{Label = "Ver"; Expression = {[string]($_.Fileversion)}}
        -AutoSize
        