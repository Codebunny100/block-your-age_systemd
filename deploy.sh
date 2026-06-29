#!/bin/bash
# ==============================================================================
# Script Name:  deploy.sh
# Description:  Remote installer script meant to be piped via curl. 
#               Downloads, configures, and boots the Age Blocker system daemon.
# ==============================================================================
set -e

# Define variables for your specific GitHub repository
GH_USER="YOUR_GITHUB_USERNAME"
GH_REPO="age-blocker-daemon"
RAW_URL="https://githubusercontent.com{GH_USER}/${GH_REPO}/main"

echo "======================================================================"
echo "          AGE BLOCKER DAEMON REMOTE INSTALLER ENGINE                 "
echo "======================================================================"
echo "⚠️  DISCLAIMER: Installed entirely at user risk. Author holds no liability."
echo "======================================================================"

# Ensure the curl pipeline script is being executed with root/sudo authority
if [ "$EUID" -ne 0 ]; then
    echo "[-] Error: Administrative root privileges are required for deployment." >&2
    echo "[*] Action: Please execute using: curl -fsSL ... | sudo bash" >&2
    exit 1
fi

# Create a temporary sandboxed directory to pull file contents
TEMP_DIR=$(mktemp -d -t age-blocker-XXXXXXXXXX)
cd "$TEMP_DIR"

echo "[*] Fetching components from GitHub repository main branch..."

# 1. Download the core daemon execution script
echo "[*] Downloading background loop script..."
curl -fsSL "${RAW_URL}/age-blocker.sh" -o age-blocker.sh

# 2. Download the systemd startup service mapping block
echo "[*] Downloading system configuration block..."
curl -fsSL "${RAW_URL}/age-blocker.service" -o age-blocker.service

echo "[*] Deploying components to local root file structures..."

# 3. Migrate binary files and restrict access permissions
cp age-blocker.sh /usr/local/bin/age-blocker.sh
chmod 700 /usr/local/bin/age-blocker.sh

# 4. Migrate initialization configurations
cp age-blocker.service /etc/systemd/system/age-blocker.service
chmod 644 /etc/systemd/system/age-blocker.service

# 5. Flush systemd configurations and bind script loop to system startup
echo "[*] Configuring startup hooks and background execution modules..."
systemctl daemon-reload
systemctl enable age-blocker.service
systemctl start age-blocker.service

# 6. Purge temporary files out of local memory storage
rm -rf "$TEMP_DIR"

echo "======================================================================"
echo "[+] SUCCESS: The Age Blocker Daemon has been deployed via curl."
echo "[+] Operational Status: Active background loop running on boot startup."
echo "[*] Run 'sudo systemctl status age-blocker.service' to review live operations."
echo "======================================================================"
