#!/bin/bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v && npm -v

# Install Linux packages
sudo dpkg -i linux-*.deb
rm -rf linux-*.deb

# Set non-interactive mode to prevent prompts
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

# Pre-configure debconf to avoid kernel upgrade prompts
echo 'libc6 libraries/restart-without-asking boolean true' | sudo debconf-set-selections
echo 'libssl3:amd64 libraries/restart-without-asking boolean true' | sudo debconf-set-selections


# Install Nvidia driver
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
# Add DEBIAN_FRONTEND=noninteractive to the dpkg and apt-get commands
sudo DEBIAN_FRONTEND=noninteractive dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends -o Dpkg::Options::="--force-confnew" cuda-toolkit-12-4
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends -o Dpkg::Options::="--force-confnew" nvidia-driver-550-server-open

# Disable multipathd service and shutdown
sudo systemctl disable multipathd.service
sudo shutdown now 

