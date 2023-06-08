Param(   
    [Parameter(Mandatory = $false, HelpMessage="By setting this to true you can retrieve a list of all users with the specified license")]
    [boolean]$RenderLicensedUsers = $true,
    [Parameter(Mandatory = $false, HelpMessage="By setting this to true all users will be updated with a new license and keep their old license")]
    [boolean]$addNewLicense = $false,
    [Parameter(Mandatory = $false, HelpMessage="By setting this to true the old license will be revoked")]
    [boolean]$removeOldLicense = $false
    )


$modules = Get-Module -Name MSOnline -ListAvailable
    if ($null -eq $modules) {
        Write-Host -f Red "Installing required PowerShell modules"
        Install-Module MSOnline
        Import-Module -Name MSOnline -DisableNameChecking
    }


Connect-MsolService


if($?) {
    $licensesMappings = 
    @([pscustomobject]@{oldLicense="ENTERPRISEPACK_FACULTY";newLicenses=@("ENTERPRISEPACKPLUS_FACULTY", "EMS");},
    [pscustomobject]@{oldLicense="OFFICESUBSCRIPTION_STUDENT";newLicenses=@("ENTERPRISEPACKPLUS_STUDENT", "EMS");},
    [pscustomobject]@{oldLicense="EMS";newLicenses=@("ENTERPRISEPACKPLUS_FACULTY", "EMS");},
    [pscustomobject]@{oldLicense="AAD_PREMIUM";newLicenses=@("ENTERPRISEPACKPLUS_STUDENT", "EMS");},
    [pscustomobject]@{oldLicense="INTUNE_A_VL";newLicenses=@("ENTERPRISEPACKPLUS_STUDENT", "EMS");})

    Write-Host -f green "Your tenant has the following licenses:"
    Get-MsolAccountSku | FT

    foreach ($mapping in $licensesMappings) {
       $users = Get-MsolUser | Where-Object {($_.licenses).AccountSkuId -match $mapping.oldLicense}
       $oldLicense = Get-MsolAccountSku | Where-Object {$_.AccountSkuId -match $mapping.oldLicense}
       $aoneTeacher = Get-MsolAccountSku | Where-Object {$_.AccountSkuId -match "STANDARDWOFFPACK_FACULTY"}
       $aoneStudent = Get-MsolAccountSku | Where-Object {$_.AccountSkuId -match "STANDARDWOFFPACK_STUDENT"}
       
       if($renderLicensedUsers) {
            Write-Host -f green "The following users have a license:" $mapping.oldLicense 
            $users | FT UserPrincipalName, DisplayName
        }

        if($addNewLicense) {
            $newLicenses = New-Object System.Collections.Generic.List[System.Object]

            foreach ($newLicenseName in $mapping.newLicenses) {
                $newLicense = Get-MsolAccountSku | Where-Object {$_.AccountSkuId -match $newLicenseName}
                $newLicenses.add($newLicense[0].AccountSkuId);
            }

            
            if($removeOldLicense) {
                $users | foreach {
                    $objectId = $_.ObjectId;

                    if($mapping.oldLicense -contains "AAD_PREMIUM" -or $mapping.oldLicense -contains "INTUNE_A_VL"){
                        Set-MsolUserLicense -RemoveLicenses $aoneStudent[0].AccountSkuId -ObjectId $objectId -ErrorAction SilentlyContinue
                        Set-MsolUserLicense -RemoveLicenses $oldLicense[0].AccountSkuId -ObjectId $objectId -ErrorAction SilentlyContinue
                    }
                    if($mapping.oldLicense -contains "EMS"){
                        Set-MsolUserLicense -RemoveLicenses $aoneTeacher[0].AccountSkuId -ObjectId $objectId -ErrorAction SilentlyContinue
                    }
                    $newLicenses | foreach {
                        Set-MsolUserLicense -AddLicenses $_ -ObjectId $objectId -ErrorAction SilentlyContinue
                    }
                    if($mapping.oldLicense -notcontains "EMS" -and $mapping.oldLicense -notcontains "AAD_PREMIUM" -and $mapping.oldLicense -notcontains "INTUNE_A_VL"){
                        Set-MsolUserLicense -RemoveLicenses $oldLicense[0].AccountSkuId -ObjectId $objectId -ErrorAction SilentlyContinue
                    }
                }
            }
            else {
                $users | foreach {
                    $objectId = $_.ObjectId;
                    $newLicenses | foreach {
                        Set-MsolUserLicense -AddLicenses $_ -ObjectId $objectId -ErrorAction SilentlyContinue
                    }
                }
            }
        }
     }
} else {
    Write-Host -f Red " Could not connect"; 
}