function CheckAntiViruses {

    # Clean                          1
    # Quarantine                     2
    # Remove                         3
    # Allow                          6
    # UserDefined                    8
    # NoAction                       9
    # Block                          10

    $settings = Get-MpPreference

    $disableRealtimeMonitoring = $settings.DisableRealtimeMonitoring
    $disableBehaviorMonitoring = $settings.DisableBehaviorMonitoring
    $disableBlockAtFirstSeen = $settings.DisableBlockAtFirstSeen
    $disableIOAVProtection = $settings.DisableIOAVProtection
    $disablePrivacyMode = $settings.DisablePrivacyMode
    $disableScriptScanning = $settings.DisableScriptScanning

    $allEnabled = (-not $disableRealtimeMonitoring)`
        -and (-not $disableBehaviorMonitoring)`
        -and (-not $disableBlockAtFirstSeen)`
        -and (-not $disableIOAVProtection)`
        -and (-not $disablePrivacyMode)`
        -and (-not $disableScriptScanning)

    if (-not $allEnabled) {
        Write-Error "Windows Defender is not enabled to monitor in real time"
    }

    $networkProtected = $settings.EnableNetworkProtection -eq 1

    #if (-not $networkProtected) {
    #    Write-Error "Windows Defender is not protecting the network"
    #}

    $HighThreatDefaultActionIsSafe = $settings.HighThreatDefaultAction -eq 0
    $LowThreatDefaultActionIsSafe = $settings.LowThreatDefaultAction -eq 0
    $ModerateThreatDefaultActionIsSafe = $settings.ModerateThreatDefaultAction -eq 0
    $SevereThreatDefaultActionIsSafe = $settings.SevereThreatDefaultAction -eq 0
    $UnknownThreatDefaultActionIsSafe = $settings.UnknownThreatDefaultAction -eq 0

    $allActionsAreSafe = $HighThreatDefaultActionIsSafe `
        -and $LowThreatDefaultActionIsSafe `
        -and $ModerateThreatDefaultActionIsSafe `
        -and $SevereThreatDefaultActionIsSafe `
        -and $UnknownThreatDefaultActionIsSafe

    if (-not $allActionsAreSafe) {
        Write-Error "Windows Defender is not configured to take safe actions"
    }

    $exclusionPaths = $settings.ExclusionPath
    # Test if entire system drive is excluded
    $systemDrive = $env:SystemDrive
    $criticalFolderExcluded = 
        $exclusionPaths -contains $systemDrive -or`
        $exclusionPaths -contains "$systemDrive\Windows" -or`
        $exclusionPaths -contains "$systemDrive\Program Files" -or`
        $exclusionPaths -contains "$systemDrive\Program Files (x86)" -or`
        $exclusionPaths -contains "$systemDrive\ProgramData" -or`
        $exclusionPaths -contains "$systemDrive\Users"

    if ($criticalFolderExcluded) {
        Write-Error "Windows Defender is configured to exclude some critical folders"
    }

    return $allEnabled -and $networkProtected -and $allActionsAreSafe -and (-not $criticalFolderExcluded)
}

Export-ModuleMember -Function CheckAntiViruses
