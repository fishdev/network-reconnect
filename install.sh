#!/bin/bash

# Import OS information
source /etc/lsb-release
source /etc/os-release

# Define colors and display introduction
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;36m'
purple='\e[0;35m'
nocolor='\e[0m'
bold=`tput bold`
normal=`tput sgr0`
echo -e "${blue}${bold}Network Reconnect is a utility designed to make managing wired and wireless network connections easy. It is not nearly complete or feature-complete, and only WEP and standard Ethernet are supported at this time. You are currently using the installer.${normal}${nocolor}"

# Get distribution
distribution=$DISTRIB_ID
if [ -z "$distribution" ]
then
  distribution=$(uname -s)
  echo -e "${red}${bold}You are using $distribution, but dependencies cannot be automatically installed on your distribution. Please make sure that you have the following packages installed and run the installer with the --force flag.${normal}${nocolor}"
fi
if [ "$ID_LIKE" == "ubuntu" ]
then
  distribution="Ubuntu"
fi

# Install dependency packages
echo -e "${purple}${bold}Now installing dependencies for network-reconnect...${normal}${nocolor}"
echo -e "$(red}${bold}"
if [ "$distribution" == "Ubuntu" ]
then
  sudo apt-get install --yes --force-yes iproute2 coreutils pciutils grep iputils-ping iw > /dev/null
fi
echo -e "${normal}${nocolor}"

# Move binaries into filesystem
echo -e "${purple}${bold}Now installing dependencies for network-reconnect...${normal}${nocolor}"
echo -e "$(red}${bold}"
sudo mv src/network-checker src/network-reconnect src/network-reconnect src/network-reconnect-cli src/network-reconnect-gui /usr/bin/
sudo mv src/network-reconnect.desktop /usr/share/applications/
sudo mv src/network-reconnect.png /usr/share/pixmaps/
echo -e "${normal}${nocolor}"

# Display success message
echo -e "${green}${bold}All done! You're ready to use network-reconnect. Type 'network-reconnect-cli --help' for more information.${normal}${nocolor}"
