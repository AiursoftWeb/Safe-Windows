function CheckBitlockerStatus {
    $systemDrive = (Get-WmiObject Win32_OperatingSystem).SystemDrive

    $bitlockerStatus = Get-BitLockerVolume -MountPoint $systemDrive -ErrorAction SilentlyContinue
    $volumeEncryptionStatus = Get-CimInstance -ClassName Win32_EncryptableVolume -Namespace root\cimv2\security\microsoftvolumeencryption -Filter "DriveLetter = '$systemDrive'"

    return $bitlockerStatus.ProtectionStatus -eq "On" -and $volumeEncryptionStatus.ProtectionStatus -eq 1 -and $volumeEncryptionStatus.IsVolumeInitializedForProtection -eq $true
}