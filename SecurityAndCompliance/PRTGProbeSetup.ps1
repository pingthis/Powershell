$GroupName = 'Performance Monitor Users'
$UserName = 'intra\prtgadmin'

Function Main{
Add-LocalGroupMember -Group $GroupName -Member $UserName
Set-WMIPerms  root/cimv2 add $GroupName Enable, RemoteAccess
Set-WMIPerms  root/cimv2 add $GroupName Enable, EnableAccount
Grant-ComPermission -Access -Identity $GroupName -Allow -Default -Local
Grant-ComPermission -LaunchAndActivation -Identity $GroupName -Limits -Allow -Local -Remote


}
Function Set-WMIPerms{
    # Copyright (c) Microsoft Corporation.  All rights reserved. 
# For personal use only.  Provided AS IS and WITH ALL FAULTS.
 
# Set-WmiNamespaceSecurity.ps1
# Example: Set-WmiNamespaceSecurity root/cimv2 add steve Enable,RemoteAccess
 
Param ( [parameter(Mandatory=$true,Position=0)][string] $namespace,
[parameter(Mandatory=$true,Position=1)][string] $operation,
[parameter(Mandatory=$true,Position=2)][string] $account,
[parameter(Position=3)][string[]] $permissions = $null,
[bool] $allowInherit = $false,
[bool] $deny = $false,
[string] $computerName = ".",
[System.Management.Automation.PSCredential] $credential = $null)

Process {
$ErrorActionPreference = "Stop"

Function Get-AccessMaskFromPermission($permissions) {
    $WBEM_ENABLE            = 1
            $WBEM_METHOD_EXECUTE = 2
            $WBEM_FULL_WRITE_REP   = 4
            $WBEM_PARTIAL_WRITE_REP              = 8
            $WBEM_WRITE_PROVIDER   = 0x10
            $WBEM_REMOTE_ACCESS    = 0x20
            $WBEM_RIGHT_SUBSCRIBE = 0x40
            $WBEM_RIGHT_PUBLISH      = 0x80
    $READ_CONTROL = 0x20000
    $WRITE_DAC = 0x40000
   
    $WBEM_RIGHTS_FLAGS = $WBEM_ENABLE,$WBEM_METHOD_EXECUTE,$WBEM_FULL_WRITE_REP,`
        $WBEM_PARTIAL_WRITE_REP,$WBEM_WRITE_PROVIDER,$WBEM_REMOTE_ACCESS,`
        $READ_CONTROL,$WRITE_DAC
    $WBEM_RIGHTS_STRINGS = "Enable","MethodExecute","FullWrite","PartialWrite",`
        "ProviderWrite","RemoteAccess","ReadSecurity","WriteSecurity"

    $permissionTable = @{}

    for ($i = 0; $i -lt $WBEM_RIGHTS_FLAGS.Length; $i++) {
        $permissionTable.Add($WBEM_RIGHTS_STRINGS[$i].ToLower(), $WBEM_RIGHTS_FLAGS[$i])
    }
   
    $accessMask = 0

    foreach ($permission in $permissions) {
        if (-not $permissionTable.ContainsKey($permission.ToLower())) {
            throw "Unknown permission: $permission`nValid permissions: $($permissionTable.Keys)"
        }
        $accessMask += $permissionTable[$permission.ToLower()]
    }
   
    $accessMask
}

if ($PSBoundParameters.ContainsKey("Credential")) {
    $remoteparams = @{ComputerName=$computer;Credential=$credential}
} else {
    $remoteparams = @{ComputerName=$computerName}
}
   
$invokeparams = @{Namespace=$namespace;Path="__systemsecurity=@"} + $remoteParams

$output = Invoke-WmiMethod @invokeparams -Name GetSecurityDescriptor
if ($output.ReturnValue -ne 0) {
    throw "GetSecurityDescriptor failed: $($output.ReturnValue)"
}

$acl = $output.Descriptor
$OBJECT_INHERIT_ACE_FLAG = 0x1
$CONTAINER_INHERIT_ACE_FLAG = 0x2

$computerName = (Get-WmiObject @remoteparams Win32_ComputerSystem).Name

if ($account.Contains('\')) {
    $domainaccount = $account.Split('\')
    $domain = $domainaccount[0]
    if (($domain -eq ".") -or ($domain -eq "BUILTIN")) {
        $domain = $computerName
    }
    $accountname = $domainaccount[1]
} elseif ($account.Contains('@')) {
    $domainaccount = $account.Split('@')
    $domain = $domainaccount[1].Split('.')[0]
    $accountname = $domainaccount[0]
} else {
    $domain = $computerName
    $accountname = $account
}

$getparams = @{Class="Win32_Account";Filter="Domain='$domain' and Name='$accountname'"}

$win32account = Get-WmiObject @getparams

if ($win32account -eq $null) {
    throw "Account was not found: $account"
}

switch ($operation) {
    "add" {
        if ($permissions -eq $null) {
            throw "-Permissions must be specified for an add operation"
        }
        $accessMask = Get-AccessMaskFromPermission($permissions)

        $ace = (New-Object System.Management.ManagementClass("win32_Ace")).CreateInstance()
        $ace.AccessMask = $accessMask
        if ($allowInherit) {
            $ace.AceFlags = $OBJECT_INHERIT_ACE_FLAG + $CONTAINER_INHERIT_ACE_FLAG
        } else {
            $ace.AceFlags = 0
        }
                   
        $trustee = (New-Object System.Management.ManagementClass("win32_Trustee")).CreateInstance()
        $trustee.SidString = $win32account.Sid
        $ace.Trustee = $trustee
       
        $ACCESS_ALLOWED_ACE_TYPE = 0x0
        $ACCESS_DENIED_ACE_TYPE = 0x1

        if ($deny) {
            $ace.AceType = $ACCESS_DENIED_ACE_TYPE
        } else {
            $ace.AceType = $ACCESS_ALLOWED_ACE_TYPE
        }

        $acl.DACL += $ace.psobject.immediateBaseObject
    }
   
    "delete" {
        if ($permissions -ne $null) {
            throw "Permissions cannot be specified for a delete operation"
        }
   
        [System.Management.ManagementBaseObject[]]$newDACL = @()
        foreach ($ace in $acl.DACL) {
            if ($ace.Trustee.SidString -ne $win32account.Sid) {
                $newDACL += $ace.psobject.immediateBaseObject
            }
        }

        $acl.DACL = $newDACL.psobject.immediateBaseObject
    }
   
    default {
        throw "Unknown operation: $operation`nAllowed operations: add delete"
    }
}

$setparams = @{Name="SetSecurityDescriptor";ArgumentList=$acl.psobject.immediateBaseObject} + $invokeParams

$output = Invoke-WmiMethod @setparams
if ($output.ReturnValue -ne 0) {
    throw "SetSecurityDescriptor failed: $($output.ReturnValue)"
}
}
}
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function Grant-ComPermission
{
    <#
    .SYNOPSIS
    Grants COM access permissions.
     
    .DESCRIPTION
    Calling this function is equivalent to opening Component Services (dcomcnfg), right-clicking `My Computer` under Component Services > Computers, choosing `Properties`, going to the `COM Security` tab, and modifying the permission after clicking the `Edit Limits...` or `Edit Default...` buttons under the `Access Permissions` section.
     
    You must set at least one of the `LocalAccess` or `RemoteAccess` switches.
     
    .OUTPUTS
    Carbon.Security.ComAccessRule.
 
    .LINK
    Get-ComPermission
 
    .LINK
    Revoke-ComPermission
     
    .EXAMPLE
    Grant-ComPermission -Access -Identity 'Users' -Allow -Default -Local
     
    Updates access permission default security to allow the local `Users` group local access permissions.
 
    .EXAMPLE
    Grant-ComPermission -LaunchAndActivation -Identity 'Users' -Limits -Deny -Local -Remote
     
    Updates access permission security limits to deny the local `Users` group local and remote access permissions.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]        
        $Identity,
        
        [Parameter(Mandatory=$true,ParameterSetName='DefaultAccessPermissionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineAccessRestrictionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='DefaultAccessPermissionDeny')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineAccessRestrictionDeny')]
        [Switch]
        # Grants Access Permissions.
        $Access,
        
        [Parameter(Mandatory=$true,ParameterSetName='DefaultLaunchPermissionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineLaunchRestrictionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='DefaultLaunchPermissionDeny')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineLaunchRestrictionDeny')]
        [Switch]
        # Grants Launch and Activation Permissions.
        $LaunchAndActivation,
        
        [Parameter(Mandatory=$true,ParameterSetName='DefaultAccessPermissionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='DefaultLaunchPermissionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='DefaultAccessPermissionDeny')]
        [Parameter(Mandatory=$true,ParameterSetName='DefaultLaunchPermissionDeny')]
        [Switch]
        # Grants default security permissions.
        $Default,
        
        [Parameter(Mandatory=$true,ParameterSetName='MachineAccessRestrictionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineLaunchRestrictionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineAccessRestrictionDeny')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineLaunchRestrictionDeny')]
        [Switch]
        # Grants security limits permissions.
        $Limits,
        
        [Parameter(Mandatory=$true,ParameterSetName='DefaultAccessPermissionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineAccessRestrictionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='DefaultLaunchPermissionAllow')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineLaunchRestrictionAllow')]
        [Switch]
        # If set, allows the given permissions.
        $Allow,
        
        [Parameter(Mandatory=$true,ParameterSetName='DefaultAccessPermissionDeny')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineAccessRestrictionDeny')]
        [Parameter(Mandatory=$true,ParameterSetName='DefaultLaunchPermissionDeny')]
        [Parameter(Mandatory=$true,ParameterSetName='MachineLaunchRestrictionDeny')]
        [Switch]
        # If set, denies the given permissions.
        $Deny,
                
        [Parameter(ParameterSetName='DefaultAccessPermissionAllow')]
        [Parameter(ParameterSetName='MachineAccessRestrictionAllow')]
        [Parameter(ParameterSetName='DefaultAccessPermissionDeny')]
        [Parameter(ParameterSetName='MachineAccessRestrictionDeny')]
        [Switch]
        # If set, grants local access permissions. Only valid if `Access` switch is set.
        $Local,
        
        [Parameter(ParameterSetName='DefaultAccessPermissionAllow')]
        [Parameter(ParameterSetName='MachineAccessRestrictionAllow')]
        [Parameter(ParameterSetName='DefaultAccessPermissionDeny')]
        [Parameter(ParameterSetName='MachineAccessRestrictionDeny')]
        [Switch]
        # If set, grants remote access permissions. Only valid if `Access` switch is set.
        $Remote,

        [Parameter(ParameterSetName='DefaultLaunchPermissionAllow')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionAllow')]
        [Parameter(ParameterSetName='DefaultLaunchPermissionDeny')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionDeny')]
        [Switch]
        # If set, grants local launch permissions. Only valid if `LaunchAndActivation` switch is set.
        $LocalLaunch,
        
        [Parameter(ParameterSetName='DefaultLaunchPermissionAllow')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionAllow')]
        [Parameter(ParameterSetName='DefaultLaunchPermissionDeny')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionDeny')]
        [Switch]
        # If set, grants remote launch permissions. Only valid if `LaunchAndActivation` switch is set.
        $RemoteLaunch,

        [Parameter(ParameterSetName='DefaultLaunchPermissionAllow')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionAllow')]
        [Parameter(ParameterSetName='DefaultLaunchPermissionDeny')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionDeny')]
        [Switch]
        # If set, grants local activation permissions. Only valid if `LaunchAndActivation` switch is set.
        $LocalActivation,
        
        [Parameter(ParameterSetName='DefaultLaunchPermissionAllow')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionAllow')]
        [Parameter(ParameterSetName='DefaultLaunchPermissionDeny')]
        [Parameter(ParameterSetName='MachineLaunchRestrictionDeny')]
        [Switch]
        # If set, grants remote activation permissions. Only valid if `LaunchAndActivation` switch is set.
        $RemoteActivation,

        [Switch]
        # Return a `Carbon.Security.ComAccessRights` object for the permissions granted.
        $PassThru
    )
    
    Set-StrictMode -Version 'Latest'

    Use-CallerPreference -Cmdlet $PSCmdlet -Session $ExecutionContext.SessionState
    
    $account = Resolve-Identity -Name $Identity -ErrorAction:$ErrorActionPreference
    if( -not $account )
    {
        return
    }

    $comArgs = @{ }
    if( $pscmdlet.ParameterSetName -like 'Default*' )
    {
        $typeDesc = 'default security permissions'
        $comArgs.Default = $true
    }
    else
    {
        $typeDesc = 'security limits'
        $comArgs.Limits = $true
    }
    
    if( $pscmdlet.ParameterSetName -like '*Access*' )
    {
        $permissionsDesc = 'Access'
        $comArgs.Access = $true
    }
    else
    {
        $permissionsDesc = 'Launch and Activation'
        $comArgs.LaunchAndActivation = $true
    }
    
    $currentSD = Get-ComSecurityDescriptor @comArgs -ErrorAction:$ErrorActionPreference

    $newSd = ([wmiclass]'win32_securitydescriptor').CreateInstance()
    $newSd.ControlFlags = $currentSD.ControlFlags
    $newSd.Group = $currentSD.Group
    $newSd.Owner = $currentSD.Owner

    $trustee = ([wmiclass]'win32_trustee').CreateInstance()
    $trustee.SIDString = $account.Sid.Value

    $ace = ([wmiclass]'win32_ace').CreateInstance()
    $accessMask = [Carbon.Security.ComAccessRights]::Execute
    if( $Local -or $LocalLaunch )
    {
        $accessMask = $accessMask -bor [Carbon.Security.ComAccessRights]::ExecuteLocal
    }
    if( $Remote -or $RemoteLaunch )
    {
        $accessMask = $accessMask -bor [Carbon.Security.ComAccessRights]::ExecuteRemote
    }
    if( $LocalActivation )
    {
        $accessMask = $accessMask -bor [Carbon.Security.ComAccessRights]::ActivateLocal
    }
    if( $RemoteActivation )
    {
        $accessMask = $accessMask -bor [Carbon.Security.ComAccessRights]::ActivateRemote
    }
    
    Write-Verbose ("Granting {0} {1} COM {2} {3}." -f $Identity,([Carbon.Security.ComAccessRights]$accessMask),$permissionsDesc,$typeDesc)

    $ace.AccessMask = $accessMask
    $ace.Trustee = $trustee

    # Remove DACL for this user, if it exists, so we can replace it.
    $newDacl = $currentSD.DACL | 
                    Where-Object { $_.Trustee.SIDString -ne $trustee.SIDString } | 
                    ForEach-Object { $_.PsObject.BaseObject }
    $newDacl += $ace.PsObject.BaseObject
    $newSd.DACL = $newDacl

    $converter = New-Object Management.ManagementClass 'Win32_SecurityDescriptorHelper'
    $sdBytes = $converter.Win32SDToBinarySD( $newSd )

    $regValueName = $pscmdlet.ParameterSetName -replace '(Allow|Deny)$',''
    Set-RegistryKeyValue -Path $ComRegKeyPath -Name $regValueName -Binary $sdBytes.BinarySD -Quiet -ErrorAction:$ErrorActionPreference
    
    if( $PassThru )
    {
        Get-ComPermission -Identity $Identity @comArgs -ErrorAction:$ErrorActionPreference
    }
}
Main

