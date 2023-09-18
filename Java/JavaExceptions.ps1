<# Checks if deployment properties and config exists #>

$d = get-date

$dest = "C:\Windows\Sun\Java\Deployment"

$desttest = Test-Path -Path $dest -PathType Any

if ($desttest -eq $TRUE){Write-Output "Sun Deployment folder found"}
    else{Write-Output "Sun Deployment folder not found, creating folder"
    new-item -path "c:\Windows" -name "Sun" -ItemType "directory"
    new-item -path "c:\Windows\Sun" -name "Java" -ItemType "directory"
    new-item -path "c:\Windows\Sun\Java" -name "Deployment" -ItemType "directory"
    Write-Output "Folder Structure created"
    }

$properties = 'C:\Windows\Sun\Java\Deployment\deployment.properties'
$config = 'C:\Windows\Sun\Java\Deployment\deployment.config'
$exceptions = 'C:\Windows\Sun\Java\Deployment\exceptions.sites'

$proptest = Test-Path -Path $properties -PathType Any
$contest = Test-Path -Path $config -PathType Any
$exctest = Test-Path -Path $exceptions -PathType Any

Write-Output "Checking Properties & Config exist $d"


    if ($proptest -eq $TRUE){Write-Output "Deployment.Properties found $d"} 
        else {Write-Output "Deployment.Properties not found $d"
        copy-item "\\SERVERPATH\deployment.properties" -Destination $dest
        }


    if ($contest -eq $TRUE){Write-Output "Deployment.Config found $d"} 
        else {Write-Output "Deployment.Config not found $d"
        copy-item "\\SERVERPATH\\deployment.config" -Destination $dest
        }

Write-Output "Updating exception.sites list"
copy-item "\\SERVERPATH\\exception.sites" -Destination $dest

Write-Output "Exception List successfully updated $d"