SET AGENT_TOOLSDIRECTORY="C:\hostedtoolcache\windows"
SET HELPER_SCRIPT_FOLDER="C:\Program Files\WindowsPowerShell\Modules\"
SET IMAGE_FOLDER="C:\image"
SET elevated_password= "vault!db0981"
SET elevated_user= "vaultdb"

Set-ExecutionPolicy Unrestricted

New-Item -Type Directory -Path "C:\image"

Move-Item 'C:\image\assets\post-gen' 'C:\post-generation'
Remove-Item -Recurse 'C:\image\assets'
Move-Item 'C:\image\scripts\docs-gen' 'C:\image\SoftwareReport'
Move-Item 'C:\image\scripts\helpers' 'C:\Program Files\WindowsPowerShell\Modules\ImageHelpers'
New-Item -Type Directory -Path 'C:\Program Files\WindowsPowerShell\Modules\TestsHelpers\'
Move-Item 'C:\image\scripts\tests\Helpers.psm1' 'C:\Program Files\WindowsPowerShell\Modules\TestsHelpers\TestsHelpers.psm1'
Move-Item 'C:\image\scripts\tests' 'C:\image\tests'
Move-Item 'C:\image\scripts\build' 'C:\image\build'
Remove-Item -Recurse 'C:\image\scripts'
Move-Item 'C:\image\toolsets\toolset-2022.json' 'C:\image\toolset.json'
Remove-Item -Recurse 'C:\image\toolsets'

net user vaultdb vault!db0981 /add /passwordchg:no /passwordreq:yes /active:yes /Y
net localgroup Administrators vaultdb /add
winrm set winrm/config/service/auth @{Basic="true"}
winrm get winrm/config/service/auth

if (-not ((net localgroup Administrators) -contains 'vaultdb')) { exit 1 }

bcdedit.exe /set TESTSIGNING ON

C:\image\scripts\build\Configure-WindowsDefender.ps1
C:\image\scripts\build\Configure-PowerShell.ps1
C:\image\scripts\build\Install-PowerShellModules.ps1
C:\image\scripts\build\Install-WindowsFeatures.ps1
C:\image\scripts\build\Install-Chocolatey.ps1
C:\image\scripts\build\Configure-BaseImage.ps1
C:\image\scripts\build\Configure-ImageDataFile.ps1
C:\image\scripts\build\Configure-SystemEnvironment.ps1
C:\image\scripts\build\Configure-DotnetSecureChannel.ps1"

C:\image\scripts\build\Install-VCRedist.ps1
C:\image\scripts\build\Install-Docker.ps1
C:\image\scripts\build\Install-DockerWinCred.ps1
C:\image\scripts\build\Install-DockerCompose.ps1
C:\image\scripts\build\Install-PowershellCore.ps1
C:\image\scripts\build\Install-WebPlatformInstaller.ps1
C:\image\scripts\build\Install-Runner.ps1"


C:\image\scripts\build\Install-VisualStudio.ps1
C:\image\scripts\build\Install-KubernetesTools.ps1
C:\image\scripts\build\Install-NET48-devpack.ps1"


C:\image\scripts\build\Install-Wix.ps1
C:\image\scripts\build\Install-WDK.ps1
C:\image\scripts\build\Install-VSExtensions.ps1
C:\image\scripts\build\Install-AzureCli.ps1
C:\image\scripts\build\Install-AzureDevOpsCli.ps1
C:\image\scripts\build\Install-ChocolateyPackages.ps1
C:\image\scripts\build\Install-JavaTools.ps1
C:\image\scripts\build\Install-Kotlin.ps1
C:\image\scripts\build\Install-OpenSSL.ps1"

wmic product where "name like '%%microsoft azure powershell%%'" call uninstall /nointeractive

C:\image\scripts\build\Install-ActionsCache.ps1
C:\image\scripts\build\Install-Ruby.ps1
C:\image\scripts\build\Install-PyPy.ps1
C:\image\scripts\build\Install-Toolset.ps1
C:\image\scripts\build\Configure-Toolset.ps1
C:\image\scripts\build\Install-NodeJS.ps1
C:\image\scripts\build\Install-AndroidSDK.ps1
C:\image\scripts\build\Install-PowershellAzModules.ps1
C:\image\scripts\build\Install-Pipx.ps1
C:\image\scripts\build\Install-Git.ps1
C:\image\scripts\build\Install-GitHub-CLI.ps1
C:\image\scripts\build\Install-PHP.ps1
C:\image\scripts\build\Install-Rust.ps1
C:\image\scripts\build\Install-Sbt.ps1
C:\image\scripts\build\Install-Chrome.ps1
C:\image\scripts\build\Install-EdgeDriver.ps1
C:\image\scripts\build\Install-Firefox.ps1
C:\image\scripts\build\Install-Selenium.ps1
C:\image\scripts\build\Install-IEWebDriver.ps1
C:\image\scripts\build\Install-Apache.ps1
C:\image\scripts\build\Install-Nginx.ps1
C:\image\scripts\build\Install-Msys2.ps1
C:\image\scripts\build\Install-WinAppDriver.ps1
C:\image\scripts\build\Install-R.ps1
C:\image\scripts\build\Install-AWSTools.ps1
C:\image\scripts\build\Install-DACFx.ps1
C:\image\scripts\build\Install-MysqlCli.ps1
C:\image\scripts\build\Install-SQLPowerShellTools.ps1
C:\image\scripts\build\Install-SQLOLEDBDriver.ps1
C:\image\scripts\build\Install-DotnetSDK.ps1
C:\image\scripts\build\Install-Mingw64.ps1
C:\image\scripts\build\Install-Haskell.ps1
C:\image\scripts\build\Install-Stack.ps1
C:\image\scripts\build\Install-Miniconda.ps1
C:\image\scripts\build\Install-AzureCosmosDbEmulator.ps1
C:\image\scripts\build\Install-Mercurial.ps1
C:\image\scripts\build\Install-Zstd.ps1
C:\image\scripts\build\Install-NSIS.ps1
C:\image\scripts\build\Install-CloudFoundryCli.ps1
C:\image\scripts\build\Install-Vcpkg.ps1
C:\image\scripts\build\Install-PostgreSQL.ps1
C:\image\scripts\build\Install-Bazel.ps1
C:\image\scripts\build\Install-AliyunCli.ps1
C:\image\scripts\build\Install-RootCA.ps1
C:\image\scripts\build\Install-MongoDB.ps1
C:\image\scripts\build\Install-GoogleCloudCLI.ps1
C:\image\scripts\build\Install-CodeQLBundle.ps1
C:\image\scripts\build\Install-BizTalkBuildComponent.ps1
C:\image\scripts\build\Configure-Diagnostics.ps1
C:\image\scripts\build\Configure-DynamicPort.ps1
C:\image\scripts\build\Configure-GDIProcessHandleQuota.ps1
C:\image\scripts\build\Configure-Shell.ps1
C:\image\scripts\build\Configure-DeveloperMode.ps1
C:\image\scripts\build\Install-LLVM.ps1"


C:\image\scripts\build\Install-WindowsUpdates.ps1

powershell -command "& {if ((-not (Get-Process TiWorker.exe -ErrorAction SilentlyContinue)) -and (-not [System.Environment]::HasShutdownStarted) ) { Write-Output 'Restart complete' }}"

C:\image\scripts\build\Install-WindowsUpdatesAfterReboot.ps1
C:\image\scripts\tests\RunAll-Tests.ps1"


C:\image\scripts\build\Configure-System.ps1
C:\image\scripts\build\Configure-User.ps1"

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
