# Age Blocker Daemon

A lightweight, continuous background utility for Linux (optimized for Debian) designed to guard user privacy by neutralizing operating-system-level age tracking, account data accumulation, and background verification telemetry.

---

## Technical Mechanics & How It Works

The project enforces a **Dual-Layer Privacy Defense** to ensure your local workstation never leaks real age metrics to applications, containers, or web APIs:

1. **Persistent Metadata Spoofing**: The engine constantly interacts with the local Linux user profile layer (`systemd-userdb` / `homectl`). Every 5 seconds, it overwrites the system's local account birthdate property with an explicit, unalterable historical baseline: **September 1, 1939**. This feeds privacy-vetted generic data to any program sniffing local system variables.
2. **Proactive Process Interception**: The daemon actively profiles the active operating system process tree. If a known compliance tracker, intrusive verification prompt, or telemetry daemon initializes in memory, the script executes an immediate `SIGKILL` (9) instruction to crash and terminate the offending program before it can fetch network packets.

---

## File Structure & Contents

This repository contains the following structural components:
* **`README.md`**: Comprehensive architectural manuals, installation pathways, and validation guides.
* **`age-blocker.sh`**: The core runtime engine running a resource-optimized monitoring loop.
* **`age-blocker.service`**: A configuration configuration block enabling automatic startup during the boot sequence.
* **`install.sh`**: A quick deployment automated script to automatically align file permissions and launch the engine.

---

## ⚠️ Legal Notice, Scope & Compliance Guidelines

Before installing or publishing this utility, you must understand the legal parameters regarding local hardware ownership vs. active access control. 

### 🟢 Where It Is Legal To Use (Data Privacy & Device Ownership)
* **Local Machine Configuration**: Under standard property law and free software licenses (like the GNU GPL), you have an absolute legal right to modify, write to, delete, or spoof any metadata stored on a computer you physically own. 
* **Regulatory Exemptions**: Emerging data laws like California's Digital Age Assurance Act (AB 1856) place compliance mandates on *commercial operating system providers* (e.g., Apple, Microsoft), not individual end-users. Furthermore, open-source operating systems are explicitly exempt from forcing these data-collection interfaces.
* **General Web Browsing**: Using a proxy script to supply a generic adult birthdate placeholder to protect your online privacy fingerprint is entirely legal.

### 🟡 Where It Violates Terms of Service (Civil Contracts)
* **Private Platform Rules**: Supplying a placeholder date like 1939 to commercial web applications (such as YouTube, online marketplaces, or social networks) when creating or validating accounts violates the platform's Terms of Service (ToS). While **not a criminal offense**, discovery will result in civil remedies, including permanent account bans or IP blocks.

### 🔴 Where It Becomes Illegal To Use (Statutory Violations)
* **Bypassing Controlled Substance Restrictions**: Using this script to misrepresent your age to purchase regulated real-world products online—such as alcohol, tobacco, cannabis, or firearms—constitutes fraud or identity misrepresentation under federal and state statutes.
* **Accessing Restricted Material by Minors**: If this tool is deployed on a machine used by a minor to bypass age gates for adult-only content, it may violate regional child online protection statutes. It is illegal to use this daemon to facilitate unauthorized access to age-restricted web content for individuals under the legal age limit.
* **Corporate Environment Audits**: Deploying this on university or enterprise workstations to actively mask asset tracking variables may violate company policies and local digital trespassing laws.
## ⚖️ DISCLAIMER & LIMITATION OF LIABILITY
**PLEASE READ CAREFULLY BEFORE USING OR DISTRIBUTING THIS SOFTWARE.**

This software is provided "as is" for privacy-preservation research and educational purposes only. 

* **No Liability**: The author and project contributors accept absolutely NO responsibility or liability for any consequences, legal actions, account bans, financial losses, data corruption, or hardware damage resulting from the use, modification, installation, or distribution of this software.
* **User Responsibility**: By executing this script, you acknowledge that you are using it entirely at your own risk. You are solely responsible for ensuring compliance with all local, state, federal, and international laws, as well as any private third-party Terms of Service (ToS) agreements.

---
---

## Automated Quick-Start Installation

### 1. Clone this Repository
Download these files to your local Linux workstation terminal using git:
```bash
git clone https://github.com
cd age-blocker-daemon
```

### 2. Run the Installer Wizard
Grant execution rights to the deployment wizard and run it with administrative privileges:
```bash
chmod +x install.sh
sudo ./install.sh
```

---

## Post-Deployment Verification

### 1. Check Boot Startup Status
To verify that the continuous background guard successfully launched during the computer's startup phase and is running healthily, query its status:
```bash
sudo systemctl status age-blocker.service
```

### 2. Audit the User Profile Registry
To prove that your machine is actively masking your identity to local applications, run a database diagnostic query:
```bash
userdbctl user \$USER | grep -i "birthDate"
```
*Expected Output: `birthDate: 1939-09-01`*

---

## Customizing the App Interception Blacklist

To append a newly discovered tracking program or background telemetry package to the automatic kill-loop, modify the installed runtime binary file:
```bash
sudo nano /usr/local/bin/age-blocker.sh
```
Find the `BLACKLISTED_TRACKERS` line configuration block and inject the exact application process string name into the array:
```bash
BLACKLISTED_TRACKERS=("age-checker" "intrusive-verify-daemon" "the-target-process-name")
```

---

## License
This application is distributed under the open-source guidelines of the [MIT License](LICENSE).
