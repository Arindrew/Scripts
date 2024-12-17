#!/bin/bash

FirewallConfig="/etc/firewalld/firewalld.conf"
NessusRuleFile="/mnt/NAS/DalimUsers/Admin/nessus.xml"
NessusConfigFile="/etc/firewalld/services/nessus.xml"

#Define colors for stdout
function colors_stdout()
{
RED='\033[0;031m'
LRED='\033[1;031m'
GREEN='\033[0;032m'
NC='\033[0m'
}

if [[ $EUID == 0 ]]; then

  # If ZoneDrifting is turned on, turn off.
  for i in {1..80}; do
    echo -n "-"
  done
  echo ""
  echo -n "Checking 'AllowZoneDrifting' status..."
  allowZoneDrifting=$(grep AllowZoneDrifting= $FirewallConfig | cut -d "=" -f2)
  if [[ $allowZoneDrifting == "yes" ]]; then
    echo -e "${RED} On. Changing to off ${NC}"
    sed -i s/AllowZoneDrifting=yes/AllowZoneDrifting=no/g $FirewallConfig
  else
    echo -e "${GREEN} Off ${NC}"
  fi

  # If firewalld service is stopped, start it.
  echo -n "Checking the firewalld service..."
  if ! systemctl is-active firewalld --quiet; then
    echo -e "${RED} not started. ${NC} Attempting to start..."
    if systemctl start firewalld; then
      echo "${GREEN} Started ${NC}."
    else
      echo -ne "Stopped. ${RED} Exiting. {$NC}." && exit
    fi
  else
    echo -ne "${GREEN} Started ${NC}"
  fi

  # If firewalld service is disabled, enable it.
  if systemctl is-enabled firewalld --quiet; then
    echo -e "and ${GREEN}Enabled ${NC}"
  else
    # Enable the firewall to start at bootup
    if systemctl --quiet enable firewalld; then
      echo -e "and ${GREEN} Enabled {$NC}"
    else
      echo -e "${RED}disabled.${NC} Exiting." && exit
    fi
  fi

  # Add rule allowing remote Nessus host to remotely interact with this client
  echo -n "Checking Nessus rule..."
  if [ -f $NessusConfigFile ]; then
    echo -e "${GREEN} File already exists. ${NC}"
  else
    echo -e "${GREEN} Adding file ${NC}"
    echo -n "Adding Nessus Service Rule..."
    if firewall-cmd --quiet --permanent --new-service-from-file=$NessusRuleFile --name=nessus; then
      echo -e "${GREEN} Success ${NC}"
    else
      echo -e "{$RED} Failure ${NC}" && exit
    fi
    echo -n "Enabling Service Rule..."
    if firewall-cmd --quiet --permanent --zone=public --add-service=nessus; then
      echo -e "${GREEN} Success ${NC}"
    else
      echo -e "${RED} Failure ${NC}" && exit
    fi
  fi

  # Reload firewalld service to enable rules
  if firewall-cmd --reload --quiet; then
    echo ""
    echo "The firewalld service has been reloaded in order to apply Nessus rules"
  else
    echo -e "${RED} Firewall failed to reload.${NC}" && exit
  fi

  # Listing enabled services
  echo -n "Services currently active..."
  ActiveServices=$(firewall-cmd --list-services)
  echo -e "${GREEN} $ActiveServices ${NC}"

  # Print final systemctl status
  echo -e "\n"
  systemctl --lines=0 status firewalld
  for i in {1..80}; do
    echo -n "-"
  done
  echo ""
else
  echo -e "${LRED}You must be root to run this script${NC}"
fi

colors_stdout
