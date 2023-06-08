Connect-MsolService
Get-MsolAccountSku

Get-MsolUser -All | Where-Object { $_.isLicensed -eq “TRUE” -and $_.Licenses.AccountSKUID -eq “educatisrpo:M365EDU_A3_FACULTY“} | Select Displayname,UserPrincipalName,isLicensed,Licenses

Get-MsolUser -All | Where-Object { $_.isLicensed -eq “TRUE” -and $_.Licenses.AccountSKUID -eq “fraanjeschool:M365EDU_A3_STUUSEBNFT“} | Select Displayname,UserPrincipalName,isLicensed,Licenses



Get-MsolUser -All | Where {$.isLicensed -eq “TRUE” -and $.Licenses.AccountSKUID -eq “kgsdiamondgroup:O365_BUSINESS_PREMIUM“} | Select Displayname,UserPrincipalName,isLicensed,Licenses

Set-MsolUserLicense -UserPrincipalName “d.wang@kgs.swiss” –AddLicenses “kgsdiamondgroup:SPB“ –RemoveLicenses “kgsdiamondgroup:O365_BUSINESS_PREMIUM“, "kgsdiamondgroup:ATP_ENTERPRISE"
Set-MsolUserLicense -UserPrincipalName “d.wang@kgs.swiss” –RemoveLicenses "kgsdiamondgroup:ATP_ENTERPRISE"

Get-MsolUser -All | Where {$_.isLicensed -eq “TRUE” -and $_.Licenses.AccountSKUID -eq “educatisrpo:M365EDU_A3_FACULTY“} | Set-MsolUserLicense –AddLicenses "educatisrpo:ENTERPRISEPACKPLUS_FACULTY" –RemoveLicenses “educatisrpo:M365EDU_A3_FACULTY“

Get-MsolUser -All | Where {$.isLicensed -eq “TRUE” -and $.Licenses.AccountSKUID -eq “kgsdiamondgroup:O365_BUSINESS_PREMIUM“} | Set-MsolUserLicense –AddLicenses “kgsdiamondgroup:SPB“ –RemoveLicenses “kgsdiamondgroup:O365_BUSINESS_PREMIUM“
Get-MsolUser -All | Where {$.isLicensed -eq “TRUE” -and $.Licenses.AccountSKUID -eq “kgsdiamondgroup:EXCHANGEENTERPRISE“} | Set-MsolUserLicense –AddLicenses “kgsdiamondgroup:SPB“ –RemoveLicenses “kgsdiamondgroup:O365_BUSINESS_PREMIUM“, "kgsdiamondgroup:EXCHANGEENTERPRISE"
Get-MsolUser -All | Where {$.isLicensed -eq “TRUE” -and $.Licenses.AccountSKUID -eq “kgsdiamondgroup:ENTERPRISEPACK“} | Set-MsolUserLicense –AddLicenses “kgsdiamondgroup:SPB“ –RemoveLicenses "kgsdiamondgroup:ENTERPRISEPACK"

Set-MsolUserLicense -UserPrincipalName “accounting-ind@kgs.swiss” –AddLicenses “kgsdiamondgroup:ATP_ENTERPRISE“


Get-MsolUser -All | Where {$.isLicensed -eq “TRUE” -and $.Licenses.AccountSKUID -eq “kgsdiamondgroup:ATP_ENTERPRISE“} | Set-MsolUserLicense –AddLicenses “kgsdiamondgroup:O365_BUSINESS_PREMIUM“ –RemoveLicenses “kgsdiamondgroup:O365_BUSINESS_ESSENTIALS“
Get-MsolUser -All | Where {$.isLicensed -eq “TRUE” -and $.Licenses.AccountSKUID -eq “kgsdiamondgroup:O365_BUSINESS_ESSENTIALS“} | Set-MsolUserLicense –AddLicenses “kgsdiamondgroup:SPB“ –RemoveLicenses “kgsdiamondgroup:O365_BUSINESS_ESSENTIALS“
Get-MsolUser -All | Where {$.isLicensed -eq “TRUE” -and $.Licenses.AccountSKUID -eq “kgsdiamondgroup:O365_BUSINESS_PREMIUM“} | Set-MsolUserLicense –AddLicenses “kgsdiamondgroup:O365_BUSINESS_ESSENTIALS“ –RemoveLicenses “kgsdiamondgroup:O365_BUSINESS_PREMIUM“