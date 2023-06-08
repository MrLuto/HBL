
$date = Get-Date -Format "dddd dd-MM-yyyy HH:mm"

#Via SMTP Auth port 587  let op: security defaults moet uit staan en SMTP Auth moet op tenant en user niveua aan staan, graag via app password zodat user zijn wachtwoord kan wijzigen. 
$creds = get-credential
Send-MailMessage -From bnp@predikanten.nl -To gerrit@booneit.nl -Subject "Test Email" -Body "Test SMTP Service from Powershell on Port 587" -SmtpServer smtp.office365.com -Credential $creds -UseSsl -Port 587
Send-MailMessage -From info@wijnkoperijplatenburg.nl -To stef@booneit.nl -Subject "Test Email" -Body "Test SMTP Service from Powershell on Port 587" -SmtpServer smtp.office365.com -Credential $creds -UseSsl -Port 587

#SMTP Auth moet op tenant
Get-TransportConfig | Format-List SmtpClientAuthenticationDisabled
Set-TransportConfig -SmtpClientAuthenticationDisabled $false

#via poort 25 in combinatie met whitelisted IP op de exchange connector
Send-MailMessage -From scanner@confix.nl -TO scanner@confix.nl -SmtpServer confix-nl.mail.protection.outlook.com  -Subject "Test Email 25" -Body "Test SMTP Service from Powershell on Port 25  https://mxtoolbox.com/"