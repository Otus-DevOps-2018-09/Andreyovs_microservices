#/bin/bash
RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED} run with sudo"
echo -e "${RED} run sudo apt install bridge-utils for brctl install${NC}"

pkill docker
iptables -t nat -F
ifconfig docker0 down
brctl delbr docker0
service docker restart
