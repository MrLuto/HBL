$user = "isadmin@kgs.swiss"
$sharedmbxs = Get-Mailbox -ResultSize:Unlimited | Select Identity,Alias,DisplayName
$i = 1
$totalmbxs = $sharedmbxs.Count
foreach ($mbx in $sharedmbxs) {
Write-Progress -activity "Processing user $($mbx.DisplayName)" -status "$i out of $totalmbxs completed"
Remove-MailboxPermission -Identity $mbx.Identity -User $user -AccessRights FullAccess -InheritanceType All -Confirm:$false
$i++
}