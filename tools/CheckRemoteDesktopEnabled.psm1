
function CheckRemoteDesktopEnabled {
    $remoteDesktopEnabled = Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections"
    return $remoteDesktopEnabled.fDenyTSConnections -eq 0
}

Export-ModuleMember -Function CheckRemoteDesktopEnabled