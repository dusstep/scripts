#!/bin/bash

# Log file
LOG_FILE="/var/log/backup_script.log"

# Function to perform backup
backup() {
    local source_dir="$1"
    local dest_dir="$2"

    echo "Starting backup from $source_dir to $dest_dir on $(date)" >> "$LOG_FILE"
    cp -r -n "$source_dir"/* "$dest_dir" >> "$LOG_FILE" 2>&1
    echo "Backup from $source_dir completed on $(date)" >> "$LOG_FILE"
}

# Define source and destination directories
declare -A backup_paths=(
    ["/docker/appdata/prowlarr/Backups"]="/mnt/bkup/config-bkup/prowlarr"
    ["/docker/appdata/radarr/Backups"]="/mnt/bkup/config-bkup/radarr"
    ["/docker/appdata/sonarr/Backups"]="/mnt/bkup/config-bkup/sonarr"
    ["/docker/appdata/sabnzbd/backup"]="/mnt/bkup/config-bkup/sabnzbd"
)

# Loop through paths and perform backups
for source_dir in "${!backup_paths[@]}"; do
    dest_dir="${backup_paths[$source_dir]}"
    backup "$source_dir" "$dest_dir"
done

echo "All backups completed on $(date)" >> "$LOG_FILE"

