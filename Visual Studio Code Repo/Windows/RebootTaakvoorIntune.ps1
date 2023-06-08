$taskName = "Shutdown - OWP"
$description = "Dagelijks shutdown 17:00"
$taskAction = New-ScheduledTaskAction `
    -Execute 'powershell.exe' `
    -Argument 'Stop-Computer -Force'
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 5PM
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $taskAction `
    -Trigger $taskTrigger `
    -Description $description
