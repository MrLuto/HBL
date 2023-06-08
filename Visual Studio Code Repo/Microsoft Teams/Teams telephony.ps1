#$PSVersionTable.PSVersion 
#Install-Module -Name PowerShellGet -Force -AllowClobber

Get-InstalledModule -Name "MicrosoftTeams"

#gebruike versie 2.0
#Uninstall-Module MicrosoftTeams -MaximumVersion 4.3.0
#Install-Module MicrosoftTeams -MaximumVersion 2.0.0 -force

Import-Module MicrosoftTeams
Connect-MicrosoftTeams

###############
# Basis setup
###############
New-CsOnlineVoiceRoute –Identity “Calling”
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="Calling"}
New-CsOnlineVoiceRoutingPolicy -Identity “Calling” -OnlinePstnUsages “Calling”
#vervang [klantnaam]
Set-CsOnlineVoiceRoute -Identity "Calling" -NumberPattern ".*" -OnlinePstnGatewayList [klantnaam].pri.msft.voipitworld.com,[klantnaam].sec.msft.voipitworld.com -Priority 1 -OnlinePstnUsages "Calling"

###############
# Per User
###############

#vervang user en nummer
Set-CsUser -Identity "l.hoekstra@investra.nl" -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -OnPremLineURI tel:+31318274163
#wacht 30 minuten volgens routit
Grant-CsOnlineVoiceRoutingPolicy -Identity "l.hoekstran@investra.nl" -PolicyName "Calling"


get-CsUser -Identity "l.hoekstra@investra.nl" 

#############################################
#in geval van Teams DR Call Queues 
#############################################
Set-CsOnlineApplicationInstance -Identity oproepen@investra.nl -OnpremPhoneNumber +31318274160

disConnect-MicrosoftTeams

Remove-CsCallQueue
