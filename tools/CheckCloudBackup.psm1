function CheckCloudBackup {
    $validBackupFilders = @(
        "OneDrive",
        "Dropbox",
        "Google Drive",
        "iCloud Drive",
        "Nextcloud",
        "Adobe Creative Cloud",
        "OwnCloud"
    )

    $hasBackupFolderUnderUser = Get-ChildItem -Path $env:USERPROFILE -Directory | Where-Object { $validBackupFilders -contains $_.Name }

    return $null -ne $hasBackupFolderUnderUser
}
