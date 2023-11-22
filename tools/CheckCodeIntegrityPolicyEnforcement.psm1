function CheckCodeIntegrityPolicyEnforcement {
    $codeIntegrityPolicyEnforcement = Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard
    
    # 0 = Not Configured.
    # 1 = Audit.
    # 2 = Enforced.
    return $codeIntegrityPolicyEnforcement.CodeIntegrityPolicyEnforcementStatus -eq 2
}
