#connect met exchange
$domain = "loedeman-ongediertebestrijding.nl"

#get logged on user e-mailaddress
$objUser = New-Object System.Security.Principal.NTAccount($Env:USERNAME)
$strSID = ($objUser.Translate([System.Security.Principal.SecurityIdentifier])).Value
$basePath = "HKLM:\SOFTWARE\Microsoft\IdentityStore\Cache\$strSID\IdentityCache\$strSID"
$upn = (Get-ItemProperty -Path $basePath -Name UserName).UserName

#connect to customer tenant
Connect-ExchangeOnline -UserPrincipalName $upn -DelegatedOrganization $domain

#export mail
Get-Mailbox -resultsize unlimited | Get-MailboxPermission | Select Identity, User, Deny, AccessRights, IsInherited| Export-Csv -Path "c:\temp\mailboxpermissions.csv" –NoTypeInformation

#export mail voor security groups
Install-Module -Name AzureAD -Force
Connect-AzureAD

$groups=Get-AzureADGroup -All $true
$resultsarray =@()
ForEach ($group in $groups){
    $members = Get-AzureADGroupMember -ObjectId $group.ObjectId -All $true 
    ForEach ($member in $members){
       $UserObject = new-object PSObject
       $UserObject | add-member  -membertype NoteProperty -name "Group Name" -Value $group.DisplayName
       $UserObject | add-member  -membertype NoteProperty -name "Member Name" -Value $member.DisplayName
       $UserObject | add-member  -membertype NoteProperty -name "ObjType" -Value $member.ObjectType
       $UserObject | add-member  -membertype NoteProperty -name "UserType" -Value $member.UserType
       $UserObject | add-member  -membertype NoteProperty -name "UserPrinicpalName" -Value $member.UserPrincipalName
       $resultsarray += $UserObject
    }
}
$resultsarray | Export-Csv -Encoding UTF8  -Delimiter ";" -Path "C:\temp\output1.csv" -NoTypeInformation