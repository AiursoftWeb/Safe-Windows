function CheckRecentUpdateTime {
    $updateTimes = wmic qfe get InstalledOn | Where-Object { $_ -match "[0-9]/" } | ForEach-Object { $_.ToString().Trim() }
    $mostRecentUpdateTime = $updateTimes | Sort-Object -Descending | Select-Object -First 1
    $recentMonthInstalledAnUpdate = $mostRecentUpdateTime -gt (Get-Date).AddMonths(-1)

    return $recentMonthInstalledAnUpdate
}

Export-ModuleMember -Function CheckRecentUpdateTime