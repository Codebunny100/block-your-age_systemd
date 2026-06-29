#!/bin/bash
# ==============================================================================
# Script Name:  install.sh
# Description:  Automated install script to deploy files, authorize file paths,
#               configure service records, and enable startup hooks.
# ==============================================================================

# Force immediate script termination if any unexpected file error triggers
set -e

echo "======================================================================"
echo "          AGE BLOCKER DAEMON AUTOMATED SYSTEM SETUP WIZARD            "
echo "======================================================================"
echo "⚠️  LIABILITY NOTICE: This tool is provided for privacy research only."
echo "The author holds ZERO liability for account bans or legal repercussions."
echo "======================================================================"

# Confirm administrative environment permissions before starting file adjustments
if [ "$EUID" -ne 0 ]; then
    echo "[-] Error: Administrative root privileges are required for setup." >&2
    echo "[*] Action: Re-run this installation command utilizing: sudo ./install.sh" >&2
    exit 1
fi

# STEP 1: Deploy Core Loop Engine
echo "[*] Step 1/4: Relocating loop daemon binary to /usr/local/bin/..."
cp age-blocker.sh /usr/local/bin/age-blocker.sh
# Restrict read, write, and execute authority strictly to the administrator account
chmod 700 /usr/local/bin/age-blocker.sh
echo "[+] Done: Main script binary placed and secured."

# STEP 2: Deploy System Initialization Record
echo "[*] Step 2/4: Transferring startup configuration profile to system paths..."
cp age-blocker.service /etc/systemd/system/age-blocker.service
# Set service configurations to universally readable non-executable system defaults
chmod 644 /etc/systemd/system/age-blocker.service
echo "[+] Done: Systemd profile mapped."

# STEP 3: Register Service to Run on Startup
echo "[*] Step 3/4: Refreshing internal core system initialization tables..."
systemctl daemon-reload
# Register the service configuration to automatically launch when the computer starts up
systemctl enable age-blocker.service
echo "[+] Done: Service integrated into permanent system boot routine."

# STEP 4: Activate Protection Immediately
echo "[*] Step 4/4: Activating live protection loop engines..."
systemctl start age-blocker.service
echo "======================================================================"
echo "[+] SUCCESS: The Age Blocker Daemon is fully installed."
echo "[+] Operational Status: Running silently in the background and locked onto startup."
echo "[*] Run 'sudo systemctl status age-blocker.service' to review live operations."
echo "======================================================================"
