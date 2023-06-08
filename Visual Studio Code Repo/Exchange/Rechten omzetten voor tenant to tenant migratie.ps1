#Rechten op postvak van alle users exporteren
$export_dir = "" #Pad waar de export moet komen
get-mailbox | Get-MailboxPermission | ft Identity,User,AccessRights >> "$export_dir\export.csv" -Wrap

#Rechten importeren
$username = "Email adres van gebruiker"              #De gebruiker die rechten krijg
$identities = @("Lijst","van","Email adressen")      #De lijst met adressen waar hij rechten op krijgt
foreach ($identity in $identities) {
Add-MailboxPermission -identity $user -user $username -AccessRights fullaccess
}