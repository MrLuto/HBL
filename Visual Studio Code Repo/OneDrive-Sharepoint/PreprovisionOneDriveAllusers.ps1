####LET OP DAT JE EERST DE SHAREPOINT ONLINE MANAGMENET TOOL INSTALLEERD EN HIERIN ONDERSTAANDE SCRIPT AFTRAPPEN
####Hij doet het met een limiet van de eerste 199 users uitvoeren en niks meer doen
####DIKKE KUS RIAAN

Connect-MsolService
Connect-SPOService -Url https://supperfoodcloud-admin.sharepoint.com

$list = @()
#Counters
$i = 0


#gelicentieerde gebruikers ophalen
$users = Get-MsolUser -All | Where-Object { $_.islicensed -eq $true }
#totaal aantal gelicencieerde gebruikers
$count = $users.count

foreach ($u in $users) {
    $i++
    Write-Host "$i/$count"

    $upn = $u.userprincipalname
    $list += $upn

    if ($i -eq 199) {
        #limiet bereikt
        Request-SPOPersonalSite -UserEmails $list -NoWait
        Start-Sleep -Milliseconds 655
        $list = @()
        $i = 0
    }
}

if ($i -gt 0) {
    Request-SPOPersonalSite -UserEmails $list -NoWait
}