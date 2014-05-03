#!/bin/bash

# Define colors and display introduction
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;36m'
purple='\e[0;35m'
nocolor='\e[0m'
bold=`tput bold`
normal=`tput sgr0`
echo -e "${blue}${bold}Network Reconnect is a utility designed to make managing wired and wireless connections easy. This extra package is provides additional functionality not present in the main package. You are currently using the installer.${normal}${nocolor}"

echo -e "${red}${bold}Sorry, but development of network-reconnect-extra has not yet started. We will commence work on this project after the release of v0.3 of the base package.${normal}${nocolor}"
