<#
    Author: Charishma Batchu
    Release Date: 10/27/2021

    Name: Get-ComputerInfo.ps1
    The purpose of this script is to retrieve basic computer info

    Parameters: ComputerName
    This is mandatory parameter that is needed to provide the name of the computer to retrieve the information

    Example: Run Get-ComputerInfo.ps1 -ComputerName X060-CTXDT85 to retrieve the info
#>

[CmdletBinding()]
PARAM(
    [Parameter(Mandatory=$true)][String] $ComputerName
)

try
{
    # X060-CTXDT85
    Write-Host "Chceking connection for Computer $ComputerName"
    $connection = Test-Connection $ComputerName -Count 1 -Quiet
     Write-Host "Connection established successfully for Computer $ComputerName"

    if($connection -eq "True")
    {
        $params = @{'ComputerName'=$ComputerName;
                    'Class'='CIM_ComputerSystem';
                    'ErrorAction'='Stop'}
        Write-Host "Retrieving information for Computer $ComputerName"
        $cimInfo = Get-CimInstance @params | 
                                    Select-Object Caption,
                                                  Description,
                                                  InstallDate,
                                                  Name,
                                                  Status,
                                                  DNSHostName,
                                                  Domain,
                                                  HypervisorPresent,
                                                  InfraredSupported,
                                                  Manufacturer,
                                                  Model,
                                                  NumberOfLogicalProcessors,
                                                  NumberOfProcessors,
                                                  PartOfDomain,
                                                  SystemSKUNumber,
                                                  SystemType,
                                                  UserName,
                                                  NameFormat,
                                                  PrimaryOwnerContact,
                                                  PrimaryOwnerName,
                                                  Roles,
                                                  InitialLoadInfo,
                                                  LastLoadInfo,
                                                  PowerManagementCapabilities,
                                                  PowerManagementSupported,
                                                  PowerState,
                                                  ResetCapability,
                                                  AdminPasswordStatus,
                                                  AutomaticManagedPagefile,
                                                  AutomaticResetBootOption,
                                                  AutomaticResetCapability,
                                                  CurrentTimeZone,
                                                  DaylightInEffect
                                              


        if($cimInfo.Name -ne '')
        {
            $filePath = "$PSScriptRoot\$ComputerName.json"
            $cimInfo | ConvertTo-json | Out-File $filePath
            #$computerInfo = Get-ComputerInfo | ConvertTo-json | Out-File "C:\Users\BATCHUC\Desktop\info.json"
        }
         Write-Host "Successfully exported $ComputerName information to $filePath"
    }
}
catch{
    Write-Warning "Failed to retrieve information for computer $ComputerName"
    Write-Warning "Error Message $_"
}