$TeamsInstalled = Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Teams" -Name "InstallSource" -ErrorAction SilentlyContinue

if ($TeamsInstalled -ne $null) {
    Write-Host "MS Teams is installed using MSI. InstallSource: $($TeamsInstalled.InstallSource)"
} else {
    Write-Host "MS Teams is not installed."
}
