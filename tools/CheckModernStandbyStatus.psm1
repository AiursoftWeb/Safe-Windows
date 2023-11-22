function CheckModernStandbyStatus {
    $availableStates = powercfg /a 2>&1
    $availableStatesStartIndex = $availableStates.IndexOf("The following sleep states are available on this system:")
    $availableStatesEndIndex = $availableStates.IndexOf("The following sleep states are not available on this system:")

    if ($availableStatesStartIndex -eq -1) {
        return $false
    }
    else {
        $availableStatesStartIndex = $availableStatesStartIndex + 1
    }

    if ($availableStatesEndIndex -eq -1) {
        $availableStatesEndIndex = $availableStates.Count
    }
    else {
        $availableStatesEndIndex = $availableStatesEndIndex - 1
    }

    for ($index = $availableStatesStartIndex; $index -le $availableStatesEndIndex; $index++ ) {
        if ($availableStates[$index].Contains("Standby (S0 Low Power Idle")) {
            return $true
        }
    }

    return $false
}

Export-ModuleMember -Function CheckModernStandbyStatus