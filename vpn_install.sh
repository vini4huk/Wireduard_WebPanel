#!/bin/bash

# Update package list
sudo apt update -y && sudo apt upgrade -y

# Install required packages
sudo apt install -y ca-certificates curl gnupg apt-transport-https

# Add the official Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the official Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
sudo apt update -y

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Enable and check Docker status
sudo systemctl enable --now docker
sudo systemctl status docker --no-pager

# Add current user to the docker group
sudo usermod -aG docker $USER

# Get external IP address
HOST_IP=$(curl -s ifconfig.me)

# Prompt user for WG-Easy password
read -sp "Enter password for WG-Easy: " WG_PASSWORD
echo "\nInstalling and starting WG-Easy..."

# Run WG-Easy container
docker run -d \
  --name=wg-easy \
  -e WG_HOST=$HOST_IP \
  -e PASSWORD=$WG_PASSWORD \
  -v ~/.wg-easy:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped \
  weejewel/wg-easy

# Output completion message
echo "Docker and WG-Easy have been successfully installed!"

echo "\nLogin details:"
echo "Host: $HOST_IP:51821"
echo "Password: $WG_PASSWORD"
