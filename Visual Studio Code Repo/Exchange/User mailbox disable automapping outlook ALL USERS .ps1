##############################
#Verbinding maken
##############################
#via script connect to exchange online customer tenant.ps1


##############################
#Automapping uit bij specefieke gebruiker
##############################
Add-MailboxPermission -Identity kevinkinkel@walravendeurenservice.nl -User hankie.walraven@walravendeurenservice.nl -AccessRight FullAccess  -Automapping $true


####################################################################################################################################################################################
#Centraal opver de hele omgeving heen!
#Onderstaande code zorgt er voor dat iedereeen die rechten op een mailbox heeft dit nooit via automapping toegevoegd krijgt in outlook
#Dit script mag altijd uitgevoerd worden zoals bij Diemmax die dit principe hanteert. 
####################################################################################################################################################################################

$rechten = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize:Unlimited | Get-MailboxPermission | Select-Object Identity,User | Where-Object {($_.user -like '*@*')} 

foreach  ($user in $rechten) {
    Add-MailboxPermission -Identity bertine@dekoningadvies.com  -User $user.User -AccessRight FullAccess  -Automapping $true
}

foreach  ($user in $rechten) {
    Add-MailboxPermission -Identity $user.Identity  -User $user.User -AccessRight FullAccess  -Automapping $false
}