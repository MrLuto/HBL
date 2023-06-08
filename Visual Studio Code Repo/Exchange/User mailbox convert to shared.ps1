https://oddytee.wordpress.com/2014/02/14/convert-user-mailboxes-to-shared-mailboxes-in-office-365/

################################
Stap 1.  Verbinding maken
################################
Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

################################
Stap 2. Mailbox conversie
################################
Get-Mailbox -identity bert.vantoledo@smartrecruit.nl | set-mailbox -type "Shared"


################################
Stap 3. laat alle shared mailboxen zien
################################
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited | Select Identity,Alias,DisplayName | sort displayname


################################
Stap 4 laat alle user mailboxen zien
################################
Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize:Unlimited | Select Identity,Alias,DisplayName | sort displayname