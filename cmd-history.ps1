# POWER SHELL user & machine info 
"User: $S(whoami), Machine: $(hostname)"
# POWER SHELL path operations 
Test-Path $path 
Split-Path $path 
Split-Path $path -Leaf 
Split-Path -Path $path -Parent 
# POWER SHELL get current editor file (.ps1) path 
$psEditor.GetEditorContext().CurrentFile.Path 
# POWER SHELL go folder up
Set-Location .. 
# POWER SHELL create VS Code link and add to folder in start menu
Set-VsCodeLink -FolderPath "$env:UserProfile\source\repos\work-repository" -LinkPath "$vsCodeMenuStartPath\Work-Repository"
# POWER SHELL force remove item 
Remove-Item "C:\Program Files\dotnet\shared\Microsoft.NETCore.App\9.0.14" -Force -Recurse 
Remove-Item "C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App\9.0.14" -Force -Recurse 
# POWER SHELL get last machine boot time 
Get-CimInstance Win32_OperatingSystem I select-object LastBootUpTime 
# POWER SHELL open file VS Code 
Code "$eny:UserProfile\source\repos\work-repository" 
Code "$env:AppData\Microsoft\lindows\PowerShell\PSReadLine\Visual Studio Code Host_history.txt" 
Code "$eny:AppData\Microsoft\lindows\PowerShell\PSReadLine\ConsoleHost_history.txt" 
Code "$env:ExampleProject\src\.github\copilot-instructions.md" 
# POWER SHELL open in vs code Rider user global settings 
Code "$env:AppData\JetBrains\Rider2025.3\resharper-host\GlobalSettingsStorage.DotSettings" 
# POWER SHELL open file with default application
explorer "$env:LocalAppData\Programs\Microsoft VS Code" 
explorer "$env:UserProfile\source\repos\work-repository\private.hours.xlsb" 
explorer "$env:UserProfile\source\repos\work-repository\CJ5_Work.kdbx" 
# POWER SHELL open file with notepad++
notepad++ "$env:UserProfile\source\repos\.master-repository\work-repository\power-shell\cmd-history.ps1" 
# POWER SHELL release port if occupied by other process 
$port = 7000 
$proc = (Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue).OwningProcess 
if ($proc) { Stop-Process -Id $proc -Force -ErrorAction SilentlyContinue }
# POWER SHELL add repository to environment variables (requires powershell restart) 
[System.Environment]::SetEnvironmentVariable("ExampleProject", "$env:UserProfile\source\repos\ExampleProject", "User") 
# POWER SHELL add scheduled task to compose containers on login 
# use command 'podman start (podman ps --all --quiet)" 
#& "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command `"podman start (podman ps --all --quiet)`"; "Exit-$LastExitCode`"" 
$action = New-ScheduledTaskAction -Execute "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" -Argument `
  "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command `"podman machine start; podman start (podman ps --all --quiet)`" `"Exit-$LastExitCode`""
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME 
$settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 15) -RestartCount 5 -RestartInterval (New-TimeSpan -Minutes 2)
Register-ScheduledTask -TaskName "ExampleProject-Podman-Start" -Action $action -Trigger $trigger -Settings $settings `
  -Description "Start ExampleProject containers on login" - Force #RunLevel Highest
# POWER SHELL get list of scheduled tasks 
Get-ScheduledTask | Select-Object TaskName, State, TaskPath | Where-Object { $_.TaskName -like "*ExampleProject*" } | Sort-Object TaskName | Format-Table -AutoSize 
# POWER SHELL get logs for scheduled task
Get-WinEvent -FilterHashtable @{ LogName = "Microsoft-Windows-TaskScheduler/Operational"; StartTime = (Get-Date).Date.AddHours(12) } | Where-Object `
  { $_.Message -like "*ExampleProject.Podman-Start*" } | Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-List 
# POWER SHELL trigger scheduled task manually
Start-ScheduledTask -TaskName "ExampleProject-Podman-Start"
# POWER SHELL remove scheduled task by name
Unregister-ScheduledTask -TaskName "ExampleProject-Podman-Start" -Confirm:$false -ErrorAction SilentlyContinue

# Windows incorrect time issue
# POWER SHELL ADMIN 1. Reset time service
net stop w32tine
net start w32time
# POWER SHELL ADMIN 2, Enforce time service resync
w32tm /resync /force
# POWER SHELL ADMIN get time service status
w32tm /query /status
# POWER SHELL ADMIN get time service peers
w32tm /query /peers

# POWER SHELL ADMIN copilot-instructions symbolic link
Set-Location "$env:ExampleProject": New-Item -ItemType SymbolicLink -Path .github\copilot-instructions.md -Target src\.github\copilot-instructions.md

# WSL install
wsl --install
# WSL (requires sudo password)
& "$env:SystemRoot\system32\ws1.exe" -e sudo apt update
& "$env:SystemRoot\system3&\ws1.exe" -e sudo apt upgrade

# BASH show current directory
& "$env:Programfiles\Git\bin\bash.exe" -c "pwd"
# BASH run scripts
& "$env:Programfiles\Git\bin\bash.exe" -c "cd ~/source/repos/solution/project && sh BashScript.sh"

# GIT config
git config --global core.editor "code --wait --reuse-window"
git config --list | Select-String "editor"
# GIT submodules management
Get-Content"$env:UserProfile\source\repos\work-repository\-gitmodules" |Format-List
git submodule foreach git pull origin main
git config set advice.submoduleMergeConflict false
git submodule update --init --recursive
git submodule set-branch --branch main notes
git submodule foreach git reset --hard "origin/main"
#GIT
git clone https://github.com/casper-j-sledz/work-repository-git
git push --set-upstream origin (git --show-current)
git push --force-with-lease
git stash -m "DROP ME: Local Dev env config"
git stash save "TEMP_S(Get-Date -Format "yyyy-NM-dd_HH:mm")"; git pull; git stash apply
git update-index "assume-unchanged exampleFile.md"
Set-GitUntrack -FileName "packages.lock.json" -RootPath (Get-Location) #-Revert
# GIT disconnect origin branch
git branch --unset-upstream
# GIT don't track file changes
git update-index --assume-unchanged vsCode.sln
# GIT create new feature branch based on develop
Set-Location "$env:ExampleProject"; git fetch; git checkout -b "task/JIRA-9999_Task-Name" "origin/develop" --no-track
# GIT rebase current branch on top of develop
Set-Location "$env:ExampleProject"; git fetch; git rebase "origin/develop"
# GIT print staged (cached) changes of current branch
Set-Location "$env:ExampleProject"; git --no-pager diff --cached
# GITLAB open my merge requests in browser
Set-Location "$env:ExampleProject"; Start-Process "$((git remote get-url origin).Replace('git', ''))/-/merge_requests/?author_username=cjSledz"

# PODMAN remove machine and init clean with clean docker-compose
podman machine rm -f; podman machine init --now; Set-Location "$env:ExampleProject\src"; docker-compose up
podman machine start
podman machine stop
# PODMAN get list of all containers (ps - process status)
podman ps --all --format "table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Status}}"
# PODMAN start all containers
podman start (podman ps --all --quiet)
# PODMAN stop all containers
podman stop (podman ps --al1 --quiet)

# DOTNET build and run API project
dotnet build "$env:ExampleProject/src/ExampleProject.Api" --configuration Release --noLogo -v q 
$projectPath = "$env:ExampleProject/src/ExampleProject.Api"
Start-Process -Fi1ePath "dotnet" -ArgumentList "run --project `"$projectPath`" --configuration Release --no-build" -NoNewWindow
# DOTNET
dotnet restore "$env:ExampleProject\src\ExampleProject.Tests\ExampleProject.Tests.csproj" --use-lock-file --force-evaluate
dotnet --list-sdks
dotnet tool list -g | Select-String -Pattern "ef"
dotnet tool list -g | Format-Table; dotnet --version 
# DOTNET run project 
#   locks console with api output 
dotnet run "$projectPath" --configuration Release --noLogo -v q --no-build 
#   run in separate process
Start-Process -FilePath "dotnet" -ArgumentList "run --project `"$projectPath`" --configuration Release --no-build" -NoNewWindow
# DOTNET runtimes issue: ProjectXYZ has to be added to perform dropping views during CI/CD migration, because current solution works only on runtime
dotnet --list-runtimes 
winget install Microsoft.DotNet.SDK.10 
winget uninstall --name ".NET Runtime 9.0.14"
winget uninstall --name ".NET Windows Desktop Runtime 9.0.14"
Remove-Item "C:\Program Files\dotnet\shared\Microsoft.NETCore-App\9.0.14" -Force -Recurse
Remove-Item "C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App\9.0.14" -Force -Recurse
Set-Location "$env:ExampleProject\src"; dotnet restore

# DOTNET EF CORE migrations 
# DOTNET EF CORE: Add Migration
Set-Location "$env:ExampleProject/Infrastructure"; dotnet ef migrations add "MigrationName" --startup-project ../ExampleProject.Api; 
# DOTNET EF CORE: update ef to particular version
dotnet tool update dotnet-ef --version 10.0.5 dotnet tool restore dotnet ef --version 
# DOTNET EF CORE: Reset database 
Set-Location "$env:ExampleProject/Infrastructure"; dotnet ef database drop --force; 
# DOTNET EF CORE: Get list of migrations 
Set-Location "$env:ExampleProject/Infrastructure"; dotnet ef migrations list --no-build --startup-project ../ExampleProject.Api; 
# DOTNET EF CORE: Update database to selected from end migration
Set-Location "$env:ExampleProject/Infrastructure";
$migrations = dotnet ef migrations list --no-build --startup-project ../ExampleProject.Api
$migration = $migrations[$migrations.Length - 1] 
dotnet ef database update $migration --startup-project ../ExampleProject.Api
# DOTNET EF CORE: Update database to latest migration 
Set-Location "$env:ExampleProject/Infrastructure"; dotnet ef database update --startup-project ../ExampleProject.Api

# FFMPEG install audio processor
winget install --id Gyan.FFmpeg --accept-package-agreements --accept-source-agreements
# FFMPEG convert given .mp4 file to WAV format 
Set-Location "$env:UserProfile\Videos\Screen Recordings"; ffmpeg -i "$($FileName).mp4" -vn -ac 1 -ar 16000 -c:a pcm_s16le "$($FileName).way"-y 
# FFMPEG cut / trim and convert given .mp4 file to WAV format
Set-Location "$env:UserProfile\Videos\Screen Recordings"; 
ffmpeg -ss 00:00:06 -i "$($FileName).mp4" -to 00:24:00 -vn -ac 1 -ar 16000 -c:a pcm_s16le "$($FileName).way" -y

###################################

# %AppDta%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
#\n& "c:[\/]Program Files[\/]Git[\/]cmd[\/]git[.]exe.*

npm install -g npm@11.12.1
npm install -g nswag
npm nswag

################################### AC MIDDLE CMD History ###################################
Get-ChildItem -Filter *.dll | Add-Member NoteProperty AssemblyVersion([Reflection.AssemblyName]::GetAssemblyName($_.FullName).Version)
Get-ChildItem -Filter *.dll | Add-Member NoteProperty FileVersion ($_.VersionInfo.FileVersion)
$tree = TREE $path
$cred = Get-Credential -credential $UserName
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Enrollments -Exclude Context,Ownership,Status,ValidNodePaths | Where-Object -Property Name -Like "*$((Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts).Name | Split-Path -Leaf)*" | Remove-Item -Force
Get-Command -Module LanguagePackManagement
Get-Content env:computername
Get-Host
Get-Process -Id (Get-NetTCPConnection -LocalPort 10000).OwningProcess
Stop-Process -Id 36876
New-LocalGroup -Name 'docker-users' -Description 'docker Users Group'
Remove-Item -LiteralPath ".git/rebase-merge" -Force -Recurse
Remove-Item -LiteralPath "node_modules" -Force -Recurse
Set-MpPreference -EnableControlledFolderAccess Enabled
Set-MpPreference -EnableNetworkProtection Enabled
Update-Database -Project RSM.Infrastructure -StartupProject RSM.Web -context AppDbContext
[System.Reflection.Assembly] | get-members
az account show
az deployment group create --name ServiceBusDeployment --resource-group local-group --template-file serviceBus-template.json --parameters sb_namespaces_name=service-bus-ns --mode Complete --verbose
az group create --name local-group --location "North Europe"
az login
az serviceBus namespace authorization-rule keys list --resource-group local-group --namespace-name service-bus-ns --name Manage --query primaryConnectionString -o tsv
az serviceBus namespace exists --name $name
az version
azurite --silent --location c:\azurite --debug c:\azurite\debug.log
dotnet ef database update
dotnet restore $sln
dotnet ef migrations add $migrationName
dotnet --info
dotnet build
dotnet build $csprojPath --force
dotnet restore
dotnet ef database update --context AppDbContext
dotnet ef migrations add --context AppDbContext AddScenarioTable
dotnet ef migrations add AddUserPrivacyPolicyAcceptanceTime
dotnet format
dotnet format --verify-no-changes -v diag
dotnet format whitespace --verify-no-changes -v diag
dotnet nuget list source
dotnet nuget locals all --clear
dotnet publish $csprojPath /p:TargetDatabaseName=$databaseName /p:TargetServerName=$serverName
dotnet run
dotnet test [..].dll
dotnet tool install --global dotnet-ef --version 8.0.3
dotnet tool install --global JetBrains.ReSharper.GlobalTools
find  -empty -printf '%y %p\n'
find ~/lists -empty -printf '%y %p\n'
fnm
fnm env
fnm env --use-on-cd | Out-String | Invoke-Expression
fnm use --install-if-missing 20
git clean -xdf --dry-run
git config --global -l
git config --global credential.azreposCredentialType oauth
git config --system -l
git config --system core.longpaths true
git diff develop..release/2025.6.0
git update-git-for-windows
jb inspectCode --build --format=Text -o="$($env:UserProfile)\Downloads\code-inspection.txt" --severity=WARNING --verbosity=WARN --profile=".\.sln.DotSettings" --no-swea .sln
Get-Content "$($env:UserProfile)\Downloads\code-inspection.txt"
mkdir  %userprofile%\.nuget\packages\nswag.msbuild\14.2.0\tools\Net80\dotnet-nswag.exe
netsh interface ipv4 show subinterfaces
netstat -ano | findstr *PID*
ng build
ng serve
ng serve --port 4300
ng serve:local
ng test
ng test --code-coverage
ng version
ng version -g
ng g s src\app\modules\main\components\application-frame\services\versions
ng test --code-coverage
npm install -g @angular/cli
node -v
npm -install
npm -v
npm .\.git\
npm audit
npm audit fix
npm audit fix --force
git push --set-upstream origin
npm cache verify
npm ci
npm clean-install
npm config delete //pkgs.dev.azure.com/RRALM/_packaging/cobalt-ui-kit/npm/registry/:_password //pkgs.dev.azure.com/RRALM/_packaging/cobalt-ui-kit/npm/registry/:username //pkgs.dev.azure.com/RRALM/_packaging/cobalt-ui-kit/npm/registry/:email email; vsts-npm-auth -config .npmrc
npm config edit
npm config list
npm fetch
npm i --save-dev @playwright/test
npm i -g nswag@14.2
npm i sharp
npm init playwright@latest
npm install
npm install --legacy-peer-deps
npm install -g @angular/cli@16.2.11
npm install -g azurite
npm install -g npm@10.9.0
npm install -g vsts-npm-auth
npm install @fortawesome/react-fontawesome
npm install @fortawesome/free-regular-svg-icons
npm install @types/node
npm install @types/react
npm install react-router-dom
npm install react-scripts@latest
npm install sass
npm install typescript
npm login
npm ls -g nswag
npm playwright test --grep redesign
npm push --force
npm run
npm run api-gen
npm run build
npm run dev
npm install --save @fortawesome/free-brands-svg-icons
npm install @fortawesome/free-solid-svg-icons
npm run lint
npm run prettier
npm run start
npm run start:devapi
npm run start:local
npm run start:testapi
npm run storybook
npm run test
npm start
npm test
npm uninstall -g angular-cli @angular/cli
npm uninstall -g nswag
npx create-next-app@latest
npx create-react-app react-blossom-cook-book
npx playwright test --grep redesign
nswag run
nswag run /runtime:net80
powershell.exe -file sw.ps1 -publish Database -run API
sqlcmd -?
sqlcmd -S $serverOrLocalComputerName
sqlcmd -S $serverOrLocalComputerName -d $DbName
sqlcmd -S $serverOrLocalComputerName -d $DbName -E
sqlcmd -S $serverOrLocalComputerName -d $DbName -U DIR\kacper.sledz
sqlcmd -S $serverOrLocalComputerName -d $DbName -U DIR\kacper.sledz -E
Start-Process "$((git remote get-url origin).Replace('.git', ''))/pull/new/$(git branch --show-current)"
Start-Process "$((git remote get-url origin).Replace('.git', ''))/pulls"
Start-Process chrome --auto-open-devtools-for-tabsgit init
vsts-npm
vsts-npm-auth
vsts-npm-auth -config .npmrc
vsts-npm-auth -config .npmrc
vsts-npm-auth -f -config .npmrc
npm install --legacy-peer-deps
################################### OLD CMD History ###################################
Get-NetIPAddress -AddressFamily IPv4
forFiles /S /M * /C "cmd /c if @fsize GEQ 104857600 echo @path > LargeFilesList.txt"
git filter-repo --invert-paths --path Dependencies/ODAC122010Client_x64/instantclient_12_2/oraociei12.dll
git gc --prune=now --aggressive
git lfs install
git lfs track "Dependencies\ODAC122010Client_x64\instantclient_12_2\oraociei12.dll"
git log --pretty=fuller
git merge --edit --no-fastForward
git rebase -i --root
git reflog expire --expire=now --all
git reflog expire --expire=now --all; git gc --prune=now --aggressive
git rm -r Dependencies/ODAC122010Client_x64/instantclient_12_2/oraociei12.sym
git signature
java -jar bfg.jar --delete-files Dependencies/ODAC122010Client_x64/instantclient_12_2/oraociei12.dll
java -jar bfg.jar --delete-files oraociei12.dll
java -jar bfg.jar --strip-blobs-bigger-than 100M
java -jar bfg.jar --strip-blobs-bigger-than 100M CwisGui.WebService.git
java -jar bfg.jar --strip-blobs-bigger-than 100M some-big-repo.git
nslookup