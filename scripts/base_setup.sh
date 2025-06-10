#!/bin/bash

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v && npm -v

# Install Linux packages
sudo dpkg -i linux-*.deb
rm -rf linux-*.deb


# Install Nvidia driver
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
# sudo dpkg -i cuda-keyring_1.1-1_all.deb
# sudo apt-get update
# sudo apt-get -y install cuda-toolkit-12-4
# sudo apt install nvidia-driver-550-server-open

# Disable multipathd service and shutdown
sudo systemctl disable multipathd.service
sudo shutdown now 

