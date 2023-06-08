Unregister-ScheduledTask -TaskName "test_Installatie Snelstart"
$date = Get-Date -hour 3 -Minute 30
$date = $date.AddDays(1)
$action = New-ScheduledTaskAction -Execute "\\dc00252\d$\Administrator\Scripts\silent-setup.bat"
$trigger = New-ScheduledTaskTrigger -Once -At $date
Register-ScheduledTask -Action $action -TaskPath "\systeembeheer" -Trigger $trigger -user "desktop002\backupservice" -Password 'USm9i@":-7qFpL*N*kAPre9J&QJh+!zU' -TaskName "test_Installatie Snelstart" -Description "Update snelstart naar nieuwste versie" -RunLevel Highest