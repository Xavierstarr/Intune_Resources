$taskName = "Idle-Logoff"
$taskStatus = get-scheduledtask | Where-object {$_.taskName -eq "$taskName"}

if ($taskStatus){
    Write-Host "Task exists, no action is required"
    Exit 0
}
Else{
    Write-Host "Task not found, remediation is required"
    Exit 1
}