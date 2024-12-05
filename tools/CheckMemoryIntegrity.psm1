function CheckMemoryIntegrity {
    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"

    if (Test-Path -Path $path) {
        $value = Get-ItemProperty -Path $path -Name "Enabled" -ErrorAction SilentlyContinue
        if ($value -ne $null) {
            return $value.Enabled
        }
    }
    return $false
}

#Local Security Authority protection
# This can be enabled via `reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v RunAsPPL /t REG_DWORD /d 2 /f;reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v RunAsPPLBoot /t REG_DWORD /d 2 /f`.
# However, this function only checks if the RunAsPPL value is set to 2.
function CheckLocalSecurityAuthorityProtection {
    $path = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
    if (Test-Path -Path $path) {
        $value = Get-ItemProperty -Path $path -Name "RunAsPPL" -ErrorAction SilentlyContinue
        if ($value -ne $null) {
            return $value.RunAsPPL -eq 2
        }
    }
    return $false
}

Export-ModuleMember -Function CheckMemoryIntegrity -Function CheckLocalSecurityAuthorityProtection