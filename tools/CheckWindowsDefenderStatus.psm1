
function CheckWindowsDefenderStatus {
    $windowsDefenderStatus = Get-MpComputerStatus
    return $windowsDefenderStatus.AntivirusEnabled -eq $true`
        -and $windowsDefenderStatus.RealTimeProtectionEnabled -eq $true`
        -and $windowsDefenderStatus.BehaviorMonitorEnabled -eq $true`
        -and $windowsDefenderStatus.OnAccessProtectionEnabled -eq $true`
        -and $windowsDefenderStatus.AntispywareEnabled -eq $true
}

CheckWindowsDefenderStatus
