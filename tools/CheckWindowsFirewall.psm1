function CheckWindowsFirewall {
    $public = Get-NetFirewallProfile -Name Public
    $private = Get-NetFirewallProfile -Name Private
    $domain = Get-NetFirewallProfile -Name Domain
    return `
        $public.Enabled -and $public.NotifyOnListen -and`
        $private.Enabled -and $private.NotifyOnListen -and`
        $domain.Enabled -and $domain.NotifyOnListen
}