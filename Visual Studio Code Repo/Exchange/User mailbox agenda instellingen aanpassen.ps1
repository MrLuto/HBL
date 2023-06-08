Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

$mailboxname = Read-Host -Prompt 'Voer hier het email adres in'
$rechten = Read-Host -Prompt 'Wie moet rechten krijgen op agenda'

add-MailboxFolderPermission -Identity $mailboxname':\calendar' -User $rechten -AccessRights editor
add-MailboxFolderPermission -Identity $mailboxname':\Kalender' -User $rechten -AccessRights editor
add-MailboxFolderPermission -Identity $mailboxname':\Agenda' -User $rechten -AccessRights editor

Remove-PSSession $Session
pause
exit