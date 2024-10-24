function CheckRecentUpdateTime {
    $updateTimes = Get-HotFix | Select-Object -ExpandProperty InstalledOn
    $mostRecentUpdateTime = $updateTimes | Sort-Object -Descending | Select-Object -First 1
    $recentMonthInstalledAnUpdate = $mostRecentUpdateTime -gt (Get-Date).AddDays(-45)
    return $recentMonthInstalledAnUpdate
}

Export-ModuleMember -Function CheckRecentUpdateTime