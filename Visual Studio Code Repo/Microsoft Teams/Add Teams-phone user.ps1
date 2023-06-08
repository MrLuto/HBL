#$PSVersionTable.PSVersion 
#Install-Module -Name PowerShellGet -Force -AllowClobber

$Identity = 'l.hoekstra@investra.nl' # <<---- Wijzig
$PhoneNumber = '+31318274163'        # <<---- Wijzig

#Init
Get-InstalledModule -Name "MicrosoftTeams"
Import-Module MicrosoftTeams
Connect-MicrosoftTeams

#Gebruiker configuratie:
Set-CsPhoneNumberAssignment -Identity $Identity -EnterpriseVoiceEnabled $true 
Set-CsPhoneNumberAssignment -PhoneNumber $PhoneNumber -PhoneNumberType DirectRouting

#Uitvoeren na 30 minuten (volgens RoutIT)
Grant-CsOnlineVoiceRoutingPolicy -Identity $Identity -PolicyName "Calling"

#Controle
Get-CsPhonenumberAssignment -AssignedPstnTargetId $Identity