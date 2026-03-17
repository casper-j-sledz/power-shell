
function Import-PowerShellProfile {
  # Open PowerShell Profile directory: `explorer.exe (Split-Path $profile)`
  $powerShellProfile = Get-ChildItem -Path (Get-Location) -Filter "power-shell_profile.ps1" -Recurse | Select-Object -First 1
  $pathsToPowerShellProfileDirectory = "$env:UserProfile\Documents\WindowsPowerShell"
  $pathsToPowerShellProfiles = @(
    "$pathsToPowerShellProfileDirectory\Microsoft.PowerShellISE_profile.ps1"
    "$pathsToPowerShellProfileDirectory\Microsoft.PowerShell_profile.ps1"
    "$pathsToPowerShellProfileDirectory\Microsoft.VSCode_profile.ps1"
  )

  # Create directory if not exists
  if (-not (Test-Path $pathsToPowerShellProfileDirectory)) {
      New-Item -ItemType Directory -Path $pathsToPowerShellProfileDirectory -Force
  }

  $pathsToPowerShellProfiles | ForEach-Object {
    Copy-Item  -Path $powerShellProfile.FullName -Destination $_ -Force
  }
}
###################################    System Init    ###################################

Import-PowerShellProfile # May require powershell restart
#(DEPRECATED) Add-ConsoleHistoryShortcut
 Add-IfNotExist -ItemPath "$($env:UserProfile)\source\repos1" -Content "directory"
# Add-Shortcut -ShortcutPath "$env:AppData\Microsoft\Windows\Start Menu\Programs\Recycle Bin.lnk" -TargetPath "shell:RecycleBinFolder"
# Optimize-Taskbar -RestartWindowsExplorer $true -RemoveTaskbarFavorites $true
# Add-StartupShortcuts
# Install-PowerShell
# Install-NodeJs
# Install-Angular -AngularVersion 16.2.11
# Open-ProgrammingSoftwareDownloadPages
# Add-PinPathsToMenuStart
# Set-ClassicMenuStart
# Set-ClassicContextMenu
# Set-GitConfig "eg.mail@gmail.com"
# Set-PreferredWindowsFormatting
# Set-WindowsThemeDark
# Show-FileExtensions
# Uninstall-WindowsJunkApplications
# Update-PowerShell
# Import-VsCodeSettings # Export-VsCodeSettings
# Disable-WindowsNotificationSounds
# Enable-ClipboardHistory

# Add-NewEnvironmentVariable -NewEnvironmentPath "C:\Tools"
# Get-AlignedText -FilePath "$($env:UserProfile)\Downloads\RunCommands.txt" -CharSeparator '-'
