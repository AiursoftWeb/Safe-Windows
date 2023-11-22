function CheckSecureBootStatus {
    $secureBootStatus = Confirm-SecureBootUEFI
    $secureBootPk = Get-SecureBootUEFI -Name "PK" -ErrorAction SilentlyContinue

    return $secureBootStatus -and $null -ne $secureBootPk
}

Export-ModuleMember -Function CheckSecureBootStatus