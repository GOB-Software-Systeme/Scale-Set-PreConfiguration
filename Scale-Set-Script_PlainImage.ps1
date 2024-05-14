Write-Host 'Set LongPathsEnabled to 1'

$regKey = 'HKLM:\System\CurrentControlSet\Control\FileSystem'
if ((Get-ItemProperty $regKey -Name 'LongPathsEnabled').LongPathsEnabled -eq 0) {
    Set-ItemProperty $regKey -Name 'LongPathsEnabled' -Value 1 -Force
}

Write-Host 'Set NuGet PackageProvider'
Install-PackageProvider NuGet -Force
Import-PackageProvider NuGet -Force

. '.\InstallOrUpdateDockerEngine.ps1' -Force -envScope 'Machine'

Restart-Computer -Force
Start-Service docker