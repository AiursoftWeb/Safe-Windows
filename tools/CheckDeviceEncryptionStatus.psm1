function CheckDeviceEncryptionStatus {
    $systemDrive = (Get-WmiObject Win32_OperatingSystem).SystemDrive
    $bdeStatus = manage-bde -protectors -get $systemDrive
    return ($bdeStatus -match "[ \t]*\(Uses Secure Boot for integrity validation\)").count -gt 0
}

Export-ModuleMember -Function CheckDeviceEncryptionStatus