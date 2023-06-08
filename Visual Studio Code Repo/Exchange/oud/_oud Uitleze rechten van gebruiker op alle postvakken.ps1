#Selecteer type mailbox: roomMailbox, sharedMailbox of userMailbox
$type = 
#Bepaal de query
$Mailboxes = Get-Mailbox -ResultSize:Unlimited | Select Identity,Alias,DisplayName | sort displayname
#Output in bestand C:\SharedPermissions.txt
$mailboxes | sort displayname | foreach {Get-MailboxPermission -Identity $_.alias | ft identity,user,accessrights} >> C:\temp\SharedPermissions.txt