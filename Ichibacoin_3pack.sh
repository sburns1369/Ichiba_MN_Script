#!/bin/bash
#0.99-- NullEntryDev Script
NODESL=Eight
NODESN=8
BLUE='\033[0;96m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\033[0;93m'
CLEAR='\033[0m'
if [[ $(lsb_release -d) != *16.04* ]]; then
"echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}"
exit 1
fi
echo
echo
echo -e ${GREEN}"Are you sure you want to continue the installation of ${NODESL} IchibaCoin Masternodes?"
echo -e "type y/n followed by [ENTER]:"${CLEAR}
read AGREE
if [[ $AGREE =~ "y" ]] ; then
echo
echo
echo
echo
echo -e ${BLUE}"May this script will store a small amount data in /usr/local/nullentrydev/ ?"${CLEAR}
echo -e ${BLUE}"This information is for version updates and later implimentation"${CLEAR}
echo -e ${BLUE}"Zero Confidental information or Wallet keys will be stored in it"${CLEAR}
echo -e ${YELLOW}"Press y to agree followed by [ENTER], or just [ENTER] to disagree"${CLEAR}
read NULLREC
echo
echo -e ${GREEN}"Would you like to enter custom IP addresses?"${CLEAR}
echo -e ${YELLOW}"If you don't know the answer, hit n for no"${CLEAR}
echo -e ${YELLOW}"If you have custom IPs hit y for yes"${CLEAR}
read customIP
echo "Creating ${NODESN} IchibaCoin system user(s) with no-login access:"
if id "ichibacoin" >/dev/null 2>&1; then
echo "user exists"
MN1=1
else
sudo adduser --system --home /home/ichibacoin ichibacoin
MN1=0
fi
if id "ichibacoin2" >/dev/null 2>&1; then
echo -e ${YELLOW} "Found user ichibacoin2!"${CLEAR}
MN2=1
else
sudo adduser --system --home /home/ichibacoin2 ichibacoin2
MN2=0
fi
if id "ichibacoin3" >/dev/null 2>&1; then
echo -e ${YELLOW} "Found user ichibacoin3!"${CLEAR}
MN3=1
else
sudo adduser --system --home /home/ichibacoin3 ichibacoin3
MN3=0
fi
echo
echo
echo
echo
echo -e ${RED}"Your New Masternode Private Keys are needed,"${CLEAR}
echo -e ${GREEN}" -which can be generated from the local wallet"${CLEAR}
echo
echo -e ${YELLOW}"You can edit the config later if you don't have this"${CLEAR}
echo -e ${YELLOW}"Masternode may fail to start with invalid key"${CLEAR}
echo -e ${YELLOW}"And the script installation will hang and fail"${CLEAR}
echo
echo -e ${YELLOW}"Right Click to paste in some SSH Clients"${CLEAR}
echo
if [[ "$MN1" -eq "0" ]]; then
echo -e ${GREEN}"Please Enter Your First Masternode Private Key:"${CLEAR}
read MNKEY
echo
else
echo -e ${YELLOW}"Skipping First Masternode Key"${CLEAR}
fi
if [[ "$MN2" -eq "0" ]]; then
echo -e ${GREEN}"Please Enter Your Second Masternode Private Key:"${CLEAR}
read MNKEY2
echo
else
echo -e ${YELLOW}"Skipping Second Masternode Key"${CLEAR}
fi
if [[ "$MN3" -eq "0" ]]; then
echo -e ${GREEN}"Please Enter Your Third Masternode Private Key:"${CLEAR}
read MNKEY3
echo
else
echo -e ${YELLOW}"Skipping Third Masternode Key"${CLEAR}
fi
cd ~
if [[ $NULLREC = "y" ]] ; then
if [ ! -d /usr/local/nullentrydev/ ]; then
echo -e ${YELLOW}"Making /usr/local/nullentrydev"${CLEAR}
sudo mkdir /usr/local/nullentrydev
else
echo -e ${YELLOW}"Found /usr/local/nullentrydev"${CLEAR}
fi
if [ ! -f /usr/local/nullentrydev/ICA.log ]; then
echo -e ${YELLOW}"Making /usr/local/nullentrydev/ICA.log"${CLEAR}
sudo touch /usr/local/nullentrydev/ICA.log
else
echo -e ${YELLOW}"Found /usr/local/nullentrydev/ICA.log"${CLEAR}
fi
if [ ! -f /usr/local/nullentrydev/mnodes.log ]; then
echo -e ${YELLOW}"Making /usr/local/nullentrydev/mnodes.log"${CLEAR}
sudo touch /usr/local/nullentrydev/mnodes.log
else
echo -e ${YELLOW}"Found /usr/local/nullentrydev/mnodes.log"${CLEAR}
fi
fi
echo -e ${RED}"Updating Apps"${CLEAR}
sudo apt-get -y update
echo -e ${RED}"Upgrading Apps"${CLEAR}
sudo apt-get -y upgrade
if grep -Fxq "dependenciesInstalled: true" /usr/local/nullentrydev/mnodes.log
then
echo
echo -e ${RED}"Skipping... Dependencies & Software Libraries - Previously installed"${CLEAR}
echo
else
echo ${RED}"Installing Dependencies & Software Libraries"${CLEAR}
sudo apt-get -y install software-properties-common
sudo apt-get -y install build-essential
sudo apt-get -y install libtool autotools-dev autoconf automake
sudo apt-get -y install libssl-dev
sudo apt-get -y install libevent-dev
sudo apt-get -y install libboost-all-dev
sudo apt-get -y install pkg-config
echo -e ${RED}"Press [ENTER] if prompted"${CLEAR}
sudo add-apt-repository -yu ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get -y install libdb4.8-dev
sudo apt-get -y install libdb4.8++-dev
echo -e ${YELLOW} "Here be dragons"${CLEAR}
sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5
sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
sudo apt-get -y install libqrencode-dev bsdmainutils unzip
if [[ $NULLREC = "y" ]] ; then
echo "dependenciesInstalled: true" >> /usr/local/nullentrydev/mnodes.log
fi
fi
if [[ customIP = "y" ]] ; then
echo -e ${GREEN}"IP for Masternode 1"${CLEAR}
read MNIP1
echo -e ${GREEN}"IP for Masternode 2"${CLEAR}
read MNIP2
echo -e ${GREEN}"IP for Masternode 3"${CLEAR}
read MNIP3
else
regex='^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$'
FINDIP=$(hostname -I | cut -f2 -d' '| cut -f1-7 -d:)
if [[ $FINDIP =~ $regex ]]; then
echo "IPv6 Address check is good"
echo ${FINDIP} testing note
IP=${FINDIP}
echo ${IP}
else
echo "IPv6 Address check is not expected, getting IPv6 Helper to recalculate"
echo $FINDIP - testing note 1
sudo apt-get install sipcalc
echo $FINDIP - testing note 2
FINDIP=$(hostname -I | cut -f3 -d' '| cut -f1-8 -d:)
echo $FINDIP - check 3
echo "Attempting to adjust results and re-calculate IPv6 Address"
FINDIP=$(sipcalc ${FINDIP} | fgrep Expanded | cut -d ' ' -f3)
if [[ $FINDIP =~ $regex ]]; then
FINDIP=$(echo ${FINDIP} | cut -f1-7 -d:)
echo "IPv6 Address check is good"
IP=${FINDIP}
else
echo "IPv6 Addressing check has failed. Contact NullEntry Support"
echo ${IP} testing note
exit 1
fi
fi
echo ${MNIP1} testing note
echo ${IP} testing note
echo -e ${YELLOW} "Building IP Tables"${CLEAR}
sudo touch ip.tmp
for i in {15361..15375}; do printf "${IP}:%.4x\n" $i >> ip.tmp; done
MNIP1=$(sed -n '1p' < ip.tmp)
MNIP2=$(sed -n '2p' < ip.tmp)
MNIP3=$(sed -n '3p' < ip.tmp)
rm -rf ip.tmp
fi
if grep -Fxq "swapInstalled: true" /usr/local/nullentrydev/mnodes.log
then
echo -e ${RED}"Skipping... Swap Area already made"${CLEAR}
else
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
if [[ $NULLREC = "y" ]] ; then
echo "swapInstalled: true" >> /usr/local/nullentrydev/mnodes.log
fi
fi
cd ~
touch ICAcheck.tmp
ps aux | grep ichibacoin >> ICAcheck.tmp
if grep home/ichibacoin/.ichibacoin ICAcheck.tmp
then
echo Found OLD ${NC} ICA Node running
OldNode="1"
else
echo No ${NC} ICA Node not running
OldNode="0"
fi
until [[ $NC = 9 ]]; do
if grep /home/ichibacoin${NC}/.ichibacoin ICAcheck.tmp
then
echo Found ${NC} ICA Node running
declare IPN$NC="1"
RB=1
else
echo No ${NC} ICA Node not running
declare IPN$NC="0"
echo $NC
fi
NC=$[$NC+1]
done
rm -r ICAcheck.tmp
if [[ "$OldNode" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin/.ichibacoin stop
fi
if [[ "$IPN1" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin1/.ichibacoin stop
fi
if [[ "$IPN2" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin2/.ichibacoin stop
fi
if [[ "$IPN3" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin3/.ichibacoin stop
fi
if [[ "$IPN4" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin4/.ichibacoin stop
fi
if [[ "$IPN5" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin5/.ichibacoin stop
fi
if [[ "$IPN6" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin6/.ichibacoin stop
fi
if [[ "$IPN7" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin7/.ichibacoin stop
fi
if [[ "$IPN8" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin8/.ichibacoin stop
fi
if [[ "$IPN9" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin9/.ichibacoin stop
fi
if [[ "$IPN0" = "1" ]]; then
ichibacoin-cli -datadir=/home/ichibacoin0/.ichibacoin stop
fi
if [ ! -d /root/ICA ]; then
sudo mkdir /root/ICA
fi
cd /root/ICA
echo "Downloading latest IchibaCoin binaries"
wget https://github.com/IchibaCoin/ICHIBA/releases/download/v1.0/IchibaCoin-.Daemon_Ubuntu-16.04.tar.gz
tar -xzf IchibaCoin-.Daemon_Ubuntu-16.04.tar.gz
sleep 3
sudo mv /root/ICA/ichibacoind /root/ICA/ichibacoin-cli /usr/local/bin
sudo chmod 755 -R /usr/local/bin/ichibacoin*
rm -rf /root/ICA
if [ ! -f /home/ichibacoin/.ichibacoin/ichibacoin.conf ]; then
echo -e "${GREEN}Configuring First IchibaCoin Node${CLEAR}"
sudo mkdir /home/ichibacoin/.ichibacoin
sudo touch /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "rpcallowip=127.0.0.1" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "server=1" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "daemon=1" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "maxconnections=250" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "masternode=1" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "rpcport=29021" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "listen=0" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "externalip=$(hostname -I | cut -f1 -d' '):2219" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "masternodeprivkey=$MNKEY" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
echo "addnode=192.210.216.95" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
MN1=0
if [[ $NULLREC = "y" ]] ; then
echo "masterNode1 : true" >> /usr/local/nullentrydev/ICA.log
echo "walletVersion1 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/ICA.log
echo "scriptVersion1 : 0.99" >> /usr/local/nullentrydev/ICA.log
fi
else
echo -e ${YELLOW}"Found /home/ichibacoin/.ichibacoin/ichibacoin.conf"${CLEAR}
echo -e ${YELLOW}"Skipping Configuration there"${CLEAR}
fi
echo
echo -e ${YELLOW}"Launching First ICA Node"${CLEAR}
ichibacoind -datadir=/home/ichibacoin/.ichibacoin -daemon
echo
echo -e ${YELLOW}"Looking for a Shared Masternode Service? Check out Crypto Hash Tank" ${CLEAR}
echo -e ${YELLOW}"Support my Project, and put your loose change to work for you!" ${CLEAR}
echo -e ${YELLOW}" https://www.cryptohashtank.com/TJIF "${CLEAR}
echo
echo -e ${YELLOW}"Special Thanks to the BitcoinGenX (BGX) Community" ${CLEAR}
sleep 20
if [ ! -f /home/ichibacoin2/.ichibacoin/ichibacoin.conf ]; then
if [ ! -f /home/ichibacoin2/ichibacoin.conf ]; then
echo -e "${YELLOW}Second IchibaCoin Normal Warning - Node Configuration Not Found....${CLEAR}"
echo -e "${GREEN}Configuring Second IchibaCoin Node${CLEAR}"
sudo mkdir /home/ichibacoin2/.ichibacoin
sudo touch /home/ichibacoin2/ichibacoin.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/ichibacoin2/ichibacoin.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/ichibacoin2/ichibacoin.conf
echo "rpcallowip=127.0.0.1" >> /home/ichibacoin2/ichibacoin.conf
echo "server=1" >> /home/ichibacoin2/ichibacoin.conf
echo "daemon=1" >> /home/ichibacoin2/ichibacoin.conf
echo "maxconnections=250" >> /home/ichibacoin2/ichibacoin.conf
echo "masternode=1" >> /home/ichibacoin2/ichibacoin.conf
echo "rpcport=29022" >> /home/ichibacoin2/ichibacoin.conf
echo "listen=0" >> /home/ichibacoin2/ichibacoin.conf
echo "externalip=[${MNIP2}]:2219" >> /home/ichibacoin2/ichibacoin.conf
echo "masternodeprivkey=$MNKEY2" >> /home/ichibacoin2/ichibacoin.conf
echo "addnode=$(hostname -I | cut -f1 -d' '):2219" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode2 : true" >> /usr/local/nullentrydev/ICA.log
echo "walletVersion2 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/ICA.log
echo "scriptVersion2 : 0.99" >> /usr/local/nullentrydev/ICA.log
fi
else
echo
echo -e ${GREEN}"Found /home/ichibacoin2/ichibacoin.conf"${CLEAR}
echo -e ${YELLOW}"Skipping Pre-stage for Second Node "${CLEAR}
MN2=0
fi
else
echo -e ${YELLOW}"Found /home/ichibacoin2/.ichibacoin/ichibacoin.conf"${CLEAR}
echo -e ${YELLOW}"Skipping Configuration for Second Node"${CLEAR}
fi
echo
if [ ! -f /home/ichibacoin3/.ichibacoin/ichibacoin.conf ]; then
if [ ! -f /home/ichibacoin3/ichibacoin.conf ]; then
echo -e "${GREEN}Third IchibaCoin Node Configuration Not Found....${CLEAR}"
echo -e "${GREEN}Configuring Third IchibaCoin Node${CLEAR}"
sudo mkdir /home/ichibacoin3/.ichibacoin
sudo touch /home/ichibacoin3/ichibacoin.conf
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/ichibacoin3/ichibacoin.conf
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/ichibacoin3/ichibacoin.conf
echo "rpcallowip=127.0.0.1" >> /home/ichibacoin3/ichibacoin.conf
echo "server=1" >> /home/ichibacoin3/ichibacoin.conf
echo "daemon=1" >> /home/ichibacoin3/ichibacoin.conf
echo "maxconnections=250" >> /home/ichibacoin3/ichibacoin.conf
echo "masternode=1" >> /home/ichibacoin3/ichibacoin.conf
echo "rpcport=29024" >> /home/ichibacoin3/ichibacoin.conf
echo "listen=0" >> /home/ichibacoin3/ichibacoin.conf
echo "externalip=[${MNIP3}]:2219" >> /home/ichibacoin3/ichibacoin.conf
echo "masternodeprivkey=$MNKEY3" >> /home/ichibacoin3/ichibacoin.conf
echo "addnode=$(hostname -I | cut -f1 -d' '):2219" >> /home/ichibacoin/.ichibacoin/ichibacoin.conf
if [[ $NULLREC = "y" ]] ; then
echo "masterNode3 : true" >> /usr/local/nullentrydev/ICA.log
echo "walletVersion3 : 1.4.0COINVERSION=1.6.0" >> /usr/local/nullentrydev/ICA.log
echo "scriptVersion3 : 0.99" >> /usr/local/nullentrydev/ICA.log
fi
else
echo -e ${YELLOW}"Found /home/ichibacoin3/ichibacoin.conf"${CLEAR}
echo -e ${YELLOW}"Skipping Pre-stage for Third Node "${CLEAR}
MN3=0
fi
echo
else
echo -e ${YELLOW}"Found /home/ichibacoin3/.ichibacoin/ichibacoin.conf"${CLEAR}
echo -e ${YELLOW}"Skipping Configuration for Third Node"${CLEAR}
fi
echo
echo -e "${RED}This process can take a while!${CLEAR}"
echo -e "${YELLOW}Waiting on First Masternode Block Chain to Synchronize${CLEAR}"
echo -e "${YELLOW}Once complete, it will stop and copy the block chain to${CLEAR}"
echo -e "${YELLOW}the other masternodes. This prevent all masternodes${CLEAR}"
echo -e "${YELLOW}from downloading the block chain individually; taking up${CLEAR}"
echo -e "${YELLOW}more time and resources. Current Block count will be displayed below.${CLEAR}"
until ichibacoin-cli -datadir=/home/ichibacoin/.ichibacoin mnsync status | grep -m 1 'IsBlockchainSynced": true'; do
ichibacoin-cli -datadir=/home/ichibacoin/.ichibacoin getblockcount
sleep 60
done
echo -e "${GREEN}Haulting and Replicating First IchibaCoin Node${CLEAR}"

ichibacoin-cli -datadir=/home/ichibacoin/.ichibacoin stop
sleep 10
if [[ "$MN2" -eq "0" ]]; then
sudo cp -r /home/ichibacoin/.ichibacoin/* /home/ichibacoin2/.ichibacoin
rm /home/ichibacoin2/.ichibacoin/ichibacoin.conf
cp -r /home/ichibacoin2/ichibacoin.conf /home/ichibacoin2/.ichibacoin/ichibacoin.conf
sleep 1
fi
if [[ "$MN3" -eq "0" ]]; then
sudo cp -r /home/ichibacoin/.ichibacoin/* /home/ichibacoin3/.ichibacoin
rm /home/ichibacoin3/.ichibacoin/ichibacoin.conf
cp -r /home/ichibacoin3/ichibacoin.conf /home/ichibacoin3/.ichibacoin/ichibacoin.conf
sleep 1
fi
echo -e ${YELLOW}"Launching First ICA Node"${CLEAR}
ichibacoind -datadir=/home/ichibacoin/.ichibacoin -daemon
sleep 20
echo -e ${YELLOW}"Launching Second ICA Node"${CLEAR}
ichibacoind -datadir=/home/ichibacoin2/.ichibacoin -daemon
sleep 20
echo -e ${YELLOW}"Launching Third ICA Node"${CLEAR}
ichibacoind -datadir=/home/ichibacoin3/.ichibacoin -daemon
sleep 20
echo -e ${BOLD}"All ${NODESN} ICA Nodes Launched".${CLEAR}
echo

echo -e "${GREEN}You can check the status of your ICA Masternode with"${CLEAR}
echo -e "${YELLOW}For mn1: \"ichibacoin-cli -datadir=/home/ichibacoin/.ichibacoin masternode status\""${CLEAR}
echo -e "${YELLOW}For mn2: \"ichibacoin-cli -datadir=/home/ichibacoin2/.ichibacoin masternode status\""${CLEAR}
echo -e "${YELLOW}For mn3: \"ichibacoin-cli -datadir=/home/ichibacoin3/.ichibacoin masternode status\""${CLEAR}
echo
echo -e "${RED}Status 29 may take a few minutes to clear while the daemon processes the chainstate"${CLEAR}
echo -e "${GREEN}The data below needs to be in your local masternode configuration file:${CLEAR}"
echo -e "${BOLD} Masternode - \#1 IP: $(hostname -I | cut -f1 -d' '):2219${CLEAR}"
echo -e "${BOLD} Masternode - \#2 IP: [${MNIP2}]:2219${CLEAR}"
echo -e "${BOLD} Masternode - \#3 IP: [${MNIP3}]:2219${CLEAR}"
fi
echo -e ${BLUE}" Your patronage is appreciated, tipping addresses"${CLEAR}
echo -e ${BLUE}" IchibaCoin address: iAAVTcoF14zQgVbUcoVASoRGDxWy3kYzRz"${CLEAR}
echo -e ${BLUE}" XGS address: BayScFpFgPBiDU1XxdvozJYVzM2BQvNFgM"${CLEAR}
echo -e ${BLUE}" LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H"${CLEAR}
echo
echo -e ${YELLOW}"Need help? Find Sburns1369\#1584 on Discord - https://discord.gg/YhJ8v3g"${CLEAR}
echo -e ${YELLOW}"If Direct Messaged please verify by clicking on the profile!"${CLEAR}
echo -e ${YELLOW}"it says Sburns1369 in bigger letters followed by a little #1584" ${CLEAR}
echo -e ${YELLOW}"Anyone can clone my name, but not the #1384".${CLEAR}
echo
echo -e ${RED}"The END."${CLEAR};
