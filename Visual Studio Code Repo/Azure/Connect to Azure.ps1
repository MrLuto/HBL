## Install latest version of AzureAd powershell module ##
Install-Module -Name AzureAD -Force

## Connect to Office 365 ##
disConnect-MsolService

## Connect to AzureAD
Connect-AzureAD

## Create security groups ##
New-MsolGroup -DisplayName “Group_Intune”
New-MsolGroup -DisplayName “Software_MS Office”


## Change passwordpolicy to never expire ##
Get-AzureADUser | Select-Object UserPrincipalName, PasswordPolicies
Get-AzureADUser -All $true | Set-AzureADUser -PasswordPolicies DisablePasswordExpiration


Disconnect-AzureAD
Disconnect-ExchangeOnlinea
[Microsoft.Online.Administration.Automation.ConnectMsolService]::ClearUserSessionState()
