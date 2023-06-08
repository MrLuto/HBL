Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session


#Regel om nieuwe rechten toe te voegen:
#Add-MailboxFolderPermission -Identity [gedeelde mailbox naam]:\calendar -User [user die rechte krijgt] -AccessRights Editor
#
#
#Regel om rechten op postvak te bekijken ( | FL toevoegen voor uitgebreide informatie)
#Get-MailboxFolderPermission -Identity [gedeelde mailbox naam]:\calendar | fl user
#
#
#Regel om naam van calendar map op te halen
#Get-MailboxFolderStatistics -Identity [gedeelde mailbox naam] | fl name