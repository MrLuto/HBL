$backupfolder = "C:\_admin\GPO Backup\13-02-2023"
$csvfile = "C:\_admin\GPO Backup\ListGPO.csv"

$backupfoldernew = "C:\_admin\GPO Backup\13-02-2023"
$csvfilenew = "C:\_admin\GPO Backup\ListGPO.csv"

#################
#Hieronder niets aanpassen!
############

# Source Domain Controller
# grouppolicy Module
Import-Module grouppolicy

# Backup all GPO 
Backup-GPO -All -Path $backupfolder

# Export all GPO to CSV 
$ListGPO = Get-GPO -all | Select-Object DisplayName 
$ListGPO | Export-Csv -Path $csvfile -NoTypeInformation -Encoding UTF8
# You can edit the CSV before Create / Import

# Target Domain Controller
# Create Gpo in new Domain Controller
$BGNS = Import-Csv -Path $csvfilenew -encoding UTF8
foreach ($BGN in $BGNS)            
{            
	$GPO = $BGN.DisplayName
    New-GPO "$GPO"          
}

# Import Gpo in new Domain Controller
$BG = $backupfoldernew
$BGNS = Import-Csv -Path $csvfilenew -encoding UTF8
foreach ($BGN in $BGNS)            
{            
	$GPO = $BGN.DisplayName
    Import-GPO -BackupGpoName "$GPO" -TargetName "$GPO" -Path "$BG"
} 