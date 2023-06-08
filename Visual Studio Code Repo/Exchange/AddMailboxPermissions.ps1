# mailboxes
$user = "service@kletec.nl"
$AccessToMailboxUser = "wkr@kletec.nl"

#split domain from upn
$username,$domain = $user.split('@')
$domain

#get logged on user e-mailaddress
$objUser = New-Object System.Security.Principal.NTAccount($Env:USERNAME)
$strSID = ($objUser.Translate([System.Security.Principal.SecurityIdentifier])).Value
$basePath = "HKLM:\SOFTWARE\Microsoft\IdentityStore\Cache\$strSID\IdentityCache\$strSID"
$upn = (Get-ItemProperty -Path $basePath -Name UserName).UserName

#connect to customer tenant
Connect-ExchangeOnline -UserPrincipalName $upn -DelegatedOrganization $domain

#add mailbox permissions

#close connection to ExOnline
Disconnect-ExchangeOnline -confirm:$false


