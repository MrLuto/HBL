#   https://learn.microsoft.com/en-us/sharepoint/change-your-sharepoint-domain-name

Connect-SPOService -Url https://kpn1385666-admin.sharepoint.com -Credential admin@kpn1385666.onmicrosoft.com

Start-SPOTenantRename -DomainName "greengiving" -ScheduledDateTime 2023-04-20T17:25:00

Get-SPOTenantRenameStatus
disConnect-SPOService