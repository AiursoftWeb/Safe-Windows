
function CheckVirtualizationBasedSecurityStatus {
    $vbsStatus = Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard
    
    # 0 = VBS isn't enabled.
    # 1 = VBS is enabled but not running.
    # 2 = VBS is enabled and running.
    return $vbsStatus.VirtualizationBasedSecurityStatus -eq 2
}

Export-ModuleMember -Function CheckVirtualizationBasedSecurityStatus
