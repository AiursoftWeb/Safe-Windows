function CheckAdministatorUserDisabled {
    $administatorUserDisabled = Get-LocalUser -Name "Administrator"
    return $administatorUserDisabled.Enabled -eq $false
}

Export-ModuleMember -Function CheckAdministatorUserDisabled