##############################
#Verbinding maken
##############################
#via script connect to exchange online customer tenant.ps1


##############################
#Automapping uit bij specefieke gebruiker
##############################
$rechten = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited | Get-MailboxPermission | Select-Object Identity,User | Where-Object {($_.user -like 'administratie@nibofreeswerk.nl')} 

foreach  ($user in $rechten) {
    Add-MailboxPermission -Identity $user.Identity  -User $user.User -AccessRight FullAccess  -Automapping $true
}

##############################
#Automapping uit bij specefieke gebruiker per mailbox
##############################

$user1 = "info@vakanz.nl"
$user2 = "johan@vakanz.nl"

Add-MailboxPermission -Identity $user1  -User $user2 -AccessRight FullAccess  -Automapping $false