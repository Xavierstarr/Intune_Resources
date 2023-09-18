$TeamsInstalled = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Office\Teams" -Name "InstallSource" -ErrorAction SilentlyContinue

if ($TeamsInstalled -ne $null) {
    Write-Host "MS Teams is already via Source $($TeamsInstalled.ClientVersion)"
} else {
    Write-Host "Installing MS Teams..."
    
    $TeamsInstallerPath = "C:\Program Files (x86)\Teams Installer\Teams.exe"
    
    if (Test-Path $TeamsInstallerPath) {
        Start-Process -FilePath $TeamsInstallerPath -Wait
        Write-Host "MS Teams installation completed."
    } else {
        Write-Host "MS Teams installer not found at $TeamsInstallerPath. Installation cannot proceed."
    }
}
