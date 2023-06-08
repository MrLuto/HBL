#omslachtige rot manier omdat ze FileHybrid hebben gesloopt in een update :)!!!!!


Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
cd C:\Users\booneadmin\Downloads\AzFilesHybrid
Install-Module -Name AzFilesHybrid -Force
Import-Module -Name AzFilesHybrid
Install-PackageProvider -Name NuGet -Force
Connect-AzAccount
Select-AzSubscription -SubscriptionName "Rout IT"
join-AzStorageaccountForAuth `
    -ResourceGroupName "AVD" `
    -Name "lesgenereuxdata" `
    -DomainAccountType "ComputerAccount" `
    -OrganizationalUnitDistinguishedName "OU=StorageAccount,OU=Les-Genereux,DC=lesgenereux,DC=nl"


$ResourceGroupName = "AVD"
$StorageAccountName = "lesgenereux"

New-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -KeyName kerb1
Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -ListKerbKey | where-object{$_.Keyname -contains "kerb1"}



# Set the feature flag on the target storage account and provide the required AD domain information
Set-AzStorageAccount `
        -ResourceGroupName "AVD" `
        -Name "lesgenereux" `
        -EnableActiveDirectoryDomainServicesForFile $true `
        -ActiveDirectoryDomainName "lesgenereux.nl" `
        -ActiveDirectoryNetBiosDomainName "LESGENEREUX" `
        -ActiveDirectoryForestName "lesgenereux.nl" `
        -ActiveDirectoryDomainGuid "3023ab92-36eb-46d0-93b6-c7aebd481e3f" `
        -ActiveDirectoryDomainsid "S-1-5-21-3702636453-838570596-1869393901" `
        -ActiveDirectoryAzureStorageSid "S-1-5-21-3702636453-838570596-1869393901" `
        -ActiveDirectorySamAccountName "booneadmin" `
        -ActiveDirectoryAccountType "Computer"

Debug-AzStorageAccountAuth -StorageAccountName $StorageAccountName -ResourceGroupName $ResourceGroupName -Verbose
