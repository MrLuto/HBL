#ophalen van GUID verwijderde mailbox
Get-Mailbox -SoftDeletedMailbox -Identity lindystokdijk | format-list

#manier 1, via GUID
New-MailboxRestoreRequest -SourceMailbox 6da41498-c369-4fe2-bf8f-193494a9224d -TargetMailbox lindy2@promasian.nl -AllowLegacyDNMismatch

#manier 2, via UPN
New-MailboxRestoreRequest -SourceMailbox lindy@promasian.nl -TargetMailbox lindy2@promasian.nl -AllowLegacyDNMismatch

#opvragen status mailboxomzetting
Get-MailboxRestoreRequest

#source
https://blog.thenetw.org/2020/01/29/recover-e-mails-from-user-account-permanently-deleted-in-azure-active-directory-office-365/
https://83590.afasinsite.nl/ticket?SbId=38819