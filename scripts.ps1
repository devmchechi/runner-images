
$env:AGENT_TOOLSDIRECTORY="C:\hostedtoolcache\windows"
$env:HELPER_SCRIPT_FOLDER="C:\Program Files\WindowsPowerShell\Modules\"
$env:IMAGE_FOLDER="C:\image"

Set-ExecutionPolicy Unrestricted

New-Item -Type Directory -Path $env:IMAGE_FOLDER

Move-Item 'assets\post-gen' 'C:\post-generation'
Remove-Item -Recurse 'assets'
Move-Item 'scripts\docs-gen' "${env:IMAGE_FOLDER}\SoftwareReport"
Move-Item 'scripts\helpers' 'C:\Program Files\WindowsPowerShell\Modules\ImageHelpers'
New-Item -Type Directory -Path 'C:\Program Files\WindowsPowerShell\Modules\TestsHelpers\'
Move-Item 'scripts\tests\Helpers.psm1' 'C:\Program Files\WindowsPowerShell\Modules\TestsHelpers\TestsHelpers.psm1'
Move-Item 'scripts\tests' "${env:IMAGE_FOLDER}\tests"
Move-Item 'scripts\build' "${env:IMAGE_FOLDER}\build"
Remove-Item -Recurse 'scripts'
Move-Item 'toolsets\toolset-2022.json' "${env:IMAGE_FOLDER}\toolset.json'
Remove-Item -Recurse 'toolsets'

net user vaultdb vault!db0981 /add /passwordchg:no /passwordreq:yes /active:yes /Y
net localgroup Administrators vaultdb /add
winrm set winrm/config/service/auth @{Basic="true"}
winrm get winrm/config/service/auth

if (-not ((net localgroup Administrators) -contains 'vaultdb')) { exit 1 }

bcdedit.exe /set TESTSIGNING ON

${env:IMAGE_FOLDER}\build\Configure-WindowsDefender.ps1
${env:IMAGE_FOLDER}\build\Configure-PowerShell.ps1
${env:IMAGE_FOLDER}\build\Install-PowerShellModules.ps1

import-module $env:HELPER_SCRIPT_FOLDER\ImageHelpers\ImageHelpers\ImageHelpers.psd1
import-module $env:HELPER_SCRIPT_FOLDER\TestsHelpers\TestsHelpers.psm1

${env:IMAGE_FOLDER}\build\Install-WindowsFeatures.ps1
${env:IMAGE_FOLDER}\build\Install-Chocolatey.ps1
${env:IMAGE_FOLDER}\build\Configure-BaseImage.ps1
${env:IMAGE_FOLDER}\build\Configure-ImageDataFile.ps1
${env:IMAGE_FOLDER}\build\Configure-SystemEnvironment.ps1
${env:IMAGE_FOLDER}\build\Configure-DotnetSecureChannel.ps1"

${env:IMAGE_FOLDER}\build\Install-VCRedist.ps1
${env:IMAGE_FOLDER}\build\Install-Docker.ps1
${env:IMAGE_FOLDER}\build\Install-DockerWinCred.ps1
${env:IMAGE_FOLDER}\build\Install-DockerCompose.ps1
${env:IMAGE_FOLDER}\build\Install-PowershellCore.ps1
${env:IMAGE_FOLDER}\build\Install-WebPlatformInstaller.ps1
${env:IMAGE_FOLDER}\build\Install-Runner.ps1"


${env:IMAGE_FOLDER}\build\Install-VisualStudio.ps1
${env:IMAGE_FOLDER}\build\Install-KubernetesTools.ps1
${env:IMAGE_FOLDER}\build\Install-NET48-devpack.ps1"


${env:IMAGE_FOLDER}\build\Install-Wix.ps1
${env:IMAGE_FOLDER}\build\Install-WDK.ps1
${env:IMAGE_FOLDER}\build\Install-VSExtensions.ps1
${env:IMAGE_FOLDER}\build\Install-AzureCli.ps1
${env:IMAGE_FOLDER}\build\Install-AzureDevOpsCli.ps1
${env:IMAGE_FOLDER}\build\Install-ChocolateyPackages.ps1
${env:IMAGE_FOLDER}\build\Install-JavaTools.ps1
${env:IMAGE_FOLDER}\build\Install-Kotlin.ps1
${env:IMAGE_FOLDER}\build\Install-OpenSSL.ps1"

wmic product where "name like '%%microsoft azure powershell%%'" call uninstall /nointeractive

${env:IMAGE_FOLDER}\build\Install-ActionsCache.ps1
${env:IMAGE_FOLDER}\build\Install-Ruby.ps1
${env:IMAGE_FOLDER}\build\Install-PyPy.ps1
${env:IMAGE_FOLDER}\build\Install-Toolset.ps1
${env:IMAGE_FOLDER}\build\Configure-Toolset.ps1
${env:IMAGE_FOLDER}\build\Install-NodeJS.ps1
${env:IMAGE_FOLDER}\build\Install-AndroidSDK.ps1
${env:IMAGE_FOLDER}\build\Install-PowershellAzModules.ps1
${env:IMAGE_FOLDER}\build\Install-Pipx.ps1
${env:IMAGE_FOLDER}\build\Install-Git.ps1
${env:IMAGE_FOLDER}\build\Install-GitHub-CLI.ps1
${env:IMAGE_FOLDER}\build\Install-PHP.ps1
${env:IMAGE_FOLDER}\build\Install-Rust.ps1
${env:IMAGE_FOLDER}\build\Install-Sbt.ps1
${env:IMAGE_FOLDER}\build\Install-Chrome.ps1
${env:IMAGE_FOLDER}\build\Install-EdgeDriver.ps1
${env:IMAGE_FOLDER}\build\Install-Firefox.ps1
${env:IMAGE_FOLDER}\build\Install-Selenium.ps1
${env:IMAGE_FOLDER}\build\Install-IEWebDriver.ps1
${env:IMAGE_FOLDER}\build\Install-Apache.ps1
${env:IMAGE_FOLDER}\build\Install-Nginx.ps1
${env:IMAGE_FOLDER}\build\Install-Msys2.ps1
${env:IMAGE_FOLDER}\build\Install-WinAppDriver.ps1
${env:IMAGE_FOLDER}\build\Install-R.ps1
${env:IMAGE_FOLDER}\build\Install-AWSTools.ps1
${env:IMAGE_FOLDER}\build\Install-DACFx.ps1
${env:IMAGE_FOLDER}\build\Install-MysqlCli.ps1
${env:IMAGE_FOLDER}\build\Install-SQLPowerShellTools.ps1
${env:IMAGE_FOLDER}\build\Install-SQLOLEDBDriver.ps1
${env:IMAGE_FOLDER}\build\Install-DotnetSDK.ps1
${env:IMAGE_FOLDER}\build\Install-Mingw64.ps1
${env:IMAGE_FOLDER}\build\Install-Haskell.ps1
${env:IMAGE_FOLDER}\build\Install-Stack.ps1
${env:IMAGE_FOLDER}\build\Install-Miniconda.ps1
${env:IMAGE_FOLDER}\build\Install-AzureCosmosDbEmulator.ps1
${env:IMAGE_FOLDER}\build\Install-Mercurial.ps1
${env:IMAGE_FOLDER}\build\Install-Zstd.ps1
${env:IMAGE_FOLDER}\build\Install-NSIS.ps1
${env:IMAGE_FOLDER}\build\Install-CloudFoundryCli.ps1
${env:IMAGE_FOLDER}\build\Install-Vcpkg.ps1
${env:IMAGE_FOLDER}\build\Install-PostgreSQL.ps1
${env:IMAGE_FOLDER}\build\Install-Bazel.ps1
${env:IMAGE_FOLDER}\build\Install-AliyunCli.ps1
${env:IMAGE_FOLDER}\build\Install-RootCA.ps1
${env:IMAGE_FOLDER}\build\Install-MongoDB.ps1
${env:IMAGE_FOLDER}\build\Install-GoogleCloudCLI.ps1
${env:IMAGE_FOLDER}\build\Install-CodeQLBundle.ps1
${env:IMAGE_FOLDER}\build\Install-BizTalkBuildComponent.ps1
${env:IMAGE_FOLDER}\build\Configure-Diagnostics.ps1
${env:IMAGE_FOLDER}\build\Configure-DynamicPort.ps1
${env:IMAGE_FOLDER}\build\Configure-GDIProcessHandleQuota.ps1
${env:IMAGE_FOLDER}\build\Configure-Shell.ps1
${env:IMAGE_FOLDER}\build\Configure-DeveloperMode.ps1
${env:IMAGE_FOLDER}\build\Install-LLVM.ps1"


${env:IMAGE_FOLDER}\build\Install-WindowsUpdates.ps1

powershell -command "& {if ((-not (Get-Process TiWorker.exe -ErrorAction SilentlyContinue)) -and (-not [System.Environment]::HasShutdownStarted) ) { Write-Output 'Restart complete' }}"

${env:IMAGE_FOLDER}\build\Install-WindowsUpdatesAfterReboot.ps1
${env:IMAGE_FOLDER}\tests\RunAll-Tests.ps1"


${env:IMAGE_FOLDER}\build\Configure-System.ps1
${env:IMAGE_FOLDER}\build\Configure-User.ps1"

if( Test-Path $env:SystemRoot\\System32\\Sysprep\\unattend.xml )
{ 
    rm $env:SystemRoot\\System32\\Sysprep\\unattend.xml -Force
}

$env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit

while($true) { 
    $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; 
    if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { 
        Write-Output $imageState.ImageState; Start-Sleep -s 10 
    } else { 
        break 
    } 
}
