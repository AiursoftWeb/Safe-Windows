function CheckRecentUpdateTime {
    # Get all hotfixes and filter out any that don't have a valid 'InstalledOn' date
    $updateTimes = Get-HotFix | Where-Object { $_.InstalledOn -ne $null } | Select-Object -ExpandProperty InstalledOn

    # Check if there are any valid dates, then find the most recent one
    if ($updateTimes.Count -gt 0) {
        $mostRecentUpdateTime = $updateTimes | Sort-Object -Descending | Select-Object -First 1
        
        # Check if the most recent update was within the last 45 days
        $recentMonthInstalledAnUpdate = $mostRecentUpdateTime -gt (Get-Date).AddDays(-45)
        
        return $recentMonthInstalledAnUpdate
    } else {
        Write-Warning "No updates found with valid 'InstalledOn' dates."
        return $false
    }
}

Export-ModuleMember -Function CheckRecentUpdateTime
