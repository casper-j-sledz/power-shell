# %AppDta%\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
################################### OLD CMD History ###################################
$Env:PATH = "$Env:PATH;C:\Program Files\NuGet"
.net build
git commit --amend --no-edit --date "Mon Mar 4 08:12:00 2024 +0000"git
Get-NetIPAddress -AddressFamily IPv4
dotnet build
dotnet restore
forfiles /S /M * /C "cmd /c if @fsize GEQ 104857600 echo @path > LargeFilesList.txt"
git --help
git checkout {{ Commit }}
git cherry-pick --abort
git cherry-pick --continue
git cherry-pick abort
git clone {{ Repository }}
git commit --amend
git commit --amend --date="Mon Mar 4 08:12:00 2024 +0000" --no-edit
git commit {{ Commit }} --amend
git config --global core.editor "'C:\Program Files\Microsoft VS Code\Code.exe' -n -w"
git config --global sequence.editor "'C:\Program Files\Microsoft VS Code\Code.exe' -n -w"
git config user.email "kacper.sledz@ingka.com"
git config user.name "Casper J. Sledz"
git data
git fetch
git fetch --p
git fetch --tag
git fetch --tags
git filter-repo --invert-paths --path Dependencies/ODAC122010Client_x64/instantclient_12_2/oraociei12.dll
git gc --prune=now --aggressive
git lfs install
git lfs track "Dependencies\ODAC122010Client_x64\instantclient_12_2\oraociei12.dll"
git log --pretty=fuller
git ls-tree -r --long HEAD | sort -k 4 -n -r
git ls-tree -r --long HEAD | sort -k 4 -n -r | less
git merge --abort
git merge --edit
git merge --edit --no-ff
git merge --edit test
git pull
git push
git push --force
git push --set-upstream origin {{ Branch }} --force
git push --set-upstream origin {{ Branch }}
git push --tags
git push --tags --force
git push origin
git push origin --all
git rebase --abandon
git rebase --abort
git rebase --continue
git rebase --rebase-merges -i
git rebase -i  HEAD~5 --rebase-merges
git rebase -i --root
git rebase -i HEAD~5 --rebase-merges
git rebase -i HEAD~9
git reflog expire --expire=now --all
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git remote add origin https://cwis-gui.visualstudio.com/CwisGui.WebService/_git/CwisGui.WebService
git remote get-url origin
git remote rm origin
git rm -r Dependencies/ODAC122010Client_x64/instantclient_12_2/oraociei12.sym
git signature
git start
gpupdate /force
java
java -jar bfg.jar --delete-files Dependencies/ODAC122010Client_x64/instantclient_12_2/oraociei12.dll
java -jar bfg.jar --delete-files oraociei12.dll
java -jar bfg.jar --strip-blobs-bigger-than 100M
java -jar bfg.jar --strip-blobs-bigger-than 100M CwisGui.WebService.git
java -jar bfg.jar --strip-blobs-bigger-than 100M some-big-repo.git
ng g s src\app\modules\main\components\application-frame\services\versions
ng test --code-coverage
npm audit
npm audit fix
npm audit fix --force
npm install
npm install -g @angular/cli
npm start
npm test
npm uninstall -g @angular/cli
nslookup
nuget
nuget.exe
podman
rm -fr ".git/rebase-merge"
################################### NEW  CMD History ###################################
Get-ChildItem -Filter *.dll | Add-Member NoteProperty AssemblyVersion([Reflection.AssemblyName]::GetAssemblyName($_.FullName).Version)
Get-ChildItem -Filter *.dll | Add-Member NoteProperty FileVersion ($_.VersionInfo.FileVersion)
dotnet ef database update && cd ../
$c = Get-Credential -credential User01
$c = TREE $path
$cred = Get-Credential 
$cred = Get-Credential -credential $UserName
(Get-Item "C:\Users\kacper.sledz\Downloads\0.Priv.CodeSandbox\packages\System.Runtime.CompilerServices.Unsafe.4.5.3\lib\net461\System.Runtime.CompilerServices.Unsafe.dll").VersionInfo
DotNet ef database update
DotNet restore $sln
Get-ChildItem -Filter *.dll -Recurse | ForEach-Object {`
         try {`
             $_ | Add-Member NoteProperty FileVersion($_.VersionInfo.FileVersion)`
             $_ | Add-Member NoteProperty AssemblyVersion([Reflection.AssemblyName]::GetAssemblyName($_.FullName).Version)`
         } catch {}`
         $_`
     } | Select-Object Name,FileVersion,AssemblyVersion
Get-ChildItem -Filter *.dll -Recurse | ForEach-Object {`
       $_ | Add-Member NoteProperty AssemblyVersion([Reflection.AssemblyName]::GetAssemblyName($_.FullName).Version)`
     } | Select-Object Name,AssemblyVersion
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Enrollments -Exclude Context,Ownership,Status,ValidNodePaths | Where-Object -Property Name -Like "*$((Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts).Name | Split-Path -Leaf)*" | Remove-Item -Force
Get-Command -Module LanguagePackManagement
Get-Content env:computername
Get-Host
Get-Process -Id (Get-NetTCPConnection -LocalPort 10000).OwningProcess
Get-Process -Id 36876
New-LocalGroup -Name 'docker-users' -Description 'docker Users Group'
Remove-Item -LiteralPath node_modules -Force -Recurse
Set-MpPreference -EnableControlledFolderAccess Enabled
Set-MpPreference -EnableNetworkProtection Enabled
Stop-Process -Id 36876
Update-Database -Project RSM.Infrastructure -StartupProject RSM.Web -context AppDbContext
WSL > sudo apt update
WSL > sudo apt upgrade
[System.Reflection.Assembly] | get-members
az account show
az deployment group create --name ServiceBusDeployment --resource-group local-group --template-file servicebus-template.json --parameters sb_namespaces_name=service-bus-ns --mode Complete --verbose
az group create --name local-group --location "North Europe"
az login
az servicebus namespace authorization-rule keys list --resource-group local-group --namespace-name service-bus-ns --name Manage --query primaryConnectionString -o tsv
az servicebus namespace exists --name $name
az version
azurite --silent --location c:\azurite --debug c:\azurite\debug.log
dotnet ef database update
dotnet ef migrations add AddUserProjectStartDateEndDate; cd ../
dotnet ef migrations add UpdateUserProjectWithStartDateEndDate; cd ../
code --list-extensions | % { "code --install-extension $_" }
code . --verbose
dotnet --info
dotnet build
dotnet build $csprojPath --force
dotnet ef database update
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
git rebase -i HEAD~9
git stash save "TEMP_$(Get-Date -Format "yyyy-MM-dd_HH:mm")"; git pull; git stash apply
git update-git-for-windows
jb inspectcode --build --format=Text -o="$($env:UserProfile)\Downloads\0.RR\rsm-code-inspection.txt" --severity=WARNING --verbosity=WARN --profile=".\RSM.sln.DotSettings" --no-swea RSM.sln 
jb inspectcode --build --format=Text -o="$($env:UserProfile)\Downloads\0.RR\rsm-code-inspection.txt" --severity=WARNING --verbosity=WARN --profile=".\RSM.sln.DotSettings" --no-swea RSM.sln && Type "$($env:UserProfile)\Downloads\0.RR\rsm-code-inspection.txt"
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
npm config delete //pkgs.dev.azure.com/RRALM/_packaging/cobalt-ui-kit/npm/registry/:_password //pkgs.dev.azure.com/RRALM/_packaging/cobalt-ui-kit/npm/registry/:username //pkgs.dev.azure.com/RRALM/_packaging/cobalt-ui-kit/npm/registry/:email email && vsts-npm-auth -config .npmrc
npm config edit
npm config list
npm fetch
npm i --save-dev @playwright/test
npm i -g nswag@14.2
npm i sharp
npm init playwright@latest
npm install
npm install --legacy-peer-deps
npm install -g @angular/cli@15.2.11
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
start "$((git remote get-url origin).Replace('.git', ''))/pull/new/$(git branch --show-current)"
start "$((git remote get-url origin).Replace('.git', ''))/pulls"
start chrome --auto-open-devtools-for-tabsgit init
vsts-npm
vsts-npm-auth
vsts-npm-auth -config .npmrc
vsts-npm-auth -config .npmrc 
vsts-npm-auth -f -config .npmrc
npm install --legacy-peer-deps