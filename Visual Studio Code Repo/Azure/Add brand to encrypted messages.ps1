Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

# Replace BooneIT with own template name
$OMEname = "BooneIT"
Set-OMEConfiguration -Identity "$OMEname" -Image (Get-Content "C:\tmp\Boone_logo_RGB_high.png" -Encoding byte) 
Set-OMEConfiguration -Identity "$OMEname" -IntroductionText "heeft je een beveiligde e-mail verzonden."
Set-OMEConfiguration -Identity "$OMEname" -ReadButtonText "Open bericht."
Set-OMEConfiguration -Identity "$OMEname" -EmailText "Versleuteld bericht vanuit het Boone IT e-mail systeem"
Set-OMEConfiguration -Identity "$OMEname" -DisclaimerText "Dit bericht is alleen bestemd voor de ontvanger."
Set-OMEConfiguration -Identity "$OMEname" -PortalText "Boone IT secure email portal."
Set-OMEConfiguration -Identity "$OMEname" -OTPEnabled $true
Set-OMEConfiguration -Identity "$OMEname" -SocialIdSignIn $true
Set-OMEConfiguration -Identity "$OMEname" -BackgroundColor $null

# Create an Exchange mail flow rule that applies custom branding to encrypted emails
# https://docs.microsoft.com/nl-nl/office365/securitycompliance/add-your-organization-brand-to-encrypted-messages