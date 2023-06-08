##################################
#Update door Riaan, Script weer werkend gemaakt + MFA en Groepen gecorigeerd! Gaarne overleggen voordat er aanpassingen worden doorgevoerd :D Thanks!
##################################

Install-Module AzureAD -Force
###################################
#Informatie verzamelen
###################################

#Select-Objecteer veld "F (voornaam) tot en met O (email handtekening) en plak die vanuit Excel als antwoord op de vraag"
$ImportInfo = Read-Host "Regels 'Voornaam' tot 'E-Mail handtekening' uit inschrijfformulier"

$password = Read-Host "Wachtwoord van de gebruiker"
$UserCredential = Get-Credential -Message "Inlog gegevens voor  M365 tenant"



###################################
#Informatie verwerken
###################################
#Import regel opslitsen in Array waarbij het volgende waar is: 0:Voornaam 1:Achternaam 2:Volledig Email 3:Bedrijf 4:Type gebruiker 5:Plaatsnaam 6:Email groep 7:Rollen 8:Computer type 9:Handtekening
$ImportInfo_array = $ImportInfo.Split("	")

##Email groepen##
#Email groep regel opslitsen in verschillende groepen met ; als splitsings waarde
$EMailgroep_array = $ImportInfo_array[6].Split(";")
#Email groepen verwerken naar verwerkbare waardes voor Powershell
[System.Collections.ArrayList]$EMailgroep_array_fixedsize = $EMailgroep_array
#Alle lege regels verwijderen uit array
$EMailgroep_array_fixedsize.Remove("")

##Rollen##
#Rollen regel opslitsen in verschillende rollen met ; als splitsings waarde
$Rollen_array = $ImportInfo_array[7].Split(";")
#Rollen verwerken naar verwerkbare waardes voor Powershell
[System.Collections.ArrayList]$Rollen_array_fixedsize = $Rollen_array
#Alle lege regels verwijderen uit array
$Rollen_array_fixedsize.Remove("")

##Email adres##
#Email adres splitsen bij @ teken voor latere check of het een @woningkeurgroep email adres is
$emailadres_array = $ImportInfo_array[2].Split("@")

#Groepen worden weergegeven
Write-Output "Groepen:"
$EMailgroep_array_fixedsize

#Rollen worden weergegeven
Write-Output "Rollen:"
$Rollen_array_fixedsize



###################################
#Verbinden met alle services
###################################
Connect-MsolService -credential $UserCredential
Connect-ExchangeOnline -credential $UserCredential
Connect-AzureAD -credential $UserCredential




###################################
#MSOL instellingen
###################################
#Weergavenaam genereren
$displayname = $ImportInfo_array[0]+" "+$ImportInfo_array[1]+" "+$ImportInfo_array[3]
#UPN genereren
$upn = $ImportInfo_array[2]

#Gebruiker aanmaken
Write-Output "Gebruiker aanmaken"
New-MsolUser -UserPrincipalName $upn `
                 -FirstName $ImportInfo_array[0] `
                 -LastName $ImportInfo_array[1] `
                 -DisplayName $displayname `
                 -BlockCredential $False `
                 -ForceChangePassword $False `
                 -LicenseAssignment reseller-account:SPB `
                 -Password $password `
                 -PasswordNeverExpires $True `
                 -Office $ImportInfo_array[4] `
                 -City $ImportInfo_array[5] `
                 -UsageLocation "NL"
#MFA aanzetten
Write-Output "MFA aanzetten"

$st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$st.RelyingParty = "*"
$st.State = "Enabled"
$sta = @($st)
Set-MsolUser -UserPrincipalName $upn -StrongAuthenticationRequirements $sta



###################################
#Exchange instellingen
###################################
#Wachten tot mailbox is aangemaakt
$mailbox_exists = 0
while ($mailbox_exists -ne 1){
    if ((Get-EXOMailbox -Identity $upn) -eq $null){
        Start-Sleep -Seconds 5
        Write-Output "Mailbox wordt nog aangemaakt"
    }else{
        $mailbox_exists = 1
    }
}

Write-Output "Handtekening instellen"
Set-Mailbox -identity $upn -CustomAttribute1 $ImportInfo_array[9]
Write-Output "Regio en taal van mailbox instellen"
Set-MailboxRegionalConfiguration -Identity $upn -Language nl-NL -LocalizeDefaultFolderName:$true -TimeZone "W. Europe Standard Time"

#Wanneer het email adres eindigt op woningkeurgroep.nl ook direct een woningkeur email adres aanmaken
if ($emailadres_array[1] = "woningkeurgroep.nl"){
Write-Output "Woningkeur email adres aanmaken."
Set-Mailbox -identity $upn -EmailAddresses @{add=$emailadres_array[0]+"@woningkeur.nl"}
}



###################################
#AzureAD instellingen
###################################
#Groepen toeveogen
Write-Output "Groepen toevoegen"
foreach ($group in $EMailgroep_array_fixedsize){
Write-Output $group" toevoegen"
Add-DistributionGroupMember -Identity $group -Member $upn
}

#Rollen toevoegen
Write-Output "Rollen toevoegen"
$refobjectid = Get-AzureADUser -Filter "userPrincipalName eq '$upn'" | Select-Object -ExpandProperty ObjectId
foreach ($rol in $Rollen_array_fixedsize){
Write-Output $rol + " toevoegen"
$rol = "Group Role " + $rol
#Omdat Group Role Franchisenemer Woningkeur niet te vinden is op basis van naam wordt deze er speciaal uit gefilterd
if ($rol = "Group Role Franchisenemer Woningkeur"){
    $rolid = get-azureadgroup -ObjectId "cae04cef-3ef8-48c9-bad0-b0328622a5f1" | Select-Object -ExpandProperty ObjectId
}else{
    $rolid = get-azureadgroup | Where-Object {$_.DisplayName -eq $rol} | Select-Object-Object -ExpandProperty ObjectId
}
add-azureadgroupmember -objectid $rolid -refobjectid $refobjectid 
}


Write-Output "Group_Intune toevoegen"
Add-AzureADGroupMember -ObjectId "8741f935-c132-434c-a263-7295dc79fa52" -RefObjectId $refobjectid
Write-Output "Group_MDM toevoegen"
Add-AzureADGroupMember -ObjectId "e5d3196d-647a-4b84-a82e-d146a1c4c5c8" -RefObjectId $refobjectid

Write-Output "De user is klaar! Open nu de Office365 Portal en verwijder de groep Franchisenemer Woningkeur als het geen Franchisenemer is. En verstuur een e-mail naar Marijke met de gegevens!"
