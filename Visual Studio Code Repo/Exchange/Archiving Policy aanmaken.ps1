Connect-ExchangeOnline 
$user = "harm@speelmaatje.nl"

#Ophalen Policy van gebruiker + Archive status  (None= geen archief postvak)
Get-Mailbox $user | Select RetentionPolicy,ArchiveStatus

#Koppelen policy aan gebruiker
Set-Mailbox $user -RetentionPolicy "Archive 1 year"
Set-Mailbox $user -RetentionPolicy "Archive 3 years"

#Inschakelen archief mailbox (Werkt alleen door rechtstreeks met tenant te connecten.)
Enable-Mailbox -Identity $user -Archive | Out-Null

#Ophalen huidige mailbox groote en Archief postvak grootte.
Get-MailboxStatistics $user  | Select-Object DisplayName, TotalItemSize, ItemCount
Get-MailboxStatistics $user -Archive | Select-Object  DisplayName, TotalItemSize, ItemCount

#Ophalen huidige mailbox quota 49.5 GB = exchange plan 1 en 99 GB = exchange plan 2
get-mailbox -Identity $user | Select-Object ProhibitSendQuota

####################################################################################################
#let op moet miniemaal 30 procent vrij zijn om archiveren te starten!
#is dat er niet moet er eerst een Plan2 licentie met 100GB mailbox op de user!
####################################################################################################
#Start archiveren
Start-ManagedFolderAssistant -Identity $user | Out-Null

#Alternatieve aftrap archiveren indien error wordt aangegeven
get-mailboxLocation –user $user | fl mailboxGuid,mailboxLocationType #guids ophalen
Start-ManagedFolderAssistant 3ed3b590-32a2-4f32-8bf2-5582ce241b5d  #main guid
Get-MailboxStatistics 86b5791a-172b-48b4-bb31-fc6253a7359b | Select-Object ItemCount, TotalItemSize #archive guid

#Enable auto-expanding archiving for specific users
Enable-Mailbox $user -AutoExpandingArchive | Out-Null

#verify that auto-expanding archiving is enabled
Get-Mailbox $user | FL AutoExpandingArchiveEnabled

###################################################################################################
#
#                                OPDRACHTEN TENANT BREED
#
###################################################################################################

#ophalen volume van ALLE mailboxen + retentieoverzicht en of er een licentie (SKU) op geburiker actief is en of gebruiker enabled is. 
#Deze twee overzichten dien je dan over elkaar heen te leggen in excel voor een totaal beeld. 
Get-Mailbox -Resultsize unlimited | Get-MailboxStatistics | Select-Object DisplayName,ItemCount,TotalItemSize | Export-csv -Path C:\temp\volumemailboxen1.csv
Get-Mailbox -Resultsize unlimited | select-object DisplayName,AccountDisabled,SKUAssigned,RetentionPolicy,ArchiveStatus | Export-csv -Path C:\temp\volumemailboxenLicentie.csv

#ALLE mailbox instellen op 1 jaar archive
Get-Mailbox -Resultsize unlimited | Set-Mailbox -RetentionPolicy "Archive 1 year"
#ALLE mailbox archief aanzetten + expanding aanzetten - VOORZICHTIG AAN HOOR !!
Get-Mailbox -Resultsize unlimited | Enable-Mailbox -AutoExpandingArchive -Archive 
#ALLE mailbox archievering aanzetten
Get-Mailbox -Resultsize unlimited | Start-ManagedFolderAssistant

#Aanmaken policy en policy tag 1 jaar en 3 jaar  (Werkt alleen door rechtstreeks met tenant te connecten.)
New-RetentionPolicyTag -Name "Archive 1 year" -Type All -AgeLimitForRetention 365 -RetentionAction MoveToArchive
New-RetentionPolicyTag -Name "Archive 3 years" -Type All -AgeLimitForRetention 1100 -RetentionAction MoveToArchive
New-RetentionPolicy "Archive 1 year"  -RetentionPolicyTagLinks "Archive 1 year"
New-RetentionPolicy "Archive 3 years"  -RetentionPolicyTagLinks "Archive 3 years"

#opvragen huidige policy en tags
Get-RetentionPolicyTag | Select-Object Name,AgeLimitForRetention
Get-RetentionPolicy  | Select-Object Name,RetentionPolicyTagLinks

Get-RetentionPolicyTag "Move to archive after 185 days"
remove-RetentionPolicyTag "Archive 3 years"
Remove-RetentionPolicy "Archive 3 years"


Disconnect-ExchangeOnline -confirm:$false