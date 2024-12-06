function CheckSystemDiskPartitionStyle {
    try {
        $systemDriveLetter = ($env:SystemDrive).Substring(0,1)
        $partition = Get-Partition -DriveLetter $systemDriveLetter -ErrorAction Stop
        $diskNumber = $partition.DiskNumber
        $disk = Get-Disk -Number $diskNumber -ErrorAction Stop
        if ($disk.PartitionStyle -eq 'GPT') {
            return $true
        }
        else {
            return $false
        }
    }
    catch {
        Write-Error "Failed to check system disk partition style: $_"
        return $false
    }
}

Export-ModuleMember -Function CheckSystemDiskPartitionStyle