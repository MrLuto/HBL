Gehaald uit http://blog.atwork.at/post/2016/09/21/Manage-Office-365-Group-creation.
Zorg dat  Microsoft Azure Active Directory Module for Windows PowerShell Preview geinstalleerd is!

===Verbinding maken===
Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

===Verbinden met Msol===
Connect-MsolService -Credential $UserCredential

===Groep maken met rechten op maken Sites en Admin toevoegen als Lid===
New-MsolGroup -DisplayName EnableSiteCreation -Description "Groep met rechten op Sites aan te maken"
$groupid = Get-MsolGroup | Where {$_.displayname -eq "EnableSiteCreation"} | ft objectid -HideTableHeaders
$adminuserID = get-user -Identity admin | ft ExchangeObjectId -HideTableHeaders
Add-MsolGroupMember -GroupObjectId $groupid -GroupMemberType User -GroupMemberObjectId $adminuserID

===Doorvoeren instellingen===
$template = Get-MsolAllSettingTemplate | where-object {$_.displayname -eq "Group.Unified"}
$setting = $template.CreateSettingsObject()
$setting["EnableGroupCreation"] = "false" 
$setting["GroupCreationAllowedGroupId"] = "$groupid"
New-MsolSettings -SettingsObject $setting
=====Bij foutmelding in vorige commando dit uitvoeren, zo niet ga door naar lijn 31.=====
Get-MsolAllSettings
=====Object ID opslaan=====
Remove-MsolSettings -settingid hier opgeslagen ID invoeren

=====Doorvoeren instellingen=====
Get-MsolAllSettings -TargetType Groups
Remove-PSSession $Session
=====Einde=====