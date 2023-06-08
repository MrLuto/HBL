function hoofdloop {
if ($null -eq (get-module -ListAvailable -Name MSOnline)) {Install-Module MSOnline -Scope CurrentUser}
if ($null -eq $Partnercreds){
    $script:partnercreds = Get-Credential
    Connect-MsolService -Credential $Partnercreds
}
$counter = 0
if ($null -eq $contracten) {$contracten = Get-MsolPartnerContract}
$script:partners = $contracten | foreach-object {
    $partner = $_
    $counter++ 
    $partner | select-object @{name = "Nummer"; Expression = {$counter}},Name, defaultdomainname}

echo ($script:partners) | ft
$script:klantnummer = Read-Host "Vul het nummer in van de klant waar je verbinding mee wil maken"
$script:klant = $partners | where nummer -eq $klantnummer
Write-Host "Nu kan je commando's uitvoeren met '$klant | get-msolblabla, of gebruik Exchange Online met het command ImpExch"
}

function ImpExch {
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid?DelegatedOrg=$($klant.defaultdomainname) -Credential $Partnercreds -Authentication Basic -AllowRedirection
import-pssession $ExchangeSession
}

function rmps {
get-pssession | remove-pssession
hoofdloop
}
hoofdloop