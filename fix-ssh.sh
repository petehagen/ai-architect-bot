#!/bin/bash

echo "Starting SSH Debugging Script..."

# Ensure SSH is installed and enabled
echo "Checking SSH service..."
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl restart ssh

# Verify firewall rules
echo "Updating firewall rules..."
sudo ufw allow OpenSSH
sudo ufw reload
sudo ufw enable

# Ensure correct SSH permissions
echo "Fixing SSH permissions..."
sudo chmod 700 ~/.ssh
sudo chmod 600 ~/.ssh/authorized_keys
sudo chown -R $(whoami):$(whoami) ~/.ssh

# Restart SSH again
echo "Restarting SSH..."
sudo systemctl restart ssh

# Check if SSH is listening on port 22
echo "Checking SSH status..."
sudo ss -tulpn | grep ssh

# Display last 20 SSH logs for debugging
echo "Fetching latest SSH logs..."
sudo journalctl -u ssh --no-pager | tail -n 20

echo "Script execution completed. If issues persist, check logs above."
