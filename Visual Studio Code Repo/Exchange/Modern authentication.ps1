Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

Connect-ExchangeOnline -UserPrincipalName admin@kpn1112918.onmicrosoft.com

Get-OrganizationConfig | Format-Table Name,OAuth* -Auto
Set-OrganizationConfig -OAuth2ClientProfileEnabled $true


https://support.microsoft.com/en-us/help/3126599/outlook-prompts-for-password-when-modern-authentication-is-enabled