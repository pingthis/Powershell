<#Be sure to run the commands in Powershell.  (To launch Powershell, open an Administrator Command Prompt and type "start powershell" and press enter)
View all preinstalled:
    Get-AppxPackage -AllUsers

Remove all pre-installed apps for Windows 10:
	Get-AppxPackage -AllUsers | Remove-AppxPackage

To prevent these pre-installed apps from reinstalling for new users:
	Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage –online

To prevent all pre-installed apps from reinstalling for new users except store:
#>
#Get-AppxProvisionedPackage –online | where {$_.packagename –notlike “*store*”} | Remove-AppxProvisionedPackage -online
#Get-AppxProvisionedPackage -online | where {$_.packagename -like "Microsoft.Microsoft*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.G*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.Web*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsMaps*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsAlarms*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsCamera*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsFeedbackHub*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.WindowsMaps*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.Messaging*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.MixedReality.Portal*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.X*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.Z*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.O*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.P*"} | Remove-AppxProvisionedPackage -online
Get-AppxProvisionedPackage -online | Where-Object {$_.packagename -like "Microsoft.S*"} | Remove-AppxProvisionedPackage -online

get-appxpackage *3dbuilder* | remove-appxpackage
get-appxpackage *alarms* | remove-appxpackage
get-appxpackage *bing* | remove-appxpackage
#get-appxpackage *calculator* | remove-appxpackage
get-appxpackage *camera* | remove-appxpackage
get-appxpackage *commsphone* | remove-appxpackage
get-appxpackage *communicationsapps* | remove-appxpackage
get-appxpackage *getstarted* | remove-appxpackage
get-appxpackage *maps* | remove-appxpackage
get-appxpackage *messaging* | remove-appxpackage
#get-appxpackage *officehub* | remove-appxpackage
#get-appxpackage *onenote* | remove-appxpackage
#get-appxpackage *people* | remove-appxpackage
get-appxpackage *phone* | remove-appxpackage
get-appxpackage *photos* | remove-appxpackage
get-appxpackage *skypeapp* | remove-appxpackage
get-appxpackage *solitaire* | remove-appxpackage
get-appxpackage *soundrecorder* | remove-appxpackage
get-appxpackage *sway* | remove-appxpackage
get-appxpackage *windowsphone* | remove-appxpackage
get-appxpackage *windowsstore* | remove-appxpackage
#get-appxpackage *xbox* | remove-appxpackage
get-appxpackage *zune* | remove-appxpackage
get-appxpackage *zunemusic* | remove-appxpackage
get-appxpackage *zunevideo* | remove-appxpackage
