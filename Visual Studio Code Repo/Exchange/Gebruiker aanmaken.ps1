if ($null -eq $UserCredential){
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
Connect-MsolService -Credential $UserCredential
}else{
$email = Read-Host 'Email adres:'
$firstname = Read-Host 'Voornaam:'
$lastname = Read-Host 'Lastname:'
$displayname = Read-Host 'Displayname:'
$LicenseSKU = Get-MsolAccountSku |
              Out-GridView -Title 'Select a license plan to assign to users' -OutputMode Single |
              Select-Object -ExpandProperty AccountSkuId
$password = Read-Host "Password:" -AsSecureString

New-Mailbox -DisplayName $displayname -FirstName $firstname -LastName $lastname -name $displayname -Password $password -PrimarySmtpAddress $email -ResetPasswordOnNextLogon $false -MicrosoftOnlineServicesID $email
pause
Set-MailboxRegionalConfiguration -Identity $email -Language nl-NL -LocalizeDefaultFolderName -TimeZone "W. Europe Standard Time" -TimeFormat HH:mm -DateFormat d-M-yyyy
$ObjectID = Get-Mailbox -Identity $email | Select -ExpandProperty ExternalDirectoryObjectID
Set-MsolUser -ObjectId $objectID -UsageLocation NL
Set-MsolUserLicense -AddLicenses $LicenseSKU -ObjectId $ObjectID
Set-FocusedInbox -Identity $email -FocusedInboxOn $false
}