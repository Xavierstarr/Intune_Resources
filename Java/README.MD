# Java Exception configuration via Script
Script used in Intune across machines that have already got Java installed, this script is primarily used to configure security settings.

* Update the ServerPath to where your master files are stored

# Copy the files below and edit as needed:
* `exception.sites` a list of all URLS you need exceptions set for.
* `deployment.properties`
* `deployment.config`

Update the file path in the script to match where your config files are stored.

Edit the sites in your exception.sites list in any word editor, Make sure to secure the serverpath so only named users can update the exception lists but all users have read access.
