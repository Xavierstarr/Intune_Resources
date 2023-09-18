# Mapping Virtual Papercut printer queues with multiple sites
This script is used to first add drivers to the device, then map multiple virtual queues.

* This script was written to install the printer driver on machines, we have hardening policies that allow the install of this driver via GUID.
* Driver files are found in a server share accessable with readonly access on the domain, accessable by both sites
* Two virtual papercut queues are mapped via our print server
* The default printer is mapped based on the users LOGON Server
