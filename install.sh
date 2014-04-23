#!/bin/bash

source /etc/lsb-release
source /etc/os-release

red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;36m'
purple='\e[0;35m'
nocolor='\e[0m'
bold=`tput bold`
normal=`tput sgr0`
echo -e "${blue}${bold}Network Reconnect is a utility designed to make managing wired and wireless network connections easy. It is not nearly complete or feature-complete, and only WEP and standard Ethernet are supported at this time. You are currently using the CLI (Command-Line Interface).${normal}${nocolor}"

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
