#############################################     Function Calls    ############################################

# Add-ConsoleHistoryShortcut
# Add-IfNotExist -ItemPath "$($env:UserProfile)\source\repos" -Content "directory"
# Add-Shortcut -ShortcutPath "$env:AppData\Microsoft\Windows\Start Menu\Programs\Recycle Bin.lnk" -TargetPath "shell:RecycleBinFolder"
# Get-FunctionName
# 
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

#############################################     Functions    #############################################

# Add-ConsoleHistoryShortcut
function Add-ConsoleHistoryShortcut {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"
    $shortcutPath = $env:UserProfile + "\Downloads\ConsoleHistory.lnk"
    $targetPath   = $env:AppData     + "\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    
    if (-not (Test-Path $targetPath)) {
        New-Item -ItemType File -Path $targetPath | Out-Null
        Write-Output "Empty file created: `"$($targetPath)`""
    }

    $wshShell = New-Object -comObject WScript.Shell
    Write-Output "Creating shortcut object `"$($shortcutPath)`""
    $shortcutObj = $WshShell.CreateShortcut($shortcutPath)
    Write-Output "Setting target path to   `"$($targetPath)`""
    $shortcutObj.TargetPath = $targetPath
    $shortcutObj.Save()
    Write-Output "Shortcut saved.`n"
}

function Add-EnvironmentVariable ([string]$NewEnvironmentPath) {
    $Env:PATH = "$($Env:PATH);$($NewEnvironmentPath)"
    Write-Output $Env:PATH.Split(';')
}
# Add-EnvironmentVariable -NewEnvironmentPath "$env:UserProfile\source\latexmk"

# Add-IfNotExist -ItemPath "$($env:UserProfile)\source\repos" -Content "directory"
function Add-IfNotExist([string]$ItemPath, [string]$Content) {
  if (-not (Test-Path $ItemPath)) {
    if ($Content.ToLower() -eq "directory") {
      New-Item -Path $ItemPath -ItemType Directory  -Force | Out-Null
      Write-Output "Directory created: `"$($ItemPath)`""
    } else {
      New-Item -ItemType File -Path $ItemPath  -Force | Out-Null

      if ($Content -ne "") {
        Set-Content -Path $ItemPath -Value $Content
      }

      Write-Output "File created: `"$($ItemPath)`""
    }
  }
}

function Add-PinPathsToMenuStart {
  #Create Recycle Bin Shortcut
  $recycleBinShortcutPath = "$env:AppData\Microsoft\Windows\Start Menu\Programs\Recycle Bin.lnk"
  Add-Shortcut -ShortcutPath $recycleBinShortcutPath -TargetPath "shell:RecycleBinFolder"

  #Create Main Drive Shortcut
  $driveShortcutPath = "$env:AppData\Microsoft\Windows\Start Menu\Programs\C.lnk"
  Add-Shortcut -ShortcutPath $driveShortcutPath -TargetPath "$($env:SystemDrive)\"

  # Define paths to Quick Access pin
  $PathsToQuickAccessPin = @(
      "$($driveShortcutPath)"
      "$($recycleBinShortcutPath)"
      "$($env:UserProfile)\Downloads"
      "$($env:UserProfile)\Pictures"
      "$($env:UserProfile)"
      #"$($env:UserProfile)\source\repos"
  )
  # Create a Shell object
  $Shell = New-Object -ComObject Shell.Application

  $PathsToQuickAccessPin | ForEach-Object {
    Add-IfNotExist -ItemPath $_ -Content "directory"

    # Get the link item
    $itemLink = $shell.Namespace($(Split-Path $_)).ParseName((Split-Path $_ -Leaf))

    # Pin to Quick Access
    $itemLink.InvokeVerb("pintohome")
  }
}

# Add-Shortcut -ShortcutPath "$env:AppData\Microsoft\Windows\Start Menu\Programs\Recycle Bin.lnk" -TargetPath "shell:RecycleBinFolder"
function Add-Shortcut([string]$ShortcutPath, [string]$TargetPath) {
  $wsh = New-Object -ComObject WScript.Shell
  $shortcut = $wsh.CreateShortcut($ShortcutPath)
  $shortcut.TargetPath = $TargetPath
  $shortcut.Save()
}

function Add-StartupShortcuts {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"
    #%AppData%\Microsoft\Windows\Start Menu\Programs\Startup
    $shortcutPath = $env:AppData     + "\Microsoft\Windows\Start Menu\Programs\Startup"
     
    $msCodeInsiders  = $env:ProgramFiles        + "\Microsoft VS Code Insiders\Code - Insiders.exe"
    $msEdgePath      = ${env:ProgramFiles(x86)} + "\Microsoft\Edge\Application\msedge.exe"
    $msOutlookPath   = $env:ProgramFiles        + "\Microsoft Office\root\Office16\outlook.exe"
    $msTeamsPath     = $env:LocalAppData        + "\Microsoft\Teams\current\Teams.exe"
    #$msTeamsPath    = $env:LocalAppData        + "\Microsoft\Teams\Update.exe"
    $myBookmarksPath = $env:UserProfile         + "\Downloads\0.Priv.Bookmarks&Passwords.kdbx"
    $myHoursPath      = $env:UserProfile         + "\Downloads\0.Priv.Hours.xlsb"
    #$myNotesPath     = $env:UserProfile         + "\Downloads\0.AccDoc.Main.md"
    $notepadPath     = $env:ProgramFiles        + "\Notepad++\notepad++.exe"

    $shortcuts = @(
        #@{shortcutPath=$shortcutPath + "\VS Code Insiders.lnk";          targetPath=$msCodeInsiders; },
        @{shortcutPath=$shortcutPath + "\Edge.lnk";                       targetPath=$msEdgePath;     },
        @{shortcutPath=$shortcutPath + "\Outlook.lnk";                    targetPath=$msOutlookPath;  },
        #@{shortcutPath=$shortcutPath + "\Microsoft Teams.lnk";           targetPath=$msTeamsPath;    },
        #@{shortcutPath=$shortcutPath + "\Microsoft Teams.lnk";           targetPath=$msTeamsPath;    arguments="--processStart `"Teams.exe`"" },
        @{shortcutPath=$shortcutPath + "\0.Priv.Bookmarks&Passwords.lnk"; targetPath=$myBookmarksPath;},
        @{shortcutPath=$shortcutPath + "\0.Priv.Hours.lnk";               targetPath=$myHoursPath;     },
        @{shortcutPath=$shortcutPath + "\0.AccDoc.Main.lnk";              targetPath=$myNotesPath;    },
        @{shortcutPath=$shortcutPath + "\Notepad++.lnk";                  targetPath=$notepadPath;    }
    )

    foreach ($shortcut in $shortcuts) {
        $wshShell = New-Object -comObject WScript.Shell
        Write-Output "Creating shortcut object `"$($shortcut.shortcutPath)`""
        $shortcutObj = $WshShell.CreateShortcut($shortcut.shortcutPath)
        Write-Output "Setting target path to   `"$($shortcut.targetPath)`""
        $shortcutObj.TargetPath = $shortcut.targetPath
        #$shortcutObj.Arguments = $shortcut.arguments
        $shortcutObj.Save()
        Write-Output "Shortcut saved.`n"
    }

    Write-Output "Function executed. `n"
}

function Disable-AutoRunApps {
    Get-CimInstance -ClassName Win32_StartupCommand | 
    Select-Object Name, Command, Location, User | 
    Sort-Object Name

    $PathsToQuickAccessPin | ForEach-Object {
        Add-IfNotExist -ItemPath $_ -Content "directory"

        # Get the link item
        $itemLink = $shell.Namespace($(Split-Path $_)).ParseName((Split-Path $_ -Leaf))

        # Pin to Quick Access
        $itemLink.InvokeVerb("pintohome")
    }

    $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
    Get-ItemProperty $path | ForEach-Object {
        $_.PSObject.Properties | ForEach-Object {
            $name = $_.Name
            $data = $_.Value
            # The 1st byte in the binary data indicates status:
            # 02 = Disabled, 06 = Enabled
            $status = if ($data[0] -eq 2) {"Disabled"} elseif ($data[0] -eq 6) {"Enabled"} else {"Unknown"}
            [PSCustomObject]@{
                Name   = $name
                Status = $status
            }
        }
    }
}

function Disable-LockScreenApps {
    # Open Settings: Click the Start button and select the gear icon for Settings.
    # Go to Personalization: Click on "Personalization".
    # Select Lock screen: In the left-hand menu, choose "Lock screen".
    # Change Background:
    # Set the "Background" dropdown to "Picture".
    # If you were using "Windows spotlight," this will stop the fun facts and tips associated with it.
    # Disable lock screen status:
    # Under "Choose one app to show detailed status on the lock screen," select None from the dropdown menu.
    # Remove any apps under "Choose which apps show quick status on the lock screen" by selecting them and choosing None. 
    # Remove the detailed status app from the lock screen
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen" -Name "DetailedStatus1" -Value ""
}

function Disable-QuickAccessRecentAndFrequentFiles {
    #Disable Recent Files in Quick Access
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowRecent -Value 0

    #Disable Frequent Files in Quick Access
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name ShowFrequent -Value 0

    # Clear recent files
    Remove-Item -Path "$env:APPDATA\Microsoft\Windows\Recent\*" -Force -ErrorAction SilentlyContinue

    # Restart Windows Explorer to apply changes
    Stop-Process -Name explorer -Force
    Start-Process explorer
}

function Get-AlignedText ([string]$FilePath, [char]$CharSeparator) {
    $maxLength = 0
    $lines     = (Get-Content -Path $FilePath).Split([Environment]::NewLine)

    foreach ($line in $lines) {
        $index     = $line.IndexOf($CharSeparator)
        $maxLength = If ($index -gt $maxLength) { $index } Else { $maxLength }
    }

    foreach ($line in $lines) {
        $parts = $line.Split($CharSeparator)
        Write-Output "$($parts[0].ToLower())$(" "*($firstElement.Length))-$($parts[1..($parts.Count-1)] -join $CharSeparator)"
    }
}

function Get-IsFileDownloading([string]$path, [int]$sleepMilliseconds = 200) {
    if (-not (Test-Path $RegPath)) {
        return $false 
    }

    # Check file size twice with a short delay
    $size1 = (Get-Item $file).Length
    Start-Sleep -Milliseconds $sleepMilliseconds
    $size2 = (Get-Item $file).Length

    return $size1 -ne $size2
}

function Get-FunctionName([int]$StackNumber = 1) {
    return [string]$(Get-PSCallStack)[$StackNumber].FunctionName
}

function Import-EdgeBookmarks {
    # Path to Edge bookmarks file
    $edgeBookmarks = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Bookmarks"

    # Source bookmarks file
    $sourceBookmarksFile = "$Env:UserProfile\Downloads\Bookmarks"

    # Copy as JSON
    Copy-Item $sourceBookmarksFile $edgeBookmarks -Force
    Write-Host "Bookmarks imported from $sourceBookmarksFile to $exportPath successfully!" -ForegroundColor Green
}

function Install-Angular ([string]$AngularVersion = '') {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"

    # npm notice New major version of npm available!
    npm install -g npm@latest

    if ($AngularVersion -ne '') { 
        npm install -g "@angular/cli@$($AngularVersion)"
    } else {
        npm install -g @angular/cli
    }
    
    Write-Output "`Angular has been installed.`n"
    
}

function Install-NodeJs {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"
    
    winget install Schniz.fnm -- accept-source-agreements
    # New-Item -Path $HOME\Documents\PowerShell -ItemType directory -Force
    # New-Item $HOME\Documents\PowerShell -Name Profile.ps1 -Value "fnm env --use-on-cd | Out-String | Invoke-Expression" -ItemType "file"
    
    # fnm : error: We can't find the necessary environment variables to replace the Node version.
    # https://github.com/Schniz/fnm/issues/92
    Update-Cmdlet

    # fnm : error: We can't find the necessary environment variables to replace the Node version.
    fnm env -- use-on-cd | Out-String | Invoke-Expression

    fnm use --install-if-missing 22
    node -v
    npm -v

    Write-Output "`Node.js installed.`n"
}

function Install-PowerShell {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"
    #Get-Host # - Get Windows PowerShell version
    winget search Microsoft.PowerShell | Write-Output Y
    winget install --id Microsoft.Powershell --source winget

    Write-Output "`Powershell installed.`n"
}

# Open-ProgrammingSoftwareDownloadPages
function Open-ProgrammingSoftwareDownloadPages {
    $time = [System.DateTime]::Now.AddMinutes()
    $ProgramsToInstall = @(
        # ,@{Program="Azure Storage Explorer";        DownloadPage="https://azure.microsoft.com/en-us/products/storage/storage-explorer#Download-4"; DownloadDirect="https://go.microsoft.com/fwlink/?linkid=2216182"; }
        # ,@{Program="Docker Desktop";                DownloadPage=""; DownloadDirect=""; }
        # ,@{Program="dotPeek";                       DownloadPage="https://www.jetbrains.com/decompiler/download/#section=web-installer"; DownloadDirect="https://www.jetbrains.com/decompiler/download/download-thanks.html?platform=windowsWeb"; }
        # ,@{Program="git";                           DownloadPage="https://git-scm.com/downloads/win"; DownloadDirect="https://github.com/git-for-windows/git/releases/download/v2.51.0.windows.2/Git-2.51.0.2-64-bit.exe"; }
        # ,@{Program="KeePass";                       DownloadPage="https://keepass.info/download.html"; DownloadDirect="https://sourceforge.net/projects/keepass/files/KeePass%202.x/2.59/KeePass-2.59-Setup.exe/download"; }
        # ,@{Program="Notepad++";                     DownloadPage="https://notepad-plus-plus.org/downloads/"; DownloadDirect="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.8.3/npp.8.8.3.Installer.x64.exe"; }
        # ,@{Program="Outlook (classic)";             DownloadPage="https://apps.microsoft.com/detail/xp9mhd8pgh9n47?hl=en-US&gl=GB"; DownloadDirect=""; }
        # ,@{Program="Postman";                       DownloadPage="https://www.postman.com/downloads/"; DownloadDirect="https://dl.pstmn.io/download/latest/win64"; }
        # ,@{Program="SQL Server Management Studio";  DownloadPage=""; DownloadDirect=""; }
        # ,@{Program="Visual Studio Code";            DownloadPage="https://code.visualstudio.com/Download#"; DownloadDirect="https://code.visualstudio.com/docs/?dv=win64"; }
        # ,@{Program="Visual Studio";                 DownloadPage="https://my.visualstudio.com/?wt.mc_id=visual-studio-subscriber-assignment_eml"; DownloadDirect="https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Professional&channel=Release&version=VS2022&source=VSLandingPage&cid=2030&passive=false"; }
        # ,@{Program="";                              DownloadPage=""; DownloadDirect=""; }

        # ,@{Program="Chrome";                        DownloadPage="https://www.google.com/intl/pl/chrome/"; DownloadDirect=""; }
        # ,@{Program="Epic Launcher";                 DownloadPage="https://store.epicgames.com/pl/download"; DownloadDirect="https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi"; }
        # ,@{Program="Gimp";                          DownloadPage="https://www.gimp.org/downloads/"; DownloadDirect="https://download.gimp.org/gimp/v3.0/windows/gimp-3.0.6-setup-1.exe"; }
        # ,@{Program="GOG Galaxy";                    DownloadPage="https://www.gogalaxy.com/en/"; DownloadDirect="https://webinstallers.gog-statics.com/download/GOG_Galaxy_2.0.exe?payload=rS-EW5Haq4-aKktlGFxAGM6BKp5oKuzVQql0bM5RH8t84XBlyKFo1UrhWs3f8OXtwD9C8x9fno8iZFnwgvw7pamDrhc8hGWN6IF1tQ_fcaMUEwrTtzYB9Rok0Uh2zijK94BRExpfXnmSI-dVL1STpxU31wotAmVxhrjAn8Wo42diQ9QmhArLDBPsFYqZ2ZYq-GLvjyDXk4tDaVgGIrYgWUZ7SZzs_mbnQxIqWMjZ8MZrLCuUHS1GkvfThkjRO1Ru95JFBBlMktZgy7q_NNlct_Zlc0tDD6vSMxIsY_7rti7jfXg3YwB4LvgZOWF45vq3hyuVW5JmRJCnBqDHqfDxtQtzJ5Qunc7rAnOIp8qa1LMWbFOVSmD0N4kzaWNhaHQtr4_4Ih6j324XOsCO-zWkGcANy90_jLKFUNlxOLklczd-mqfEwvAUSEiycqlbXYgA7LLi9BHs5pTb0J-J2sZMF39Ks-aTM05hmOfLF0XMnsXvUPCB6rESm0BvuZfg9KfqVJtTrzeYtw0TParZpRAN_AXD24ewicw0Z7haig6JgrmAvkegppWaU77wlgcts8Me4hV8jjpOrnWedCSFPnInzwZdrLoG9_IljOJYGkx7Z4_TsefJ9Dz0Erjvgs8PFd1ME1kKKnNY4723sCpmOAXa8xhZqOGa2iZLXfnz1V2taIqx6ijui19aNU7uLgkE7RA3p7ht19KW7c3Jiyt6pzrZsiCT4zKw6FmI4mACqjeLqjW-qAXbiADuRvdI6kHRPbe9PR_pPuhnzozu86tsyk2rxHzWIcqgFrAgGvkO4gGCsv3COSVA"; }
        # ,@{Program="Nvidia App";                    DownloadPage="https://www.nvidia.com/en-us/software/nvidia-app/"; DownloadDirect="https://us.download.nvidia.com/nvapp/client/11.0.5.420/NVIDIA_app_v11.0.5.420.exe"; }
        # ,@{Program="Steam";                         DownloadPage="https://store.steampowered.com/about/"; DownloadDirect="https://cdn.fastly.steamstatic.com/client/installer/SteamSetup.exe"; }
        # ,@{Program="Ubisoft Connect";               DownloadPage="https://www.ubisoft.com/pl-pl/ubisoft-connect/download"; DownloadDirect="https://ubi.li/4vxt9"; }
    )
    
    foreach ($ProgramToInstall in $ProgramsToInstall) {
        if ($ProgramToInstall.DownloadDirect -ne '') { 
            Start-Process "msedge.exe" -ArgumentList $ProgramToInstall.DownloadDirect

            # # TODO
            # $files = Get-ChildItem -Path "$($env:UserProfile)\Downloads\" -File | Where-Object { $_.CreationTime -gt $time }
            # #TODO check is page exists and file has been downloaded, if not open DownloadPage
            # foreach ($file in $files) {
            #     while (Get-IsFileDownloading "$($env:UserProfile)\Downloads\$($file.Name)") { 
            #         Write-Output "$("$($env:UserProfile)\Downloads\$($file.Name)") still downloading...`n"
            #     }
                
            #     Start-Process "$($env:UserProfile)\Downloads\$($file.Name)"
            # }
        # if not Start-Process "msedge.exe" -ArgumentList $ProgramToInstall.DownloadPage
        } elseif ($ProgramToInstall.DownloadPage -ne '') {
            Start-Process "msedge.exe" -ArgumentList $ProgramToInstall.DownloadPage
        }
    }
}

function Optimize-Taskbar ([bool]$RestartWindowsExplorer = $false, [bool]$RemoveTaskbarFavorites = $false) {
    # Disable Task View button
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0

    # Disable Widgets button
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value 0

    # Hide Search button
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0

    # Set taskbar alignment to the left
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0

    #Disable taskbar programs grouping on windows snapping
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableTaskGroups" -Type DWord -Value 0

    
    # Set classic windows explorer context menu
    New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Force
    New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force
    Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value ""
    
    if ($RemoveTaskbarFavorites) {
        # Get the registry path for taskbar pinned items
        $RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband"

        # Remove all Favorites from taskbar
        If (Test-Path $RegPath) {
            Remove-ItemProperty -Path $RegPath -Name "Favorites" -ErrorAction SilentlyContinue
        }
    }

    if ($RestartWindowsExplorer) {
        # Restart Windows Explorer to apply changes
        Stop-Process -Name explorer -Force
        Start-Process explorer
    }
}

function Set-ClassicContextMenu {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"

    # -> Wind + R  -> regedit 
    #   -> HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID
    #   -> New -> Registry Key -> {86ca1aa0-34aa-4e8b-a509-50c905bae2a2}
    #   -> New -> Registry Key -> InprocServer32 (left default value blank)
    
    Write-Output "Setting up HKEY_CURRENT_USER registry."
    $path = "HKCU:\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
    New-Item -Path "$($path)\InprocServer32" -Force

    Write-Output "`nChanges saved. Please restart computer.`n"
}

# Set-GitConfig "eg.mail@gmail.com"
function Set-GitConfig ([string]$UserEmail) {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"
    
    git config --global user.email $UserEmail
    git config --global user.name "Casper J. Sledz"
    # change to use '#' char to link DevOps items
    git config --global --add core.commentchar '`'
    git config --global core.ignorecase false

    git config --system core.longpaths true   

    Write-Output "`Git config has been set.`n"
}

function Set-PolishProgrammersKeyboard {
    # Get current language list
    $langList = Get-WinUserLanguageList

    # Add Polish (Poland) language if missing
    if (-not ($langList.LanguageTag -contains "pl-PL")) {
        $langList.Add("pl-PL")
    }

    # Add Polish (Programmers) keyboard layout
    foreach ($lang in $langList) {
        if ($lang.LanguageTag -eq "pl-PL") {
            $lang.InputMethodTips.Add("0415:00000415")
        }
    }

    # Apply the updated language list
    Set-WinUserLanguageList $langList -Force

    Set-WinUILanguageOverride -Language pl-PL
    Set-WinUserLanguageList -LanguageList (New-WinUserLanguageList pl-PL) -Force
}

function Set-PreferredWindowsFormatting {
    # LCID             Name             DisplayName
    # ----             ----             -----------
    # 2057             en-GB            English (United Kingdom)
    # 1045             pl-PL            Polish (Poland)
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"
    Write-Output "Setting up culture to en-GB `"English (United Kingdom)`"."
    Set-Culture         -CultureInfo  en-GB
    Set-WinSystemLocale -SystemLocale en-GB #DOESN'T WORK, IT REQUIRES COMPUTER RESTART???

    Get-Culture | Format-List
    Get-WinSystemLocale | Format-List

    $culture = Get-Culture
    
    Write-Output "Setting up culture preferred date time formatting."
    
    Set-Properties $culture.DateTimeFormat @{
      AMDesignator                     = "AM"
      AbbreviatedDayNames              = "{Sun, Mon, Tue, Wed...}"
      AbbreviatedMonthGenitiveNames    = "{Jan, Feb, Mar, Apr...}"
      AbbreviatedMonthNames            = "{Jan, Feb, Mar, Apr...}"
      Calendar                         = "System.Globalization.GregorianCalendar"
      CalendarWeekRule                 = "FirstFourDayWeek"
      DateSeparator                    = "-"
      DayNames                         = "{Sunday, Monday, Tuesday, Wednesday...}"
      FirstDayOfWeek                   = "Monday"
      FullDateTimePattern              = "yyyy MMMM dd HH:mm:ss"
      IsReadOnly                       = "False"
      LongDatePattern                  = "yyyy MMMM dd"
      LongTimePattern                  = "HH:mm:ss"
      MonthDayPattern                  = "MMMM dd"
      MonthGenitiveNames               = "{January, February, March, April...}"
      MonthNames                       = "{January, February, March, April...}"
      NativeCalendarName               = "Gregorian Calendar"
      PMDesignator                     = "PM"
      RFC1123Pattern                   = "ddd, dd MMM yyyy HH':'mm':'ss 'GMT'"
      ShortDatePattern                 = 'yyyy-MM-dd'
      ShortTimePattern                 = "HH:mm"
      ShortestDayNames                 = "{Su, Mo, Tu, We...}"
      SortableDateTimePattern          = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
      TimeSeparator                    = ":"
      UniversalSortableDateTimePattern = "yyyy'-'MM'-'dd HH':'mm':'ss'Z'"
      YearMonthPattern                 = "MMMM yyyy"
    }

    $culture.DateTimeFormat
    Set-Culture $culture
    Write-Output "Culture changes saved.`n"

    Write-Output "Setting up HKEY_CURRENT_USER preferred formatting."
    #HKLM - HKEY_LOCAL_MACHINE
    #HKCU - HKEY_CURRENT_USER
    $hkcuFormatting = Get-ItemProperty -Path "HKCU:\Control Panel\International"
    Set-Properties $hkcuFormatting @{
      Locale           = "00000809"
      LocaleName       = "en-GB"
      NumShape         = "1"
      PSChildName      = "International"
      PSDrive          = "HKCU"
      PSParentPath     = "Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Control Panel"
      PSPath           = "Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Control Panel\International"
      PSProvider       = "Microsoft.PowerShell.Core\Registry"
      iCalendarType    = "1"
      iCountry         = "44"
      iCurrDigits      = "2"
      iCurrency        = "3"
      iDate            = "2"
      iDigits          = "2"
      iFirstDayOfWeek  = "0"
      iFirstWeekOfYear = "2"
      iLZero           = "1"
      iMeasure         = "0"
      iNegCurr         = "8"
      iNegNumber       = "1"
      iPaperSize       = "9"
      iTLZero          = "1"
      iTime            = "1"
      iTimePrefix      = "0"
      s1159            = "AM"
      s2359            = "PM"
      sCurrency        = "zł"
      sDate            = "-"
      sDecimal         = "."
      sGrouping        = "3;0"
      sLanguage        = "ENG"
      sList            = ","
      sLongDate        = "dddd, d MMMM yyyy"
      sMonDecimalSep   = "."
      sMonGrouping     = "3;0"
      sMonThousandSep  = " "
      sNativeDigits    = "0123456789"
      sNegativeSign    = "-"
      sPositiveSign    = ""
      sShortDate       = "yyyy-MM-dd"
      sShortTime       = "HH:mm"
      sThousand        = " "
      sTime            = ":"
      sTimeFormat      = "HH:mm:ss"
      sYearMonth       = "MMMM yyyy"
    }

    Set-ItemProperty -Path "HKCU:\Control Panel\International" -InputObject $hkcuFormatting
    Get-ItemProperty -Path "HKCU:\Control Panel\International" #SORTING DOESN'T WORK | Sort-Object -Property @{Expression = "DisplayName"; Descending = $false}

    Write-Output "Formatting changes saved.`n"
}

function Set-Properties([parameter(ValueFromPipeline)] $inputObject, [hashtable] $properties, [switch] $passThru) {
    process {
        Add-Member -InputObject $inputObject -NotePropertyMembers $properties -force
        if ([bool]$passThru) { $inputObject }
    }
}

function Set-TimeUtc1-00 {
    #Set TimeZone to (UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb (Central European Standard Time)
    Set-TimeZone -Name "Central European Standard Time"
}

function Set-WindowsThemeDark {
    #Windows (dark), 1 images
    Start-Process -FilePath "control.exe" -ArgumentList "/name Microsoft.Personalization /page pageThemes"
    Start-Process -FilePath "C:\Windows\Resources\Themes\dark.theme"
}

function Show-FileExtensions {
  # File Explorer -> Menu (...) -> Options 
  #  -> Open File Explorer:
  #  -> Privacy
  #    -> Show recently used files   -> UNCHECK
  #    -> Show frequently used files -> UNCHECK
  #    -> Show recommended section   -> UNCHECK
  #  -> View 
  #    -> Advanced settings:
  #      -> Hidden files and folders -> Show hidden files, folders and drivers -> CHECK
  #      -> Hide extensions for known file types -> UNCHECK
  
  #reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
  Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
  
  # Restart Windows Explorer to apply changes
  Stop-Process -Name explorer -Force
  Start-Process explorer
}

function Start-PowerShellAsAdmin {
    Start-Process powershell –verb runAs
}

function Uninstall-WindowsJunkApplications {
    Write-Output "`nInitializing function `"$(Get-FunctionName)`"`n"
    Get-AppxPackage | Sort-Object Name | Format-Table Name, PackageFullName
    $appNames = @(
        "*549981C3F5F10*", #Cortana
        "*Advertising*",
        "*BingNews*",
        "*BingWeather*",
        "*Clipchamp*",
        "*Copilot*",
        "*GetHelp*",
        "*OneConnect*",
        "*Messaging*",
        "*Microsoft3DViewer*",
        "*MicrosoftOfficeHub*",
        "*MicrosoftSolitaireCollection*",
        "*MicrosoftStickyNotes*",
        "*MixedReality.Portal*",
        "*MSPaint*",
        "*OneNote*",
        "*Paint*",
        #"*People*",                   #UNINSTALLABLE
        #"*Photos*",
        "*Print3D*",
        "*SkypeApp*"
        "*SoundRecorder*",
        "*Todos*",
        "*Wallet*",
        "*Whiteboard*",
        "*WindowsAlarms*",
        "*WindowsCamera*",
        "*WindowsCommunicationsApps*",
        "*WindowsFeedbackHub*",
        "*WindowsNotepad*",
        "*WindowsMaps*",
        #"*XboxApp*",
        #"*XboxGameCallableUI*",       #UNINSTALLABLE
        #"*XboxGameOverlay*",
        #"*XboxGamingOverlay*",
        "*XboxIdentityProvider*",
        "*XboxSpeechToTextOverlay*",
        "*YourPhone*"
        "*ZuneMusic*",
        "*ZuneVideo*"
    )

    foreach ($appName in $appNames) {
        Get-AppxPackage $appName | Remove-AppxPackage
    }
    
    Get-AppxPackage | Sort-Object Name | Format-Table Name, PackageFullName
    Write-Output "`Windows junk applications uninstalled.`n"
}

function Update-Cmdlet {
    Write-Output "`nUpdating cmdlet functions (Environment Variables)`"$(Get-FunctionName)`"`n"

    $Env:PATH.Split(';')
    $Env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "User")

    Write-Output "`Cmdlet functions updated:`n"
    $Env:PATH.Split(';')
}

function Export-VsCodeSettings {
  $PathSettingsStore = ".\vscode-settings"
  $PathCodeSettings  = "$env:AppData\Code\User"
  $FileExtensions    = "extensions.txt"
  $FileKeyBindings   = "keybindings.json"
  $FileSettings      = "settings.json"
  
  Copy-Item "$PathCodeSettings\$FileKeyBindings" "$PathSettingsStore\$FileKeyBindings" -Force
  Copy-Item "$PathCodeSettings\$FileSettings"    "$PathSettingsStore\$FileSettings"    -Force
  Code --list-extensions --show-versions | Out-File "$PathSettingsStore\$FileExtensions" -Encoding utf8
  Write-Output "`Settings have been exported.`n"
}

function Import-VsCodeSettings {
  $PathSettingsStore = ".\vscode-settings"
  $PathCodeSettings  = "$env:AppData\Code\User"
  $FileExtensions    = "extensions.txt"
  $FileKeyBindings   = "keybindings.json"
  $FileSettings      = "settings.json"
  
  Copy-Item "$PathSettingsStore\$FileKeyBindings" $PathCodeSettings -Force
  Copy-Item "$PathSettingsStore\$FileSettings"    $PathCodeSettings -Force
  Get-Content "$PathSettingsStore\$FileExtensions" | ForEach-Object { "code --install-extension $_" }
Write-Output "`Settings have been imported. Paste the commands listed into the console to install the extensions.`n"
}

function Disable-WindowsNotificationSounds {
  #Disable Windows notification sounds (without blocking toasts)
  Set-ItemProperty -Path "HKCU:\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current" -Name "(Default)" -Value ""
}

function Enable-ClipboardHistory {
  Set-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Clipboard" `
    -Name "EnableClipboardHistory" `
    -Type DWord `
    -Value 1
}

#################################################     TODO    ##################################################

function Install-PreferredLanguageAndConfigure {
    #TODO: INSTALL LANGUAGES & SET UP KEYBOARDS
    
    Write-Output "`nInitializing function `"$(Get-FunctionName)`".`n"
    Write-Output "Installing languages `"en-GB`", `"pl-PL`".`n"
    Install-Language en-GB
    Install-Language pl-PL
    
    Write-Output "Setting up `"en-GB`" as default system language."
  
    Write-Output "Setting up keyboards."
    # Settings -> Time & language -> Language & region -> English (United Kingdom)
    #  -> ... -> Language options -> Keyboards -> Add a keyboard -> Polish (Programmers)
  
    $path = "Registry::HKEY_USERS\.DEFAULT\Keyboard Layout\Preload"
    Get-ItemProperty -Path $path | Format-List
    Get-ChildItem $path | Format-Table
  
    $path = "Registry::HKEY_USERS\.DEFAULT\Keyboard Layout\Preload"
    Get-ItemProperty -Path $path | Format-List

    $path = "HKLM:\SYSTEM\ControlSet001\Control\Keyboard Layouts"
    Get-ChildItem $path | Format-Table
    # ID            Layout Text                  Layout File      Layout Display Name
    # --            -----------                  -----------      -------------------
    # 00000415      Polish (Programmers)         KBDPL1.DLL       @C:\windows\system32\input.dll,-5035
    # 00000452      United Kingdom Extended      KBDUKX.DLL       @C:\windows\system32\input.dll,-5145
    # 00000809      United Kingdom               KBDUK.DLL        @C:\windows\system32\input.dll,-5025
    
    Write-Output "Languages installed, keyboards set up.`n"
}

function Add-DotNet47-ProjectBuildReviewLibraries {
  Set-Location "$($env:UserProfile)\Downloads\dotnet-test"

  $projectName = "DotNet-DLL-Loader"
  dotnet new console -n $projectName #-f net6.0 up #.NET Framework 4.7 | ❌ Not supported

  Set-Location .\$projectName

  Set-Content -Path ".\$($projectName).csproj" -Value "<Project Sdk=`"Microsoft.NET.Sdk`">
    <PropertyGroup>
      <OutputType>Exe</OutputType>
      <TargetFramework>net47</TargetFramework>
    </PropertyGroup>
  </Project>"

  Set-Content -Path ".\Program.cs" -Value "namespace $($projectName.Replace("-", "."))
  {
      internal class Program
      {
          static void Main(string[] args) { }
      }
  }"

  dotnet add package System.Runtime.CompilerServices.Unsafe --version 6.0.0

  dotnet add package System.Memory --version 4.6.3

  dotnet restore

  dotnet build

  Set-Location .\bin\Debug\net47\

  Get-ChildItem -Filter *.dll -Recurse | ForEach-Object { [System.Reflection.Assembly]::ReflectionOnlyLoadFrom($_.FullName).GetName() }
}

function DriveOperations {
    # Remove Drive Letter
    Set-Partition -DriveLetter H -NewDriveLetter $null
    # Change Drive Letter
    Set-Partition -DriveLetter D -NewDriveLetter T
    # Rename Driver
    Set-Volume -DriveLetter C -NewFileSystemLabel "Primary"
    Set-Volume -DriveLetter D -NewFileSystemLabel "Secondary"

    #     <#
    # https://www.thomasmaurer.ch/2012/04/replace-diskpart-with-windows-powershell-basic-storage-cmdlets/

    # Get-Disk
    # Get-Partition

    # $DiskNumber = 2
    # Get-Partition -DiskNumber $DiskNumber
    # Get-Disk $DiskNumber | Clear-Disk -RemoveData
    # New-Partition -DiskNumber $DiskNumber -UseMaximumSize
    # Get-Partition -DiskNumber $DiskNumber -PartitionNumber 1 | Format-Volume -FileSystem NTFS
    # Set-Partition -DriveLetter E -NewDriveLetter T
    # Set-Partition -DriveLetter T -IsActive $true
    # Remove-Partition -DriveLetter T
    # Set-Disk $DiskNumber -isOffline $false 
    # Set-Disk $DiskNumber -isReadOnly $false
    # Initialize-Disk $DiskNumber -PartitionStyle GPT

    # $filePath ="c:\soisk\soisk.txt\"
    # Invoke-Expression "explorer '/select,$filePath'"

    # Get-Disk 1 | Clear-Disk -RemoveData
    # New-Partition -DiskNumber 1 -UseMaximumSize -IsActive -DriveLetter E | Format-Volume -FileSystem NTFS -NewFileSystemLabel USB
    # #>


    # Get-Partition -DiskNumber $DiskNumber
    # $Disk = Get-Disk 
    # $Disk[$DiskNumber].GetType()
    # $Disk[$DiskNumber].Size / 1GB
    # Get-Partition -DiskNumber 2

    # Diskpart
    # Windos + R 
    # Diskpart
    # ● list volume
    # ● select volume 3（here take volume 3 as an example）
    # ● assign letter=E
    # ● exit

    # Get-Disk

    # $diskNumber = 2
    # Get-Disk $diskNumber | Set-Disk -IsReadOnly $false
    # Get-Disk $diskNumber | Clear-Disk -RemoveData -Confirm:$false
    # New-Partition -DiskNumber $diskNumber -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem NTFS -NewFileSystemLabel "BOOTUSB" -Confirm:$false
    # $isoPath = "$($env:UserProfile)\Downloads\Installers\Microsoft Windows 10 Edu\16299.0.171109-1522.rs3_release_svc_refresh_CLIENT_CONSUMER_X64FRE_pl-pl.iso"
    # $c = Mount-DiskImage -ImagePath $isoPath
    # $c
    # $isoDrive = "G:"
    # $usbDrive = "E:"
    # robocopy $isoDrive $usbDrive /e
    # bootsect /nt60 $usbDrive
    # Dismount-DiskImage -ImagePath $isoPath
    # Dismount-DiskImage -ImagePath $usbDrive
}

##############################################     Development    ##############################################
