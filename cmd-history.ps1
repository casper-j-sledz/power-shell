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