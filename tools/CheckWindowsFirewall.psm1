function CheckWindowsFirewall {
    $public = Get-NetFirewallProfile -Name Public
    $private = Get-NetFirewallProfile -Name Private
    $domain = Get-NetFirewallProfile -Name Domain
    return `
        $public.Enabled -and ($public.NotifyOnListen -or $public.DefaultInboundAction -eq 'Block') -and`
        $private.Enabled -and ($private.NotifyOnListen -or $private.DefaultInboundAction -eq 'Block') -and`
        $domain.Enabled -and ($domain.NotifyOnListen -or $domain.DefaultInboundAction -eq 'Block')
}

Export-ModuleMember -Function CheckWindowsFirewall