#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install curl if not already installed
echo "Installing curl..."
sudo apt install curl -y

# Add NodeSource repository for Node.js 22.x and install Node.js
echo "Adding NodeSource repository and installing Node.js 22.x..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify Node.js and npm installation
echo "Checking Node.js and npm versions..."
node_version=$(node -v)
npm_version=$(npm -v)

if [[ $node_version == *"v22."* ]]; then
  echo "Node.js installed successfully: $node_version"
else
  echo "Failed to install Node.js 22.x. Exiting..."
  exit 1
fi

if [[ $npm_version ]]; then
  echo "npm installed successfully: $npm_version"
else
  echo "Failed to install npm. Exiting..."
  exit 1
fi

# Install build-essential for native module compilation
echo "Installing build-essential..."
sudo apt install -y build-essential


npm install ## inside the same directory 

# Start the Vite development server with --host flag
echo "Starting Vite development server with --host..."
if npm run dev -- --host; then
  echo "Vite development server started successfully."
else
  echo "Failed to start Vite development server. Exiting..."
  exit 1
fi