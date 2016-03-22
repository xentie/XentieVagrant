#!/usr/bin/env bash
# This bootstraps Puppet on vagrant-ubuntu-trusty-64 3.13.0-83-generic
# It has been tested on vagrant-ubuntu-trusty-64 3.13.0-83-generic

set -e

# REPO_URL="http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-6.noarch.rpm"

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Prepare Vagrant for Discourse
# source: https://www.vultr.com/docs/how-to-install-discourse-on-ubuntu-14-04
echo "Preparing Server for Discourse..."
# Create an empty swap file
sudo install -o root -g root -m 0600 /dev/null /swapfile
# Write out a 1GB file named
sudo dd if=/dev/zero of=/swapfile bs=1k count=2048k
# Tell Linux that this is the swap file
sudo mkswap /swapfile
# Activate it
sudo swapon /swapfile
# Add it to the system table so that it is available after reboot:
sudo echo "/swapfile swap swap auto 0 0" | sudo tee -a /etc/fstab
# Set the "swappiness" so that it is only used as an emergency buffer
sudo sysctl -w vm.swappiness=10
echo "New Swap File Installed!"
echo "Checking out if Puppet is installed..."

# Prepare Vagrant for Puppet if not already installed

if which puppet > /dev/null 2>&1; then
  echo "Puppet Version:  `puppet -V` Installed!"
  exit 0
fi

# Install puppet labs repo
echo "Preparing Server for PuppetLabs..."
cd /tmp
sudo wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update -y


# Install Puppet...
echo "Installing puppet"
sudo apt-get install puppetmaster -y
echo "Puppet Version:  `puppet -V` Installed!"

