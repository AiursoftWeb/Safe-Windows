$modules = Get-ChildItem -Path $PSScriptRoot -Recurse -Filter *.psm1
$modules.FullName | ForEach-Object { Import-Module $_ -DisableNameChecking }

function Get-IsElevated {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator))
    { Write-Output $true }      
    else
    { Write-Output $false }   
}

function EnsureElevated {
    if (-not(Get-IsElevated)) { 
        throw "Please run this script as an administrator" 
    }
}


function CheckSecurity {
    EnsureElevated

    # Hardware settings.
    $dmaProtection = CheckDmaProtectionStatus
    if ($dmaProtection) {
        Write-Host "[  OK  ] Kernel DMA Protection is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Kernel DMA Protection is disabled" -ForegroundColor Red
    }    

    $virtualizationBasedSecurity = CheckVirtualizationBasedSecurityStatus
    if ($virtualizationBasedSecurity) {
        Write-Host "[  OK  ] Virtualization Based Security is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Virtualization Based Security is disabled" -ForegroundColor Red
    }

    $codeIntegrityPolicyEnforcement = CheckCodeIntegrityPolicyEnforcement
    if ($codeIntegrityPolicyEnforcement) {
        Write-Host "[  OK  ] Code Integrity Policy Enforcement is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Code Integrity Policy Enforcement is disabled" -ForegroundColor Red
    }

    $tpmStatus = CheckTpmStatus
    if ($tpmStatus) {
        Write-Host "[  OK  ] TPM is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] TPM is disabled" -ForegroundColor Red
    }

    $secureBootStatus = CheckSecureBootStatus
    if ($secureBootStatus) {
        Write-Host "[  OK  ] Secure Boot is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Secure Boot is disabled" -ForegroundColor Red
    }

    $modernStandbyStatus = CheckModernStandbyStatus
    if ($modernStandbyStatus) {
        Write-Host "[  OK  ] Modern Standby is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ WARN ] Modern Standby is disabled" -ForegroundColor Yellow
    }

    # Disk settings.
    $bitlockerStatus = CheckBitlockerStatus
    if ($bitlockerStatus) {
        Write-Host "[  OK  ] Bitlocker is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Bitlocker is disabled" -ForegroundColor Red
    }

    $deviceEncryptionStatus = CheckDeviceEncryptionStatus
    if ($deviceEncryptionStatus) {
        Write-Host "[  OK  ] Device Encryption is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Device Encryption is disabled" -ForegroundColor Red
    }

    # Windows security settings.
    $windowsRecoveryEnvironmentStatus = CheckWindowsRecoveryEnvironmentStatus
    if ($windowsRecoveryEnvironmentStatus) {
        Write-Host "[  OK  ] Windows Recovery Environment is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Windows Recovery Environment is disabled" -ForegroundColor Red
    }

    $remoteDesktopEnabled = CheckRemoteDesktopEnabled
    if ($remoteDesktopEnabled) {
        Write-Host "[ WARN ] Remote Desktop is enabled" -ForegroundColor Yellow
    }
    else {
        Write-Host "[  OK  ] Remote Desktop is disabled" -ForegroundColor Green
    }

    $uacEnabled = CheckUACEnabled
    if ($uacEnabled) {
        Write-Host "[  OK  ] UAC is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] UAC is not correctly configured" -ForegroundColor Red
    }

    $windowsDefenderStatus = CheckWindowsDefenderStatus
    if ($windowsDefenderStatus) {
        Write-Host "[  OK  ] Windows Defender is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Windows Defender is disabled" -ForegroundColor Red
    }

    $networkPrivacyStatus = CheckNetworkPrivacyStatus
    if ($networkPrivacyStatus) {
        Write-Host "[  OK  ] All networks are set to public" -ForegroundColor Green
    }
    else {
        Write-Host "[ WARN ] Some networks enabled discovery" -ForegroundColor Yellow
    }

    $windowsUpdateStatus = CheckWindowsUpdateStatus
    if ($windowsUpdateStatus) {
        Write-Host "[  OK  ] Windows Update is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Windows Update is disabled" -ForegroundColor Red
    }

    # User settings.
    $windowsHelloStatus = CheckWindowsHelloStatus
    if ($windowsHelloStatus) {
        Write-Host "[  OK  ] Windows Hello is enabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ WARN ] Windows Hello is disabled" -ForegroundColor Yellow
    }

    $passwordlessStatus = CheckPasswordlessStatus
    if ($passwordlessStatus) {
        Write-Host "[  OK  ] Auto login in not allowed" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Auto login is allowed" -ForegroundColor Red
    }

    $administatorUserDisabled = CheckAdministatorUserDisabled
    if ($administatorUserDisabled) {
        Write-Host "[  OK  ] Administrator user is disabled" -ForegroundColor Green
    }
    else {
        Write-Host "[ FAIL ] Administrator user is enabled" -ForegroundColor Red
    }
}

CheckSecurity
