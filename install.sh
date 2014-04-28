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
echo -e "${blue}${bold}Network Reconnect is a utility designed to make managing wired and wireless connections easy. It is not nearly complete or feature-complete, and only WEP and standard Ethernet are supported at this time. You are currently using the installer.${normal}${nocolor}"

# Get distribution
distribution=$DISTRIB_ID
if [ -z "$distribution" ]
then
  distribution=$(uname -s)
  echo -e "${red}${bold}You are using $distribution, but dependencies cannot be automatically installed on your distribution. Please make sure that you have the following packages installed and run the installer with the --force flag.${normal}${nocolor}"
  echo -e "${red}iproute${nocolor}"
  echo -e "${red}coreutils${nocolor}"
  echo -e "${red}lspci${nocolor}"
  echo -e "${red}grep${nocolor}"
  echo -e "${red}ping${nocolor}"
  echo -e "${red}iw${nocolor}"
  echo -e "${red}${bold}If you cannot install these packages, your distribution might be completely unsupported.${normal}${nocolor}"
  exit
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
  if [ -z $(sudo dpkg-query -l "iproute2") ] || [ -z $(sudo dpkg-query -l "coreutils") ] || [ -z $(sudo dpkg-query -l "pciutils") ] || [ -z $(sudo dpkg-query -l "grep") ] || [ -z $(sudo dpkg-query -l "iputils-ping") ] || [ -z $(sudo dpkg-query -l "iw") ]
  then
    echo -e "The required dependencies could not be installed. Perhaps you are not connected to the Internet or your system has conflicting programs installed.${normal}${nocolor}"
    exit
  fi
fi
if [ "$distribution" == "Fedora" ]
then
  sudo yum install iproute coreutils pciutils grep iputils iw
  if [ -z ${rpm -qa | grep -w "iproute" ] || [ -z ${rpm -qa | grep -w "coreutils" ] || [ -z ${rpm -qa | grep -w "pciutils" ] || [ -z ${rpm -qa | grep -w "grep" ] || [ -z ${rpm -qa | grep -w "iputils" ] || [ -z ${rpm -qa | grep -w "iw" ]
  then
    echo -e "The required dependencies could not be installed. Perhaps you are not connected to the Internet or your system has conflicting programs installed.${normal}${nocolor}"
    exit
  fi
fi
echo -e "${normal}${nocolor}"

# Move binaries into filesystem
echo -e "${purple}${bold}Now copying files to your system...${normal}${nocolor}"
echo -e "$(red}${bold}"
sudo mv src/network-checker src/network-reconnect src/network-reconnect src/network-reconnect-cli src/network-reconnect-gui /usr/bin/
sudo mv src/network-reconnect.desktop /usr/share/applications/
sudo mv src/network-reconnect.png /usr/share/pixmaps/
if [ -z $(ls /usr/bin/ | grep -w "network-checker") ] || [ -z $(ls /usr/bin/ | grep -w "network-reconnect") ] || [ -z $(ls /usr/bin/ | grep -w "network-reconnect-cli") ] || [ -z $(ls /usr/bin/ | grep -w "network-reconnect-gui") ] || [ -z $(ls /usr/share/applications/ | grep -w "network-reconnect.desktop") ] || [ -z $(ls /usr/share/pixmaps | grep -w "network-reconnect.png") ]
then
  echo -e "The network-reconnect files could not be copied. Please make sure that you can write to your filesystem, or copy the files manually.${normal}${nocolor}"
  exit
echo -e "${normal}${nocolor}"

# Display success message
echo -e "${green}${bold}All done! You're ready to use network-reconnect. Type 'network-reconnect-cli --help' for more information.${normal}${nocolor}"
