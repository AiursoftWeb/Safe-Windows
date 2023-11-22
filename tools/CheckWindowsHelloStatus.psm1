
function CheckWindowsHelloStatus {
    $loggedOnUserSID = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value
    $credentialProvider = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{D6886603-9D2F-4EB2-B667-1971041FA96B}"
    if (Test-Path -Path $credentialProvider) {
        $userSIDs = Get-ChildItem -Path $credentialProvider
        $items = $userSIDs | Foreach-Object { Get-ItemProperty $_.PsPath }
    }
    else {
        return $false
    }
    if (-NOT[string]::IsNullOrEmpty($loggedOnUserSID)) {
        # If multiple SID's are found in registry, look for the SID belonging to the logged on user
        if ($items.GetType().IsArray) {
            # LogonCredsAvailable needs to be set to 1, indicating that the credential provider is in use
            if ($items.Where({ $_.PSChildName -eq $loggedOnUserSID }).LogonCredsAvailable -eq 1) {
                return $true                
            }
            # If LogonCredsAvailable is not set to 1, this will indicate that the PIN credential provider is not in use
            elseif ($items.Where({ $_.PSChildName -eq $loggedOnUserSID }).LogonCredsAvailable -ne 1) {
                return $false
            }
            else {
                return $false
            }
        }
        # Looking for the SID belonging to the logged on user is slightly different if there's not mulitple SIDs found in registry
        else {
            if (($items.PSChildName -eq $loggedOnUserSID) -AND ($items.LogonCredsAvailable -eq 1)) {
                return $true
            }
            elseif (($items.PSChildName -eq $loggedOnUserSID) -AND ($items.LogonCredsAvailable -ne 1)) {
                return $false
            }
            else {
                return $false
            }
        }
    }
    else {
        return $false
    }
}

Export-ModuleMember -Function CheckWindowsHelloStatus
