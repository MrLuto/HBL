______________________________________________________________
Door Gerrit Boone op 22-12-2014 13:25

$LiveCred = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection

Rechten toevoegen op agenda script:
###########################
foreach($user in Get-Mailbox -RecipientTypeDetails UserMailbox) {
$cal = $user.Name+":\Agenda" 
add-MailboxFolderPermission -Identity $cal -User info -AccessRights PublishingEditor
add-MailboxFolderPermission -Identity $cal -User mvdwiel -AccessRights owner
}

#handmatige regels
remove-MailboxFolderPermission -Identity gerrald@installatietechniekbouwheer.nl:\Agenda -user maartenbouwheer@installatietechniekbouwheer.nl

add-MailboxFolderPermission -Identity  anton@sadienstverlening.nl:\Calander -user Bertine@sadienstverlening.nl -AccessRights editor
add-MailboxFolderPermission -Identity  anton@sadienstverlening.nl:\Agenda -user Bertine@sadienstverlening.nl -AccessRights editor


get-MailboxFolderPermission -Identity planning@hardemanvloerbewerking.nl:\Agenda 




Get-User -Identity gerrald