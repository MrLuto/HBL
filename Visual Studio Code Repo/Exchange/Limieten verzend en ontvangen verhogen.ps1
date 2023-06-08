https://practical365.com/exchange-server/configuring-max-email-message-size-limits-for-office-365/


===Verbinding maken===
Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

==bekijk mailbox plans==
Get-MailboxPlan | fl name,maxsendsize,maxreceivesize,isdefault

==bekijk aan welk plan hoeveelheid mailboxen gekoppeld zijn==
Get-Mailbox | Group-Object -Property:MailboxPlan | Select Name,Count | ft -auto

==bekijk aan welk plan specefieke adressen gekoppeld zijn. ==
get-mailbox | where {$_.mailboxplan -eq "naam plan"}

==vergroot de verzend limieten ==
Set-MailboxPlan ExchangeOnlineEnterprise-8b1df863-c9eb-4576-aaba-ba4440bc7763 -MaxSendSize 55MB -MaxReceiveSize 55MB
