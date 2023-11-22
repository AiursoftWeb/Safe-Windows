function CheckNetworkPrivacyStatus {
    $networkProfiles = Get-NetConnectionProfile
    foreach ($networkProfile in $networkProfiles) {
        if ($networkProfile.NetworkCategory -ne "Public") {
            return $false
        }
    }

    return $true;
}

Export-ModuleMember -Function CheckNetworkPrivacyStatus