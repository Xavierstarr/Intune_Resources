# This script should will create a scheduled task that will begin at the time of running, then repeat every 30 Minutes.
# At trigger the task will be checking if Idle state has been hit, so if user has been inactive for $IdleDuration in minutes

# Set Idle Duation Period
$IdleDuration = 30
$Timespan = "00:$(($IdleDuration).ToString().PadLeft(2, '0')):00"
$hostname = Hostname

#Custom Task Path & Name, where other public tasks will also be contained for better house keeping
$TaskPath = "\Public Device Management\"
$taskName = "Idle-Logoff"

$taskstatus = get-scheduledtask | Where-object {$_.taskName -eq "$taskName"}

if (!$taskstatus){
    try{
        Write-Host "Idle Logoff task does not Exists. Creating Task."
        
        #Task Variables
        $STaction  = New-ScheduledTaskAction -Execute 'c:\windows\system32\shutdown.exe' -Argument '-r -t 0'
        $STTrigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes $IdleDuration) -RepetitionDuration (New-TimeSpan -Days (365 * 20))
        $STSet     = New-ScheduledTaskSettingsSet -RunOnlyIfIdle -IdleDuration $Timespan -AllowStartIfOnBatteries -WakeToRun
        $STuser    = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
        
        #Register new task with above varibles
        Register-ScheduledTask -TaskName "$taskName" -TaskPath "$TaskPath"  -Action $STaction -Settings $STSet -Trigger $STtrigger -Principal $STuser
        Exit 0
    }

    Catch {
            Write-Host "Error in Creating scheduled task"
            Write-error $_
            Exit 1

    }
}
Else{
        Write-Host "Task exists, no action is required"
        Exit 0
}