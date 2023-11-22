function CheckUACEnabled {
    $consentPromptBehaviorAdmin = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\" -Name "ConsentPromptBehaviorAdmin"
    $promptOnSecureDesktop = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\" -Name "PromptOnSecureDesktop"
    return ($consentPromptBehaviorAdmin.ConsentPromptBehaviorAdmin -eq 5 -or $consentPromptBehaviorAdmin.ConsentPromptBehaviorAdmin -eq 2) `
        -and $promptOnSecureDesktop.PromptOnSecureDesktop -eq 1
}

Export-ModuleMember -Function CheckUACEnabled