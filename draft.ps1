# Set terminal buffer size / display length
# → File → Preferences → Settings
# → Terminal › Integrated: Scrollback
#   Controls the maximum amount of lines the terminal keeps in its buffer.
# → set → 8192

##############################################     Development    ##############################################

# Extracting used EntityFramework version and installing it globally
$efVersionMatch     = $dalCoreProjectFile | Select-String -Pattern 'Include="Microsoft.EntityFrameworkCore.Tools" Version="(.*)"'
$efVersion          = $efVersionMatch.Matches.Groups[1].Value
Write-Output "Installing .NET EntityFramework v$($efVersion) globally"
DotNet tool install --global dotnet-ef --version $efVersion

# Getting ComputerName and SqlServerName
$computerName  = Get-Content env:computername
$databaseInfo  = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server'
$instanceIndex = 0 #NOTE that you might have to change this value if you have multiple DB instances
$serverName    = $databaseInfo.InstalledInstances[$instanceIndex]
Write-Output "`nYour server name:"
Write-Output "    $($computerName)\$($serverName)"

function Replace-Text ([string]$filePath, [string]$textToReplace, [string]$textReplacement) {
    Write-Output "`nReplacing in: $($filePath)"
    Write-Output "    $($textToReplace) -> $($textReplacement)"
    $textFile = Get-Content $filePath
    $textFile = $textFile.replace($textToReplace, $textReplacement)
    Set-Content -Path $filePath -Value $textFile
}

# Add-JFrogNpmcr -JFrogApiUrl "https://example.jfrog.io/artifactory/api/" -JFrogUser "exampleUser" -JFrogApiKey "exampleApiKey" -email "example@mail.com"
function Add-JFrogNpmcr([string]$JFrogApiUrl, [string]$JFrogUser, [string]$JFrogApiKey, [string]$email) {
   $JFrogApi = $JFrogApiUrl.TrimStart('http:').TrimStart('https:')
   $npmrc = "registry=$JFrogApiUrl`n" +
            "$($JFrogApi):_auth=$([Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("$($JFrogUser):$($JFrogApiKey)")))`n" + 
            "init-author-email=$($email)"
   Add-IfNotExist -ItemPath "$env:UserProfile\___.npmrc" -Content $npmrc
}
 
# Add-UserPath -NewPath "$env:SystemDrive/Programs/NSwag"
function Add-UserPath([string]$NewPath) {
  $currentPaths = [Environment]::GetEnvironmentVariable("Path", "User")
  if ($currentPaths -notlike "*$NewPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPaths;$NewPath", "User")
    Write-Host "Added $NewPath to user PATH"
  } else {
    Write-Host "$NewPath is already in user PATH"
  }
}

# Install Nswag for .NET Core 
#   dotnet tool install -g NSwag.ConsoleCore
# Install Nswag for .NET Framework 
#   Install-ToCmd -Url "https://github.com/RicoSuter/NSwag/releases/download/v14.6.3/NSwag.zip" -ZipPath = "$env:UserProfile/Downloads/NSwag.zip" -UnzipDestPath = "$env:SystemDrive/Programs/NSwag"
# nswag run ".\$relativePath\NSwagFile.nswag"
function Install-ToCmd([string]$Url, [string]$ZipPath, [string]$UnzipDestPath) {
    Start-Process $Url
    # TODO Wait for download to complete
    Expand-Archive -Path $ZipPath -DestinationPath "$UnzipDestPath"
    Add-UserPath -NewPath $UnzipDestPath
}
 

# Run PowerShell file
powershell .\LoadDataFromSql.ps1

# Equivalent of `cd .\`
Set-Location .\  

# Write-Output types
Write-Output
Write-Warning

# Printing array of SQL Server instances with indexes
$databaseInfo  = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server'
$instances = $databaseInfo.InstalledInstances
#$instances.GetType()
$instances | Get-Member
$instances | Select-Object @{N='Index'; E={$instances.IndexOf($_)}}, Chars, value, name, _$, ToString

# Get list of monospace fonts
$path = "$($env:SystemRoot)\Fonts"
Get-ChildItem $path -Recurse | Where-Object {$_.name -match "Coonsola|JetBrainsMono|Menlo|OxygenMono|RobotoMono|SFMono"} | Select-Object name

# Remove Angular node_modules folder
Remove-Item -LiteralPath node_modules -Force -Recurse

# EF DB migrations
dotnet ef database update --startup-project $startupProject --context $dbContext
dotnet ef migrations add --startup-project $startupProject --context $dbContext AddScenarioTable

# EF DB migrations (Package Manager)
PM> Add-Migration -Name UpdateSimulation -Context $dbContext
PM> Update-Database -Context $dbContext

## PowerShell API Call

# $cred = Get-Credential -credential $user
  $username = "testUser"
  $password = "testSecret1@"

# Define the API endpoint and query
  $baseUrl = "https://api.example.com"
  $endpoint = "api/Forecasts"
  $query = "?param=value"
  $url = "$baseUrl/$endpoint$query"
 
# Define the basic authentication credentials
  $credentials = "$($username):$($password)"
  $encodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))
 
# Define the headers
  $headers = @{
      "Authorization" = "Basic $encodedCredentials"
      "x-env" = "local"  # Replace with your actual environment prefix if needed
  }
 
# Make the API call
  $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
 
# Output the response
  $response

# Build .NET project
dotnet build $path --force
dotnet publish $path /p:TargetDatabaseName=$databaseName /p:TargetServerName=$serverName

# JetBrains code inspection
$outputPath = "$($env:UserProfile)\Downloads\code-inspection.txt"; 
jb inspectCode --build --format=Text -o="$($env:UserProfile)\Downloads\-code-inspection.txt"; Write-Output "$($outputPath):`n`t$(Get-Content $outputPath)"


#New-Item -Path "$($path)\InprocServer32" -Force
#Set-Item -Path $pathToAdd -Value MyValue
#Get-Item -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID" | New-ItemProperty    -Name "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
#Get-Item -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID" | Remove-ItemProperty -Name "{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"

#$path = "Registry::HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
#Get-ItemProperty -Path $path | Format-List
#dir $path | Format-List

############################ Notes ############################

# Azurite
#    Installation:
npm install -g azurite
#    Run azurite:
azurite --silent --location c:\azurite --debug c:\azurite\debug.log

# $Env:
Get-ChildItem Env:

# Pipeline chain operators (Connecting commands)
&& # (PowerShell 7+) Run next command only if the first one succeeds.
|| # (PowerShell 7+) Run next command after firs finish.
;  #                 Run next command after firs finish.

# .bat - Don't close / Keep open
cmd /k

# Check used ports
netstat -ano -p tcp | Sort-Object -Property "Local Address" | find "{port}"

# Enable Hyper-V (ADMIN)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Enable WSL (ADMIN)
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2

# Get processes (Require additional formatting!)
wmic process list | Format-Table -AutoSize

# IP scripts
$dnsList = 'address1','address2', '...'

$IPs = @()
foreach ($e in $dnsList) {
  $IPs = Resolve-DnsName $e | Select-Object -Index 0 | Select-Object 'Name', 'IPAddress'
}

foreach ($e in $dnsList) { 
  Write-Output $e':1521'
  tcpping $e':1521' 
}
# Kudu
# Go to app directory:
  Set-Location c:\artifacts

# Print app directory:
  Get-ChildItem c:\artifacts /o-s

# Search File By Partial Name:
  Get-ChildItem c:\artifacts\{{ Partial Name }}*

# Print File:
  Get-Content c:\artifacts\{{ File Name}}

# Changing Browser Storage Size:
  localStorage.maxViewItems=2000

# Long paths enabling
$path = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
$name = 'LongPathsEnabled'
$currentValue = Get-ItemPropertyValue -Path $path -Name $name
$value = 1

Set-ItemProperty -Path $path -Name $name -Value $value
$value = (Get-ItemPropertyValue -Path $path -Name $name) -eq 1
Write-Output 'LongPathsEnabled: '$value

# Change path length limit (default: 260 char)
# Win + R -> regedit
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem
# LongPathsEnabled -ChangeValue-> 1
	
HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects
HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\FileSystem -Name LongPathsEnabled

# Regedit (UserAccountControl, OneDrive, Objects 3D)
<#
HKLM
HKLM
$path  = 'HKCU:\TEST\' 
$name  = 'test2'
$value = 1
$type  = 'binary'

Set-Location          -Path $path
New-Item              -Path $path
Remove-Item           -Path $path
Remove-ItemProperty   -Path $path -Name $name
Set-ItemProperty      -Path $path -Name $name -Value $value
New-ItemProperty      -Path $path -Name $name -Value $value -PropertyType $type
Get-ItemPropertyValue -Path $path -Name $name
Test-Path $path
#>

#Turn off 'UserAccountControl'
$path  = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$name  = 'EnableLUA'
$value = 0

if( (Test-Path $path) -and ((Get-ItemPropertyValue $path -Name $name) -ne ($value)) )
    {Set-ItemProperty -Path $path -Name $name -Value $value}

#Turn off 'OneDrive'
$path  = 'HKU:\'
if(!(Test-Path $path))
    {New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS}
#check path!!!       
$path  = 'HKEY_USERS\S-1-5-21-2645927900-1654800569-189983283-1001\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}'
$name  = 'System.IsPinnedToNameSpaceTree'
$value = 0
if( (Test-Path $path) -and ((Get-ItemPropertyValue $path -Name $name) -ne ($value)) )
    {Set-ItemProperty -Path $path -Name $name -Value $value}

#Remove 'Objects 3D'
$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
if(Test-Path $path)
    {Remove-Item -Path $path}

$path = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
if(Test-Path $path)
    {Remove-Item -Path $path}

############################ Pictures ############################
# Set the folder to scan
$folderPath = "$($env:UserProfile)\Pictures\"

# Get all files recursively
$files = Get-ChildItem -Path $folderPath -Recurse -File

# Group files by name
$groupedByName = $files | Group-Object Group-Object { "$($_.Name)-$($_.Length)" } | Where-Object { $_.Count -gt 1 }

# Output duplicates
if ($groupedByName) {
    Write-Host "`n=== Duplicate File Names Found ===`n"
    foreach ($group in $groupedByName) {
        Write-Host "File Name: $($group.Name)"
        foreach ($file in $group.Group) {
            Write-Host " - $($file.FullName) | $($file.Length)"
        }
        Write-Host ""
    }
} else {
    Write-Host "No duplicate file names found."
}


############################ ??? ############################

# ???
# param (
#     $serverName = "LocalMachineName\SQLEXPRESS",
#     $databaseName = "ExampleDB",
#     $path = "./ExampleProject.csproj"
# )

# QueueStorage environment variable
QueueStorageOptions:ConnectionString

# Clear PowerShell
	Get-Variable true; Clear-Host
	
Compare-Object (Get-ChildItem [fullPath] -recurse -name) (Get-ChildItem [fullPath] -recurse -name) -IncludeEqual

############################ CMD TR ############################
fnm env --use-on-cd | Out-String | Invoke-Expression
fnm use --install-if-missing 22
npm config ls -l
wsl --install
wsl.exe --import rancher-desktop "$env:LocalAppData\rancher-desktop\distro $env:LocalAppData\Programs\Rancher Desktop\resources\resources\win32\distro-0.85.tar" --version 2
net localgroup docker-users "username" /ADD
netplwiz
net localgroup docker-users "docker" /ADD
docker-compose --version
New-NetFirewallRule -DisplayName "WSL" -Direction Inbound -InterfaceAlias "vEthernet (WSL (Hyper-V firewall))" -Action Allow
docker run -it --add-host=host.docker.internal:host-gateway alpine cat /etc/hosts
New-LocalGroup -Name 'docker-users' -Description 'docker Users Group'
docker-compose build -t
docker context ls
docker ps
Add-LocalGroupMember -Group "docker-users" -Member (whoami)
rm -rf node_modules
rm package-lock.json
npm ci --legacy-peer-deps
npm install --legacy-peer-deps
npm install -g bower
bower init
bower install
dotnet-coverage
git branch -vv
git status
git config --get user.signingkey
git config --list | Select-String -Pattern "gpgsign|signingkey"
git config commit.gpgsign true
git config --global commit.gpgsign true
git log -1 --show-signature
git log --pretty=format:"%H %G? %s" -10
git log --branches --not --remotes --pretty=format:"%H|%G?|%GS|%s" --no-decorate
git log --branches --not --remotes --pretty=format:"%h - %an <%ae> - %s - Signature: %G?" --no-decorate
docker network create my_shared_network
Get-WindowsOptionalFeature -Online | Where-Object {$_.FeatureName -like "*NetFx*"}
dotnet restore
Remove-Item -Path "C:\ProgramData\chocolatey" -Recurse -Force
choco install nugetpackageexplorer
choco install jfrog-cli-v2-jf; jf intro
jf c show
npm install --save-dev http-proxy-middleware
start chrome --auto-open-devtools-for-tabs
docker-compose up -d standalone
dotnet nuget list source
dotnet nuget disable source "JFrog NuGet"
dotnet dev-certs https
dotnet dev-certs https --trust