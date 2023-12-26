function CheckWinload {
    $bcdeditCurrent = bcdedit /enum "{current}" | Select-String "winload.efi"
    return $null -ne $bcdeditCurrent
}

Export-ModuleMember -Function CheckWinload