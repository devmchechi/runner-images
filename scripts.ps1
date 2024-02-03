
$env:AGENT_TOOLSDIRECTORY="C:\hostedtoolcache\windows"
$env:HELPER_SCRIPT_FOLDER="C:\Program Files\WindowsPowerShell\Modules"
$env:IMAGE_FOLDER="C:\image"

Set-ExecutionPolicy Unrestricted

New-Item -Type Directory -Path $env:IMAGE_FOLDER

Move-Item 'assets\post-gen' 'C:\post-generation'
Remove-Item -Recurse 'assets'
Move-Item 'scripts\docs-gen' "${env:IMAGE_FOLDER}\SoftwareReport"
Move-Item 'scripts\helpers' '$env:HELPER_SCRIPT_FOLDER\ImageHelpers'
New-Item -Type Directory -Path '$env:HELPER_SCRIPT_FOLDER\TestsHelpers\'
Move-Item 'scripts\tests\Helpers.psm1' '$env:HELPER_SCRIPT_FOLDER\TestsHelpers\TestsHelpers.psm1'
Move-Item 'scripts\tests' "${env:IMAGE_FOLDER}\tests"
Move-Item 'scripts\build' "${env:IMAGE_FOLDER}\build"
Remove-Item -Recurse 'scripts'
Move-Item 'toolsets\toolset-2022.json' "${env:IMAGE_FOLDER}\toolset.json"
Remove-Item -Recurse 'toolsets'

net localgroup Administrators vaultdb /add
winrm set winrm/config/service/auth @{Basic="true"}
winrm get winrm/config/service/auth

if (-not ((net localgroup Administrators) -contains 'vaultdb')) { exit 1 }

bcdedit.exe /set TESTSIGNING ON

c:\image\build\Configure-WindowsDefender.ps1
c:\image\build\Configure-PowerShell.ps1
c:\image\build\Install-PowerShellModules.ps1

import-module "$env:HELPER_SCRIPT_FOLDER\ImageHelpers\ImageHelpers.psd1"
import-module "$env:HELPER_SCRIPT_FOLDER\TestsHelpers\TestsHelpers.psm1"

c:\image\build\Install-WindowsFeatures.ps1
c:\image\build\Install-Chocolatey.ps1
c:\image\build\Configure-BaseImage.ps1
c:\image\build\Configure-ImageDataFile.ps1
c:\image\build\Configure-SystemEnvironment.ps1
c:\image\build\Configure-DotnetSecureChannel.ps1

c:\image\build\Install-VCRedist.ps1
c:\image\build\Install-Docker.ps1
c:\image\build\Install-DockerWinCred.ps1
c:\image\build\Install-DockerCompose.ps1
c:\image\build\Install-PowershellCore.ps1
c:\image\build\Install-WebPlatformInstaller.ps1
c:\image\build\Install-Runner.ps1


c:\image\build\Install-VisualStudio.ps1
c:\image\build\Install-KubernetesTools.ps1
c:\image\build\Install-NET48-devpack.ps1


c:\image\build\Install-Wix.ps1
c:\image\build\Install-WDK.ps1
c:\image\build\Install-VSExtensions.ps1
c:\image\build\Install-AzureCli.ps1
c:\image\build\Install-AzureDevOpsCli.ps1
c:\image\build\Install-ChocolateyPackages.ps1
c:\image\build\Install-JavaTools.ps1
c:\image\build\Install-Kotlin.ps1
c:\image\build\Install-OpenSSL.ps1

wmic product where "name like '%%microsoft azure powershell%%'" call uninstall /nointeractive

c:\image\build\Install-ActionsCache.ps1
c:\image\build\Install-Ruby.ps1
c:\image\build\Install-PyPy.ps1
c:\image\build\Install-Toolset.ps1
c:\image\build\Configure-Toolset.ps1
c:\image\build\Install-NodeJS.ps1
c:\image\build\Install-AndroidSDK.ps1
c:\image\build\Install-PowershellAzModules.ps1
c:\image\build\Install-Pipx.ps1
c:\image\build\Install-Git.ps1
c:\image\build\Install-GitHub-CLI.ps1
c:\image\build\Install-PHP.ps1
c:\image\build\Install-Rust.ps1
c:\image\build\Install-Sbt.ps1
c:\image\build\Install-Chrome.ps1
c:\image\build\Install-EdgeDriver.ps1
c:\image\build\Install-Firefox.ps1
c:\image\build\Install-Selenium.ps1
c:\image\build\Install-IEWebDriver.ps1
c:\image\build\Install-Apache.ps1
c:\image\build\Install-Nginx.ps1
c:\image\build\Install-Msys2.ps1
c:\image\build\Install-WinAppDriver.ps1
c:\image\build\Install-R.ps1
c:\image\build\Install-AWSTools.ps1
c:\image\build\Install-DACFx.ps1
c:\image\build\Install-MysqlCli.ps1
c:\image\build\Install-SQLPowerShellTools.ps1
c:\image\build\Install-SQLOLEDBDriver.ps1
c:\image\build\Install-DotnetSDK.ps1
c:\image\build\Install-Mingw64.ps1
c:\image\build\Install-Haskell.ps1
c:\image\build\Install-Stack.ps1
c:\image\build\Install-Miniconda.ps1
c:\image\build\Install-AzureCosmosDbEmulator.ps1
c:\image\build\Install-Mercurial.ps1
c:\image\build\Install-Zstd.ps1
c:\image\build\Install-NSIS.ps1
c:\image\build\Install-CloudFoundryCli.ps1
c:\image\build\Install-Vcpkg.ps1
c:\image\build\Install-PostgreSQL.ps1
c:\image\build\Install-Bazel.ps1
c:\image\build\Install-AliyunCli.ps1
c:\image\build\Install-RootCA.ps1
c:\image\build\Install-MongoDB.ps1
c:\image\build\Install-GoogleCloudCLI.ps1
c:\image\build\Install-CodeQLBundle.ps1
c:\image\build\Install-BizTalkBuildComponent.ps1
c:\image\build\Configure-Diagnostics.ps1
c:\image\build\Configure-DynamicPort.ps1
c:\image\build\Configure-GDIProcessHandleQuota.ps1
c:\image\build\Configure-Shell.ps1
c:\image\build\Configure-DeveloperMode.ps1
c:\image\build\Install-LLVM.ps1


c:\image\build\Install-WindowsUpdates.ps1

powershell -command "& {if ((-not (Get-Process TiWorker.exe -ErrorAction SilentlyContinue)) -and (-not [System.Environment]::HasShutdownStarted) ) { Write-Output 'Restart complete' }}"

c:\image\build\Install-WindowsUpdatesAfterReboot.ps1
c:\image\tests\RunAll-Tests.ps1


c:\image\build\Configure-System.ps1
c:\image\build\Configure-User.ps1

if( Test-Path "$env:SystemRoot\\System32\\Sysprep\\unattend.xml" )
{ 
    Remove-Item "$env:SystemRoot\\System32\\Sysprep\\unattend.xml" -Force
}

"$env:SystemRoot\System32\Sysprep\Sysprep.exe" /oobe /generalize /quiet /quit

while($true) { 
    $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; 
    if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { 
        Write-Output $imageState.ImageState; Start-Sleep -s 10 
    } else { 
        break 
    } 
}
