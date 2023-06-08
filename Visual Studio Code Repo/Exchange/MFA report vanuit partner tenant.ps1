#  aanmelden met eigen @booneit.nl referenties
connect-msolservice
##

##  locatie rapportage
$CSVpath = "C:\_Temp\UserLicenseReport.csv"
#

$customers = Get-MsolPartnerContract -All
Write-Host "Found $($customers.Count) customers for $((Get-MsolCompanyInformation).displayname)." -ForegroundColor DarkGreen

foreach ($customer in $customers) {
Write-Host "Retrieving license info for $($customer.name)" -ForegroundColor Green
$licensedUsers = Get-MsolUser -TenantId $customer.TenantId -All
foreach ($user in $licensedUsers) {
Write-Host "$($user.displayname)" -ForegroundColor Yellow
$licenses = $user.Licenses
$licenseArray = $licenses | foreach-Object {$_.AccountSkuId}
$licenseString = $licenseArray -join ", "
Write-Host "$($user.displayname) has $licenseString and" -ForegroundColor Blue

$licensedSharedMailboxProperties = [pscustomobject][ordered]@{
CustomerName = $customer.Name
DisplayName = $user.DisplayName
Licenses = $licenseString
TenantId = $customer.TenantId
UserPrincipalName = $user.UserPrincipalName
mfaEnd = $user.StrongAuthenticationRequirements.State
}
$licensedSharedMailboxProperties | Export-CSV -Path $CSVpath -Append -NoTypeInformation
}
}