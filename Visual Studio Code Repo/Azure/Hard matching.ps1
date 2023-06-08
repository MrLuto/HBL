$identity = "jan"
$domain = "tenham.nl"

$user = "$identity@$domain"
$guid = [guid]((Get-ADUser -Identity "$identity").objectGuid)
$immutableId = [System.Convert]::ToBase64String($guid.ToByteArray())

## Oude manier
Install-Module MSOnline
Connect-MsolService
Set-MsolUser -UserPrincipalName $user -ImmutableId "$immutableId"

## nieuwe manier
Install-Module AzureAD
Connect-AzureAD
Set-AzureADUser -ObjectID $user -ImmutableId $immutableID

Start-ADSyncSyncCycle -PolicyType delta