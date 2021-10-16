#!/usr/bin/env bash

# Install basic software
sudo apt install vim -y
sudo apt install git -y

# Define git basic aliases

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
# git config --global alias.l1 'log --oneline'
git config --global alias.l1 'log --oneline --pretty="format: %h | %s (%aN, %cr)"'

# VS Code

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y

# Brave Browser
# Reference: https://brave.com/linux/

sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

# Docker CE
# Remove older installations, if they exists
sudo apt-get remove docker docker-engine docker.io containerd runc
# Install packages
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    -y
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add stable repository
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
# Install Docker engine (Community Edition)
sudo apt update
sudo apt install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    -y

# Allow unprivileged user to execute Docker commands
sudo groupadd docker
sudo usermod -aG docker $USER

# Autostart Docker on boot
sudo systemctl enable docker
sudo systemctl start docker
