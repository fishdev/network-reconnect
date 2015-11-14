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
echo -e "${blue}${bold}Network Reconnect is a utility designed to make managing wired and wireless connections easy. It is not nearly complete or feature-complete, and only WEP, WPA, WPA2, and standard Ethernet are supported at this time. You are currently using the installer.${normal}${nocolor}"

# Get distribution
distribution=`grep DISTRIB_ID < /etc/lsb-release | cut -d = -f 2`
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
  echo -e "${red}wpa_supplicant${nocolor}"
  echo -e "${red}${bold}If you cannot install these packages, your distribution might be completely unsupported.${normal}${nocolor}"
  exit
fi
if [ "$ID_LIKE" == "ubuntu" ]
then
  distribution="Ubuntu"
fi

# Install dependency packages
echo -e "${purple}${bold}Now installing dependencies for network-reconnect...${normal}${nocolor}"
if [ "$distribution" == "Ubuntu" ]
then
  sudo apt-get install --yes --force-yes iproute2 coreutils pciutils grep iputils-ping iw wpa_supplicant > /dev/null
  if [ -z $(sudo dpkg-query -l "iproute2") ] || [ -z $(sudo dpkg-query -l "coreutils") ] || [ -z $(sudo dpkg-query -l "pciutils") ] || [ -z $(sudo dpkg-query -l "grep") ] || [ -z $(sudo dpkg-query -l "iputils-ping") ] || [ -z $(sudo dpkg-query -l "iw") ] || [ -z $(sudo dpkg-query -l "wpa_supplicant") ]
  then
    echo -e "The required dependencies could not be installed. Perhaps you are not connected to the Internet or your system has conflicting programs installed.${normal}${nocolor}"
    exit
  fi
fi
if [ "$distribution" == "Fedora" ] || [ "$distribution" == "CentOS" ]
then
  sudo yum install iproute coreutils pciutils grep iputils iw wpa_supplicant
  if [ -z $(rpm -qa | grep -w "iproute") ] || [ -z $(rpm -qa | grep -w "coreutils") ] || [ -z $(rpm -qa | grep -w "pciutils") ] || [ -z $(rpm -qa | grep -w "grep") ] || [ -z $(rpm -qa | grep -w "iputils") ] || [ -z $(rpm -qa | grep -w "iw") ] || [ -z $(rpm -qa | grep -w "wpa_supplicant") ]
  then
    echo -e "The required dependencies could not be installed. Perhaps you are not connected to the Internet or your system has conflicting programs installed.${normal}${nocolor}"
    exit
  fi
fi
if [ "$distribution" == "Arch" ]
then
  sudo pacman -S iproute2 coreutils pciutils grep iputils iw wpa_supplicant
  if [[ -z $(pacman -Q iproute2) ]] || [[ -z $(pacman -Q coreutils) ]] || [[ -z $(pacman -Q pciutils) ]] || [[ -z $(pacman -Q grep) ]] || [[ -z $(pacman -Q iputils) ]] || [[ -z $(pacman -Q iw) ]] || [[ -z $(pacman -Q wpa_supplicant) ]]
  then
    echo -e "The required dependencies could not be installed. Perhaps you are not connected to the Internet or your system has conflicting programs installed.${normal}${nocolor}"
    exit
  fi
fi
# Move binaries into filesystem
echo -e "${purple}${bold}Now copying files to your system...${normal}${nocolor}"
sudo cp src/network-checker src/network-reconnect src/network-reconnect-cli src/network-reconnect-gui /usr/bin/
sudo cp src/network-reconnect.desktop /usr/share/applications/
sudo cp src/network-reconnect.png /usr/share/pixmaps/
if [[ -z $(ls /usr/bin/ | grep -w "network-checker") ]] || [[ -z $(ls /usr/bin/ | grep -w "network-reconnect") ]] || [[ -z $(ls /usr/bin/ | grep -w "network-reconnect-cli") ]] || [[ -z $(ls /usr/bin/ | grep -w "network-reconnect-gui") ]] || [[ -z $(ls /usr/share/applications/ | grep -w "network-reconnect.desktop") ]] || [[ -z $(ls /usr/share/pixmaps | grep -w "network-reconnect.png") ]]
then
  echo -e "The network-reconnect files could not be copied. Please make sure that you can write to your filesystem, or copy the files manually.${normal}${nocolor}"
  exit
else
  # Display success message
  echo -e "${green}${bold}All done! You're ready to use network-reconnect. Type 'network-reconnect-cli --help' for more information.${normal}${nocolor}"
  echo -e "${purple}${bold}Please disable all other network managers before using network-reconnect. Multiple network managers trying to access the same resources can cause issues!"
fi

