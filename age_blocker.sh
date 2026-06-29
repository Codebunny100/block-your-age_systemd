#!/bin/bash
# ==============================================================================
# Script Name:        age-blocker.sh
# Installation Path:  /usr/local/bin/age-blocker.sh
# Description:        Low-overhead infinite loop engine. Enforces a static 
#                     1939-09-01 user profile baseline and monitors the process 
#                     tree to terminate unvetted telemetry trackers.
#
# DISCLAIMER: The author accepts absolutely no liability for any software 
# defects, account blocks, or statutory violations caused by executing this script.
# USE COMPLETELY AT YOUR OWN RISK.
# ==============================================================================

# Ensure the core loop engine runs with root-level system authority
if [ "$EUID" -ne 0 ]; then
    echo "[-] Execution Error: Administrative privileges required." >&2
    echo "[*] Fix: Run via sudo or authenticate as the root environment user." >&2
    exit 1
fi

# Dynamically intercept the real interactive user profile to target settings properly
TARGET_USER=$(logname || echo $SUDO_USER)
if [ -z "$TARGET_USER" ] || [ "$TARGET_USER" == "root" ]; then
    TARGET_USER=$(awk -F: '$3>=1000 {print $1; exit}' /etc/passwd)
fi

echo "[+] Initialization complete. Monitoring environment user: $TARGET_USER"
echo "[+] Enforcing continuous isolation placeholder: 1939-09-01"

# ------------------------------------------------------------------------------
# CORE INFINITE RUNTIME MONITORING LOOP
# ------------------------------------------------------------------------------
while true; do
    
    # SYSTEM LAYER: IDENTITY METADATA LOCKDOWN
    # Explicitly hooks systemd user records to lock data fields to the chosen epoch
    if command -v homectl >/dev/null 2>&1; then
        homectl update "$TARGET_USER" --birth-date=1939-09-01 >/dev/null 2>&1
    fi

    # KERNEL LAYER: RUNTIME PROCESS INTERCEPTION
    # Array matrix containing specific tracking binary titles slated for execution bans
    BLACKLISTED_TRACKERS=("age-checker" "intrusive-verify-daemon" "systemd-agecheck")

    for tracker_process in "${BLACKLISTED_TRACKERS[@]}"; do
        # Scan the live process map table for exact matching signatures
        if pgrep -x "$tracker_process" > /dev/null; then
            echo "[!] ALARM: Prohibited tracking software execution detected: $tracker_process"
            # Send immediate SIGKILL instruction to instantly close out the program
            pkill -9 -x "$tracker_process"
        fi
    done

    # HARDWARE LAYER: SPEED LIMITER & THROTTLE
    # Idles processing for exactly 5 seconds to guarantee near-zero CPU and memory footprint
    sleep 5
done
