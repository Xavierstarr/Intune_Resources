# This script will run as part of a remidiation script, that checks if one or both printers are missing from a device, if it is missing this script will run.

# This script will first obtain the LOGONSERVER for the user to verify if their LOGON DC starts with LOCATION 1 or LOCATION 2 this is how the Default Printer is chosen for the user.
# The Default printer is only set once at the time of script being run, so if this ran for a Batchelor user at the time they were in Alice springs, Alice printer will remain their default until they change it.

# Script will first install the Toshiba Universal printer 2 Driver from accessable sharepath with the driver files
# Then it will map each printer via SMB only mapping the two virtual queues

# Variables needed for Script
$ADSERVER = $env:LOGONSERVER
$VIRTPrinterName1 = "VIRTUAL QUEUE NAME 1"
$VIRTShareName1 = "VIRT_PRINTER_1"
$VIRTPrinterPath1 = "\\SERVERNAME\$VIRTShareName1"

$VIRTPrinterName2 = "VIRTUAL QUEUE NAME 2"
$VIRTShareName2 = "VIRT_PRINTER_2"
$VIRTPrinterName2= "\\SERVERNAME\$VIRTShareName2"

$VIRTCheck1 = Get-Printer | Where-Object {$_.Name -like "*$VIRTPrinterName1*"}
$VIRTCheck2 = Get-Printer | Where-Object {$_.Name -like "*$VIRTPrinterName2*"}

# Attempt to install both Printers for staff that travel between sites
Try{
    if ($ADSERVER -like "*$ADSERVER1*" -or $ADSERVER -like "*$ADSERVER2*") {
    
            # If Virtual Printer Queue 1 not found on machine, Map it.
            if (!$VIRTCheck1) {
                C:\Windows\System32\pnputil.exe /add-driver '\\SERVERPATH_TO_DRIVERS\Print Drivers\Toshiba Universal Print 2_64bit_V7.222.5412.81\eSf6u.inf' /install
                rundll32 printui.dll,PrintUIEntry /in /n$BatPrinterPath
                Write-Host "Printer '$VIRTPrinterName1' has been added"
            } else {
                Write-Host "Printer '$VIRTPrinterName1' already exists."
            }

            # If Virtual Printer Queue 2 not found on machine, Map it.
            if (!$VIRTCheck2) {
                C:\Windows\System32\pnputil.exe /add-driver '\\SERVERPATH_TO_DRIVERS\Print Drivers\Toshiba Universal Print 2_64bit_V7.222.5412.81\eSf6u.inf' /install
                rundll32 printui.dll,PrintUIEntry /in /n$BatPrinterPath
                Write-Host "Printer '$VIRTPrinterName2' has been added"
            } else {
                Write-Host "Printer '$VIRTPrinterName2' already exists."
            }
			
        } else {
            Write-Host "Unknown domain controller or Cloud Device prefix: $($ADSERVER.split('.')[0])"
            exit 0
            break
        }

    # Set Default printer based on devices "Local Server"
    Try {
            if ($ADSERVER -like "*$ADSERVER1*") {
                $printer = Get-CimInstance -Class Win32_Printer -Filter "ShareName='$VIRTShareName1'"
                Invoke-CimMethod -InputObject $printer -MethodName SetDefaultPrinter
            } elseif ($ADSERVER -like "$ADSERVER2*") {
                $printer = Get-CimInstance -Class Win32_Printer -Filter "ShareName='$VIRTShareName2'"
                Invoke-CimMethod -InputObject $printer -MethodName SetDefaultPrinter
            }
    } Catch {
    Write-Host "Failed to set default printer"
    exit 0
    }
} Catch {
Write-Host "Script failed - $($_.Exception.Message)"
exit 1
}