function CheckPasswordlessStatus {
    $passwordlessStatus = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Passwordless\Device" -Name "DevicePasswordLessBuildVersion"
    return $passwordlessStatus.DevicePasswordLessBuildVersion -eq 2
}

Export-ModuleMember -Function CheckPasswordlessStatus