#!/bin/bash

# ========================================================
# Author Information
# ========================================================
echo "========================================================"
echo "    🐦 Twitter: @vulnquest"
echo "    🐙 GitHub: github.com/vulnquest58"
echo "    💼 LinkedIn: linkedin.com/company/vulnquest"
echo "    💬 Discord: discord.gg/vulnquest"
echo "    🌐 Website: vulnquest.com"
echo "========================================================"

# Function to display success or failure messages
function status_message() {
    if [ $? -eq 0 ]; then
        echo "[✔] $1 completed successfully."
    else
        echo "[❌] $1 failed. Exiting..."
        exit 1
    fi
}

# Step 1: Update system packages
echo "[ℹ] Updating system packages..."
sudo apt update > /dev/null 2>&1 && sudo apt upgrade -y > /dev/null 2>&1 &
wait $!
status_message "System update"

# Step 2: Add Google's signing key
echo "[ℹ] Adding Google's signing key..."
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg > /dev/null 2>&1 &
wait $!
status_message "Google signing key addition"

# Step 3: Add Google Chrome repository
echo "[ℹ] Adding Google Chrome repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null 2>&1 &
wait $!
status_message "Google Chrome repository addition"

# Step 4: Update package list
echo "[ℹ] Updating package list..."
sudo apt update > /dev/null 2>&1 &
wait $!
status_message "Package list update"

# Step 5: Install Google Chrome
echo "[ℹ] Installing Google Chrome..."
sudo apt install google-chrome-stable -y > /dev/null 2>&1 &
wait $!
status_message "Google Chrome installation"

# Final check: Verify installation
if command -v google-chrome &> /dev/null; then
    echo "[🎉] Google Chrome has been successfully installed!"
    echo "You can launch it by typing 'google-chrome' in the terminal or from the application menu."
else
    echo "[❌] Failed to install Google Chrome. Please check the installation steps manually."
    exit 1
fi
