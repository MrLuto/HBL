$csv = "C:\temp\users_6_17_2022 6_51_52 AM.csv"

#check of je waardes goed staan
Import-Csv 'C:\temp\users_6_17_2022 6_51_52 AM.csv'

#check in Exchange of je de juiste users naar voren ziet komen
Import-CSV $csv | foreach {Get-Mailbox -Identity $_.Email} | ft Name, RecipientTypeDetails

#Filter op user mailbox alleen
Import-CSV $csv | foreach {Get-Mailbox -Identity $_.Email | Where-Object {$_.RecipientTypeDetails -eq "UserMailbox"}} | ft Name, RecipientTypeDetails

#convert alles naar Shared
Import-CSV $csv | foreach {Get-Mailbox -Identity $_.Email | Where-Object {$_.RecipientTypeDetails -eq "UserMailbox"} | Set-Mailbox -Type Shared}

#verifieer nu je actie als het goed is  staat nu overal SharedMailbox
Import-CSV $csv | foreach {Get-Mailbox -Identity $_.Email} | ft Name, RecipientTypeDetails
