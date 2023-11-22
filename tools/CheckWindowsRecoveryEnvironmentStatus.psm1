function CheckWindowsRecoveryEnvironmentStatus {
    return ($(ReAgentc.exe /info) -match "Windows RE status:         Enabled").count -gt 0
}

Export-ModuleMember -Function CheckWindowsRecoveryEnvironmentStatus