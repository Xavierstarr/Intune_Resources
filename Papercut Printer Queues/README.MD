# Mapping Virtual Papercut printer queues with multiple sites
This script is used to first add drivers to the device, then map multiple virtual queues.

* This script was written to install the printer driver on machines, we have hardening policies that allow the install of this driver via GUID.
* Driver files are found in a server share accessable with readonly access on the domain, accessable by both sites
* Two virtual papercut queues are mapped via our print server
* The default printer is mapped based on the users LOGON Server

## To customize this script
You will need to upload drivers for your virutal printer queues to a common share, we are using the latest Toshiba Universal 2 Printer drivers
* Update the sharepath and the driver file name in the script
* Update the `\\SHARENAME` in `$VIRTPrinterName1 and 2` to match your print server
* Update the `$VIRTShareName1 and 2` with the Sharename of the printers can be found if you just navigate to \\PRINTERSERVER via Windows Explorer, or via your print server printer settings
* Update the *VIRTPrinterName1 and 2` with the display names of the printers when mapped
* Update your `$ADSERVER1 and 2` Variables with the server names for each site, if you have a naming design and multiple AD Servers you can just use the server Prefix for example if you have 1 Primary DC and a Read ONLY DC for redundancy named CONTOSODC01 and CONTOSODC02 just set that site variable to 'CONTOSODC'

If you have the ability to use Cloud Print, please consider it as it will make your life so much easier.
