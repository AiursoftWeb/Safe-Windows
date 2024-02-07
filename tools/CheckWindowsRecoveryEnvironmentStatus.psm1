function CheckWindowsRecoveryEnvironmentStatus {
    return ($(ReAgentc.exe /info) -match "Enabled").count -gt 0
}

Export-ModuleMember -Function CheckWindowsRecoveryEnvironmentStatus
