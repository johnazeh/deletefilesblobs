



# Set the storage account name and container name
$storageAccountName = "storbackcc"
$containerName = "contstorcc"

# Set the storage context
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -UseConnectedAccount

# List all blobs in the container
$blobs = Get-AzStorageBlob -Container $containerName -Context $storageContext


# Define the threshold date for deleting old backups (e.g., older than 30 days)
$thresholdDate = Get-Date



# Filter out blobs older than the threshold date
$oldBackups = $blobs | Where-Object { $thresholdDate }

# Delete the old backup files
foreach ($backup in $oldBackups) {
    Remove-AzStorageBlob -Blob $backup.Name -Container $containerName -Context $storageContext -Force
    Write-Host "Deleted $($backup.Name)"
}