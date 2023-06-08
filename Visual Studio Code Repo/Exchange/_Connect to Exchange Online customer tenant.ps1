$domain = "greengiving.nl"

#get logged on user e-mailaddress
$objUser = New-Object System.Security.Principal.NTAccount($Env:USERNAME)
$strSID = ($objUser.Translate([System.Security.Principal.SecurityIdentifier])).Value
$basePath = "HKLM:\SOFTWARE\Microsoft\IdentityStore\Cache\$strSID\IdentityCache\$strSID"
$upn = (Get-ItemProperty -Path $basePath -Name UserName).UserName

#connect to customer tenant
Connect-ExchangeOnline -UserPrincipalName $upn -DelegatedOrganization $domain

#Ex Online Powershell script

get-MailboxFolderPermission -Identity planning@hardemanvloerbewerking.nl:\Agenda

add-MailboxFolderPermission -Identity  planning@hardemanvloerbewerking.nl:\Agenda -user rechtenopplanning@hardemanvloerbewerking.nl -AccessRights editor

remove-MailboxFolderPermission -Identity planning@hardemanvloerbewerking.nl:\Agenda -user infoarchief@betons.nl

Get-MailboxStatistics | Select DisplayName, ItemCount, TotalItemSize | Sort-Object TotalItemSize -Descending | Export-CSV c:\temp\mailboxdata.csv
Get-MailboxDatabase | Get-MailboxStatistics | Export-CSV c:\temp\mailboxdata.csv



planningbetonsinfo@betons.nl
#close connection to ExOnline
Disconnect-ExchangeOnline -confirm:$false