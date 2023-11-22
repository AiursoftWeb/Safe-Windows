function CheckTpmStatus {
    $tpmStatus = Get-CimInstance -ClassName Win32_Tpm -Namespace root\cimv2\security\microsofttpm
    
    # 0 = The TPM is deactivated or disabled.
    # 1 = The TPM is activated and enabled.
    return $tpmStatus.IsActivated_InitialValue -eq 1 -and $tpmStatus.IsEnabled_InitialValue -eq 1 -and $tpmStatus.IsOwned_InitialValue -eq 1;
}

Export-ModuleMember -Function CheckTpmStatus