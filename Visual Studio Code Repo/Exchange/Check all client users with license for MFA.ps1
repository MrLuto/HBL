$customers = Get-MsolPartnerContract -All
Write-Host "Found $($customers.Count) customers for $((Get-MsolCompanyInformation).displayname)." -ForegroundColor DarkGreen
$CSVpath = "C:\Temp\UserLicenseReportMFA.csv"
  
foreach ($customer in $customers) {
    Write-Host "Retrieving license info for $($customer.name)" -ForegroundColor Green
    $licensedUsers = Get-MsolUser -TenantId $customer.TenantId -All | Where-Object {$_.islicensed}
  
    foreach ($user in $licensedUsers) {
        Write-Host "$($user.displayname)" -ForegroundColor Yellow  
        $licenses = $user.Licenses
        $licenseArray = $licenses | foreach-Object {$_.AccountSkuId}
        $licenseString = $licenseArray -join ", "
        Write-Host "$($user.displayname) has $licenseString and MFA: "
		Write-Host "$user.StrongAuthenticationRequirements.State "
        $licensedSharedMailboxProperties = [pscustomobject][ordered]@{
            CustomerName      = $customer.Name
            DisplayName       = $user.DisplayName
            Licenses          = $licenseString
            TenantId          = $customer.TenantId
            UserPrincipalName = $user.UserPrincipalName
	    MFAStatus		  = $user.StrongAuthenticationRequirements.State 
        }
        $licensedSharedMailboxProperties | Export-CSV -Path $CSVpath -Append -NoTypeInformation   
    }
}