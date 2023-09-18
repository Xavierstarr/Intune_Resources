# Idle Logoff for Public and Shared Machines
This script is used to create a scheduled task on devices via a remediation detection.

This script was created to use with Shared Machines in a public space such as a Library or Learning Centres with machines setup in Intune as a (Shared PC) with a Guest session.
The Guest session via Intune policies nuke the local session and standard policies only automatically lock the login session when inactive.

After testing multiple custom apps which use custom ADMX Templates to configure their config we could not get them to autologout machines at all, believe there is some background services preventing them from being seen as inactive.

* This script will create a Scheduled Task under a custom folder called "Public Device Management"
* The task will run every 30 Minutes but only run if the machine is in a idle state
* When this task is created by default "stop on return from idle" is automatically enabled so if the user returns to the machine before the next task run the action will not occur
* When the task runs and machine is in an Idle State for 30 Minutes then it will reboot the machine, this can be changed

## Customization
To set your idle threshold in the script update the following:

Set your below idle duration in Minutes, this is how long the machine must be in an Idle state before you want to see the action occur.
`$IdleDuration = 30`

* this is also set as the task repetition interval, if you want to change the interval to be different to your idle time update the below:
`-RepetitionInterval (New-TimeSpan -Minutes $IdleDuration)`

The below is used to make sure the task just runs forever, change this if you can get another method to work, seemed to be the only way I can assure it ran forever.
`-RepetitionDuration (New-TimeSpan -Days (365 * 20))`

To change the action on Idle, below will reboot the machine, I find this useful as it also assures machine reboots to apply pending OS and App updates
`$STaction  = New-ScheduledTaskAction -Execute 'c:\windows\system32\shutdown.exe' -Argument '-r -t 0'`

### Special Notes on the behavior
It's worth noting the behaviour of the task does not mean that if the machine is idle for 30minutes it will reboot.
This task will occur every 30minutes but only run if the machine has been in an idle state for 30 minutes, so you could have examples of users going inactive for 29 minutes when the task runs. 
Then next run if they are still idle the action will trigger which would be 59 Minutes of idle time in total, so coming up with the thresholds and run cycle that suits your needs is key.
You could have the task run every 5 minutes if needed, with a 60 minute idle time for better results and test to see if the increased run time impacts your device performance at all.
