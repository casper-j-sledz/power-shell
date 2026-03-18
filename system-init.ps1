
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
###################################    SYSTEM INIT    ###################################

#### IMPORT POWERSHELL FUNCTIONS 
Import-PowerShellProfile # May require powershell restart

#### WINDOWS CONFIG  
Add-IfNotExist -ItemPath "$env:UserProfile\source\repos" -Content "directory"
Add-Shortcut -ShortcutPath "$env:AppData\Microsoft\Windows\Start Menu\Programs\Recycle Bin.lnk" -TargetPath "shell:RecycleBinFolder"
Disable-WindowsNotificationSounds
Disable-QuickAccessRecentAndFrequentFiles
Enable-ClipboardHistory
Import-EdgeBookmarks
Optimize-Taskbar -RestartWindowsExplorer $true -RemoveTaskbarFavorites $true
Set-PolishProgrammersKeyboard
Set-PreferredWindowsFormatting
Set-TimeUtc1-00
Set-WindowsThemeDark
Show-FileExtensions

#### MANUAL CONFIG
# Add-StartupShortcuts -Company "cjs"
# Add-PinPathsToMenuStart
# Uninstall-WindowsJunkApplications

#### SOFTWARE
# Set-GitConfig "eg.mail@gmail.com"

# Import-VsCodeSettings # Export-VsCodeSettings
# Open-ProgrammingSoftwareDownloadPages

# Install-NodeJs
# Install-Angular -AngularVersion 16.2.11

# Add-EnvironmentVariable -NewEnvironmentPath "$env:ProgramFiles\Notepad++"
# Add-EnvironmentVariable -NewEnvironmentPath "$env:UserProfile\source\latexmk"

#### FUNCTIONAL
# Get-AlignedText -FilePath "$($env:UserProfile)\Downloads\RunCommands.txt" -CharSeparator '-'

#### WITH DIFFICULTIES
# Set-ClassicContextMenu     # (TO FIX)
# Install-PowerShell         # (Separate PS instance, not Windows PowerShell)
# Add-ConsoleHistoryShortcut # (DEPRECATED) 
# Set-ClassicMenuStart       # (NOT WORKING)
