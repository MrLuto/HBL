Connect-ExchangeOnline
Get-exomailbox -ResultSize unlimited | Set-MailboxRegionalConfiguration -Language 1043 -TimeZone "W. Europe Standard Time" -LocalizeDefaultFolderName

Get-exomailbox -identity lindy3archive@promasian.nl | Set-MailboxRegionalConfiguration -Language 1043 -TimeZone "W. Europe Standard Time" -LocalizeDefaultFolderName