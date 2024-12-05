function Check-HypervisorEnforcedCodeIntegrityEnabled {
    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"

    if (Test-Path -Path $path) {
        $value = Get-ItemProperty -Path $path -Name "Enabled"
        if ($value -ne $null) {
            return $value.Enabled
        }
    }
    return $false
}

Export-ModuleMember -Function Check-HypervisorEnforcedCodeIntegrityEnabled