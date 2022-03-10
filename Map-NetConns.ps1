function Get-TimeStamp {
    Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
}
Start-Transcript "$loggingdirectory\$($Host.Name)_$($Host.Version)_$(Get-TimeStamp).txt"
Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
$Error.Clear();
try {
    # Do work – Put the main body of your script here
    <#
If specific errors are encountered, use throw to break out
of try for non-terminating/business logic errors.
Throw "$(Get-TimeStamp): Include custom reporting on business
logic/non-terminating errors."
#>


}
catch {
    @"
$(Get-TimeStamp): $('-' * 50)
$(Get-TimeStamp): -- SCRIPT PROCESSING CANCELLED
$(Get-TimeStamp): $('-' * 50)
$(Get-TimeStamp):
$(Get-TimeStamp): Error in $($_.InvocationInfo.ScriptName).
$(Get-TimeStamp):
$(Get-TimeStamp): $('-' * 50)
$(Get-TimeStamp): -- Error information
$(Get-TimeStamp): $('-' * 50)
$(Get-TimeStamp):
$(Get-TimeStamp): Error Details: $($_)
$(Get-TimeStamp): Line Number: $($_.InvocationInfo.ScriptLineNumber)
$(Get-TimeStamp): Offset: $($_.InvocationInfo.OffsetInLine)
$(Get-TimeStamp): Command: $($_.InvocationInfo.MyCommand)
$(Get-TimeStamp): Line: $($_.InvocationInfo.Line)
"@
}
finally {
    Stop-Transcript
}