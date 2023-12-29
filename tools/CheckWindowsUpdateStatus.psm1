function CheckWindowsUpdateStatus {
    $windowsUpdateStatus = Get-Service -Name wuauserv
    return $windowsUpdateStatus.Status -eq "Running"
}

Export-ModuleMember -Function CheckWindowsUpdateStatus