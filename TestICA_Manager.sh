#!/bin/bash
#This script work was created by SBurns of the Null Entry Project
#And possible follow/fork from https://github.com/sburns1369/
#If anyone recycles please leave credit to the author somewhere
#As well as the donation address for the “Buy the poor guy a red bull”
#LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H
#This script work is still in active deployment so please keep an eye April 2019
declare -i NC ICA ICAC ICAOld ICAMN0 ICAMN1 ICAMN2 ICAMN3 ICAMN4 ICAMN5 ICAMN6 ICAMN7 ICAMN8
#Counter
NC=0
#Coin MN found 0 false 1 true
ICA=0
#Masternode Counter
ICAC=0
#Coinname Lowercase
COINl=ichibacoin
#Coin ticket symbol
COIN3=ICA
COIN3l=ica
COINDAEMON=ichibacoind
COINDAEMONCLI=ichibacoin-cli
COINCORE=.ichibacoin
COINCONFIG=ichibacoin.conf
COINHOME=/home/ichibacoin
NEBootStrap=http://nullentry.com/chain/ICA/bootstrap.rar
ADDNODE0=207.180.249.132
ADDNODE1=138.197.153.30
ADDNODE2=167.86.80.112
ADDNODE3=45.32.234.220
ADDNODE4=142.93.155.59
ADDNODE5=95.216.236.193
#path to NullEntryDev stuff
DPATH=/usr/local/nullentrydev/
#IPCHECK
REGEX4='^([0-9]{0,3}:){1,7}[0-9a-fA-F]{0,4}$'
REGEX6='^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$'
BLUE='\033[0;96m'
GREEN='\033[0;92m'
RED='\033[0;91m'
YELLOW='\033[0;93m'
CLEAR='\033[0m'
#Pause
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
test_pause(){
  read -p "Testing Pause - Report if you see this - Press [Enter] key to continue..." fackEnterKey
}
#Null Entry logo
null_logo(){
echo
echo
echo -e " ${BLUE} "
echo "    ███╗   ██╗██╗  ██╗██╗    ██╗    ██████╗███╗   ██╗██████╗█████╗ ██╗   ██╗    ";
echo "    ████╗  ██║██║  ██║██║    ██║    ██╔═══╝████╗  ██║╚═██╔═╝██╔═██╗╚██╗ ██╔╝    ";
echo "    ██╔██╗ ██║██║  ██║██║    ██║    █████╗ ██╔██╗ ██║  ██║  █████╔╝ ╚████╔╝     ";
echo "    ██║╚██╗██║██║  ██║██║    ██║    ██╔══╝ ██║╚██╗██║  ██║  ██╔═██╗  ╚██╔╝      ";
echo "    ██║ ╚████║╚█████╔╝██████╗██████╗██████╗██║ ╚████║  ██║  ██║ ██║   ██║       ";
echo "    ╚═╝  ╚═══╝ ╚════╝ ╚═════╝╚═════╝╚═════╝╚═╝  ╚═══╝  ╚═╝  ╚═╝ ╚═╝   ╚═╝       ";
echo "                                                                                       ";
echo "███╗   ███╗ ████╗ █████╗██████╗██████╗██████╗ ███╗   ██╗ ████╗ █████╗ ██████╗";
echo "████╗ ████║██╔═██╗██╔══╝╚═██╔═╝██╔═══╝██╔══██╗████╗  ██║██╔═██╗██╔═██╗██╔═══╝";
echo "██╔████╔██║██████║█████╗  ██║  ████╗  ██████╔╝██╔██╗ ██║██║ ██║██║ ██║████╗  ";
echo "██║╚██╔╝██║██╔═██║╚══██║  ██║  ██╔═╝  ██╔══██╗██║╚██╗██║██║ ██║██║ ██║██╔═╝  ";
echo "██║ ╚═╝ ██║██║ ██║█████║  ██║  ██████╗██║  ██║██║ ╚████║╚████╔╝█████╔╝██████╗";
echo "╚═╝     ╚═╝╚═╝ ╚═╝╚════╝  ╚═╝  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═══╝ ╚════╝ ╚═════╝";
echo "                                                                                       ";
echo "         ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗              ";
echo "         ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗             ";
echo "         ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝             ";
echo "         ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗             ";
echo "         ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║             ";
echo "         ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝             ";
echo "                                                                                       ";
echo -e " ${CLEAR} ";
echo "                                                                                       ";
#ASCII art generated from patorjk.com
pause
}
#GenesisX logo
IchibaCoin_Logo(){
  clear
  echo "                                                                      ";
  echo "                                                                      ";
  echo -e "      ${Yellow}                                                                ";
echo " ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄ ";
echo "▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌";
echo " ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌ ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌";
echo "     ▐░▌     ▐░▌          ▐░▌       ▐░▌     ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌";
echo "     ▐░▌     ▐░▌          ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌";
echo "     ▐░▌     ▐░▌          ▐░░░░░░░░░░░▌     ▐░▌     ▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌";
echo "     ▐░▌     ▐░▌          ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌";
echo "     ▐░▌     ▐░▌          ▐░▌       ▐░▌     ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌";
echo " ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌ ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌";
echo "▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░▌       ▐░▌";
echo " ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀   ▀         ▀ ";
  echo -e "${GREEN}                                                           ";
  echo -e "                  ╔╦╗┌─┐┌─┐┌┬┐┌─┐┬─┐┌┐┌┌─┐┌┬┐┌─┐";
  echo -e "                  ║║║├─┤└─┐ │ ├┤ ├┬┘││││ │ ││├┤ ";
  echo -e "                  ╩ ╩┴ ┴└─┘ ┴ └─┘┴└─┘└┘└─┘─┴┘└─┘";
  echo -e "                      ╔╦╗┌─┐┌┐┌┌─┐┌─┐┌─┐┬─┐         ";
  echo -e "                      ║║║├─┤│││├─┤│ ┬├┤ ├┬┘         ";
  echo -e "                      ╩ ╩┴ ┴┘└┘┴ ┴└─┘└─┘┴└─         ";
  echo
  echo -e "${BLUE}     This Script was made by request of a BGX community member"
  echo -e "${BLUE}      NOT to be mistaken as part of the official BGX Project ${CLEAR}"
  echo
  pause
  }
BitCoinGenX_Logo(){
  clear
  echo
  echo -e "${BLUE} This Script was sponsored by : ${GREEN}"
  echo -e " ██████╗ ██╗████████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ";
  echo -e " ██╔══██╗██║╚══██╔══╝██╔════╝██╔═══██╗██║████╗  ██║ ";
  echo -e " ██████╔╝██║   ██║   ██║     ██║   ██║██║██╔██╗ ██║ ";
  echo -e " ██╔══██╗██║   ██║   ██║     ██║   ██║██║██║╚██╗██║ ";
  echo -e " ██████╔╝██║   ██║   ╚██████╗╚██████╔╝██║██║ ╚████║ ";
  echo -e " ╚═════╝ ╚═╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ";
  echo -e "   ${YELLOW}                                ██╗      ██╗              "
  echo -e "     ${RED}                              ╚██╗    ██╔╝              "
  echo -e "  ${YELLOW}     ██████╗ ███████╗███╗   ██╗   ╚██╗  ██╔╝    ";
  echo -e "  ${YELLOW}    ██╔════╝ ██╔════╝████╗  ██║${RED}    ╚██╗██╔╝    ";
  echo -e "  ${YELLOW}    ██║  ███╗█████╗  ██╔██╗ ██║     ╚███╔╝     ";
  echo -e "  ${YELLOW}    ██║   ██║██╔══╝  ██║╚██╗██║${RED}     ██╔██╗     ";
  echo -e "  ${YELLOW}    ╚██████╔╝███████╗██║ ╚████║    ██╔╝ ██╗    ";
  echo -e "  ${YELLOW}     ╚═════╝ ╚══════╝╚═╝  ╚═══╝${RED}   ██╔╝   ██╗    ";
  echo -e "  ${YELLOW}        * Green Protocol *       ██╔╝     ██╗    ";
  echo -e " ${RED}       * ZeroCoin Protocol *      ╚═╝      ╚═╝         "
  echo -e "${GREEN}     On the Web (BGX Wallets) : https://btcgenx.net/ "
  echo -e "${GREEN}      Official Discord : https://discord.gg/QQHgkuV "
  echo -e "${GREEN}Buy BGX : https://app.stex.com/en/basic-trade/pair/BTC/BGX "
  echo
  echo -e "${BLUE}  This Script was made by request of a community member"
  echo -e "${BLUE}  NOT to be mistaken as part of the official BGX Project${CLEAR}"
  pause
}
### Start - First Run Configuration
function_check_first_run(){
  local NULLREC
  if grep -Fxq "firstrun_complete: true" /usr/local/nullentrydev/mnodes.log
    then
      echo "Not First Run - Testing Check Point"
      pause
    else
  echo
  echo -e ${YELLOW}"Welcome to the Beta Masternode Manager Script by ${BLUE}NullEntry"${CLEAR}
  echo -e ${RED}'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND'${CLEAR}
  echo
  echo -e ${BLUE}"May this script will store a small amount data in /usr/local/nullentrydev/ ?"${CLEAR}
  echo -e ${BLUE}"This information is for version updates and later implimentation"${CLEAR}
  echo -e ${BLUE}"Zero Confidental information or Wallet keys will be stored in it"${CLEAR}
  echo
  echo -e ${BLUE}"Upon agrement it will start to automatically install the Libraries and code"${CLEAR}
  echo -e ${BLUE}"needed for most masternodes and this script. As well as Update and Upgrade"${CLEAR}
  echo -e ${BLUE}"existing software on your VPS. Additional dependencies May be installed later"${CLEAR}
  echo
  echo -e ${YELLOW}"Press [Y]es to agree or [N]o to disagree; follow by [ENTER Key]"${CLEAR}
  read  -p "Enter choice : " NULLREC
  case $NULLREC in
    y) function_first_run ;;
    Y) function_first_run ;;
    n) exit 0 ;;
    N) exit 0 ;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2 && function_check_first_run
  esac
fi
}
### End - First Run Configuration
#Main menu
show_mainMenu() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 - My Masternode(s) Status"
  echo -e "2 - Install or Add Masternodes"
  echo -e "3 - Masternode Manager"
  echo -e "4 - Donate"
#  echo -e "5 - Maintenance"
  echo -e "X - Exit"
  read_MainMenuOptions
}
# root menu - read options
read_MainMenuOptions(){
	local choice
	read -p "Enter choice : " choice
	case $choice in
		1) find_Masternodes ;;
		2) function_masternode_upgrade ;;
    3) manager_ICAMasternodes;;
    4) function_Donations ;;
    5) manager_maintenance ;;
    x) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
#start Masternode
start_masternode(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    echo -e ${GREEN}"Starting Masternode ${nodeunit}" ${CLEAR}
    echo -e "Please wait" ${YELLOW}
    ${COINDAEMON} -datadir=${COINHOME}${nodeunit}/${COINCORE} -daemon
    sleep 15
    echo -e ${CLEAR}
  else
    echo -e "Here be dragons"
  fi
}
#start Masternode
stop_masternode(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    echo -e ${GREEN}"Stopping Masternode ${nodeunit}" ${YELLOW}
    ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} stop
    sleep 15
    echo -e ${CLEAR}
  else
    echo -e "Here be dragons"
  fi
}
#edit Masternode Configuration
edit_masternode(){
  echo -e ${GREEN}"Editing Masternode ${nodeunit} Configuration" ${CLEAR}
  echo -e ${YELLOW}"Use [Control Key] + [X Key] to exit editting" ${CLEAR}
  echo -e ${YELLOW}"Press [N Key] to Abort Changes in editor" ${CLEAR}
  echo -e ${YELLOW}"Or press [Y Key] to Save Changes" ${CLEAR}
  echo -e ${YELLOW}"Than [Enter Key] to Accept Changes to File Name" ${CLEAR}
  pause
  nano ${COINHOME}${nodeunit}/${COINCORE}/${COINCONFIG}
  echo -e ${CLEAR}
}
# manager_ICAMasternodes menu
manager_ICAMasternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " Displaying Masternode Status"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 - Display Information"
  echo -e "2 - Edit Configuration"
  echo -e "3 - Start Masternode(s)"
  echo -e "4 - Stop Masternode(s)"
  echo -e "5 - Re-Index Masternode(s)"
	echo -e "X - Exit"
  read_manager_ICAMasternodes
}
# manager_ICAMasternodes read options
read_manager_ICAMasternodes(){
	local choice
	read -p "Enter choice " choice
	case $choice in
    1) display_MN_Status ;;
    2) Edit_MN_Status ;;
    3) manager_Start_Masternodes ;;
    4) manager_stop_Masternodes ;;
    5) function_menu_Reindex_Masternodes ;;
    x) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
## end MN Start Menu options

#Start - manager_maintenance menu
manager_maintenance(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " Displaying Maintainance Options"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "1 - Update Wallet"
  echo -e "B - Back Out of Menu"
	echo -e "X - Exit Program"
  read_manager_maintenance
}
#Start - manager_maintenance read options
read_manager_maintenance(){
	local choice
	read -p "Enter choice " choice
	case $choice in
    1) stop_All_Nodes
    download_coinfiles
    start_All_Nodes
    echo "Wallet Update should be complete"
    pause ;;
    b) echo ;;
    B) echo ;;
    x) exit 0;;
    X) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
#End - manager_maintenance read options
#start_masternodes_Menu
manager_Start_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "   Start Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  echo -e "A - Start All ${COIN3} Masternodes"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  read_Start_Masternodes
}
#start - read Start Masternodes Menu
read_Start_Masternodes(){
  local choice
	read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    start_masternode ;;
    1) nodeunit=1
    start_masternode ;;
    2) nodeunit=2
    start_masternode ;;
    3) nodeunit=3
    start_masternode ;;
    4) nodeunit=4
    start_masternode ;;
    5) nodeunit=5
    start_masternode ;;
    6) nodeunit=6
    start_masternode ;;
    7) nodeunit=7
    start_masternode ;;
    8) nodeunit=8
    start_masternode ;;
    9) nodeunit=9
    start_masternode ;;
    10) nodeunit=0
    start_masternode ;;
    a) echo -e "Launching all Masters!"
    start_All_Nodes ;;
    A) echo -e "Launching all Masters!"
    start_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
}
#End - read Start Masternodes Menu


#start function_menu_Reindex_Masternodes
function_menu_Reindex_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "   Re-Index Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  #echo -e "A - Re-Index All ${COIN3} Masternodes"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  function_Read_Reindex_Masternodes
}
#end function_menu_Reindex_Masternodes
#start - read Start Masternodes Menu
function_Read_Reindex_Masternodes(){
  local choice
	read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    function_reindex_masternode ;;
    1) nodeunit=1
    function_reindex_masternode ;;
    2) nodeunit=2
    function_reindex_masternode ;;
    3) nodeunit=3
    function_reindex_masternode ;;
    4) nodeunit=4
    function_reindex_masternode ;;
    5) nodeunit=5
    function_reindex_masternode ;;
    6) nodeunit=6
    function_reindex_masternode ;;
    7) nodeunit=7
    function_reindex_masternode ;;
    8) nodeunit=8
    function_reindex_masternode ;;
    9) nodeunit=9
    function_reindex_masternode ;;
    10) nodeunit=0
    function_reindex_masternode ;;
    a) echo -e "Launching all Masters!"
    start_All_Nodes ;;
    A) echo -e "Launching all Masters!"
    start_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
}
#End read Start Masternodes Menu
function_reindex_masternode(){
if [ -d /home/${COINl}${nodeunit} ]; then
  stop_masternode
  echo -e ${GREEN}"Attempting Re-Indexing of Masternode ${nodeunit}" ${CLEAR}
  echo -e "Please wait" ${YELLOW}
  ${COINDAEMON} -datadir=${COINHOME}${nodeunit}/${COINCORE} -reindex
  sleep 15
  echo -e ${CLEAR}
else
  echo -e "Here be dragons"
fi
}
## Start ALL MN function
start_All_Nodes(){
local Count
Count=0
nodeunit=
start_masternode
nodeunit=0
until [[ $nodeunit = 10 ]]; do
start_masternode
nodeunit=$[$nodeunit+1]
done
pause
}
##  end of Start ALL MN function
#start Edit Masternode Status Menu
Edit_MN_Status(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "   Edit Masternode Configuration"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  edit_MN_Config
}
#stop_masternodes_Menu
manager_stop_Masternodes(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "   stop Masternode(s)"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - Masternode One"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  echo -e "A - stop All ${COIN3} Masternodes"
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  read_stop_Masternodes
}
#stop - read stop Masternodes Menu
read_stop_Masternodes(){
  local choice
	read -p "Enter choice " choice
  case $choice in
    l) nodeunit=
    stop_masternode ;;
    1) nodeunit=1
    stop_masternode ;;
    2) nodeunit=2
    stop_masternode ;;
    3) nodeunit=3
    stop_masternode ;;
    4) nodeunit=4
    stop_masternode ;;
    5) nodeunit=5
    stop_masternode ;;
    6) nodeunit=6
    stop_masternode ;;
    7) nodeunit=7
    stop_masternode ;;
    8) nodeunit=8
    stop_masternode ;;
    9) nodeunit=9
    stop_masternode ;;
    10) nodeunit=0
    stop_masternode ;;
    a) echo -e "Stopping all Mastersnodes!"
    stop_All_Nodes ;;
    B) echo -e "Stopping all Mastersnodes!"
    stop_All_Nodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
}
#End - read stop Masternodes Menu
## stop ALL MN function
stop_All_Nodes(){
local Count
Count=0
nodeunit=
stop_masternode
nodeunit=0
until [[ $nodeunit = 10 ]]; do
stop_masternode
nodeunit=$[$nodeunit+1]
done
pause
}
##  end of stop ALL MN function
#Function set for Edit MN Config Menu
edit_menu_choice(){
  if [ -d /home/${COINl}${nodeunit} ]; then
    clear
    echo -e "Stopping Masternode to Prevent Problems, please wait"
    stop_masternode
    edit_masternode
    start_masternode
  else
    echo -e "Here be dragons!"
  fi
}
edit_MN_Config(){
  local choice
  read -p "Enter choice : " choice
  case $choice in
    l) nodeunit=
    edit_menu_choice ;;
    1) nodeunit=1
    edit_menu_choice ;;
    2) nodeunit=2
    edit_menu_choice ;;
    3) nodeunit=3
    edit_menu_choice ;;
    4) nodeunit=4
    edit_menu_choice ;;
    5) nodeunit=5
    edit_menu_choice ;;
    6) nodeunit=6
    edit_menu_choice ;;
    7) nodeunit=7
    edit_menu_choice ;;
    8) nodeunit=8
    edit_menu_choice ;;
    9) nodeunit=9
    edit_menu_choice ;;
    10) nodeunit=0
    edit_menu_choice ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
    *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
  esac
}
display_MN_Status(){
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "   Displaying display_MN_Status"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  if [ -d /home/${COINl} ]; then
  echo -e "L - Legacy Masternode One Status"
  fi
  if [ -d /home/${COINl}1 ]; then
  echo -e "01 - (Not This one, you have legacy) (1.0 and new install)"
  fi
  if [ -d /home/${COINl}2 ]; then
  echo -e "02 - Masternode Two"
  fi
  if [ -d /home/${COINl}3 ]; then
  echo -e "03 - Masternode Three"
  fi
  if [ -d /home/${COINl}4 ]; then
  echo -e "04 - Masternode Four"
  fi
  if [ -d /home/${COINl}5 ]; then
  echo -e "05 - Masternode Five"
  fi
  if [ -d /home/${COINl}6 ]; then
  echo -e "06 - Masternode Six"
  fi
  if [ -d /home/${COINl}7 ]; then
  echo -e "07 - Masternode Seven"
  fi
  if [ -d /home/${COINl}8 ]; then
  echo -e "08 - Masternode Eight"
  fi
  if [ -d /home/${COINl}9 ]; then
  echo -e "09 - Masternode Nine"
  fi
  if [ -d /home/${COINl}0 ]; then
  echo -e "10 - Masternode Ten"
  fi
  echo -e "B - Back out of Menu"
  echo -e "X - Exit"
  read_display_MN_Status
}
display_MN_choice(){
  clear
  disp_masternode_Status
  disp_masternode_Chain
  display_MN_Status
}
read_display_MN_Status(){
  local choice
	read -p "Enter choice : " choice
	case $choice in
    l) nodeunit=
    display_MN_choice ;;
    L) nodeunit=
    display_MN_choice ;;
    1) nodeunit=1
    display_MN_choice ;;
    2) nodeunit=2
    display_MN_choice ;;
    3) nodeunit=3
    display_MN_choice ;;
    4) nodeunit=4
    display_MN_choice ;;
    5) nodeunit=5
    display_MN_choice ;;
    6) nodeunit=6
    display_MN_choice ;;
    7) nodeunit=7
    display_MN_choice ;;
    8) nodeunit=8
    display_MN_choice ;;
    9) nodeunit=9
    display_MN_choice ;;
    10) nodeunit=0
    display_MN_choice ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
disp_masternode_Status(){
  echo -e ${GREEN}"Reporting Masternode Status" ${YELLOW}
${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} masternode status
echo -e ${CLEAR}
}
disp_masternode_Chain(){
  echo -e ${GREEN}"Reporting current Block on Chain" ${YELLOW}
${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} getblockcount
echo -e ${CLEAR}
pause
}
# Test Function for Find masterNode
read_Find_MN_Status(){
  local choice
	read -p "Enter choice : " choice
	case $choice in
    l) nodeunit=
    find_Masternodes ;;
    1) nodeunit=1
    find_Masternodes ;;
    2) nodeunit=2
    find_Masternodes ;;
    3) nodeunit=3
    find_Masternodes ;;
    4) nodeunit=4
    find_Masternodes ;;
    5) nodeunit=5
    find_Masternodes ;;
    6) nodeunit=6
    find_Masternodes ;;
    7) nodeunit=7
    find_Masternodes ;;
    8) nodeunit=8
    find_Masternodes ;;
    9) nodeunit=9
    find_Masternodes ;;
    10) nodeunit=0
    find_Masternodes ;;
    b) echo -e "backing out" ;;
    B) echo -e "backing out" ;;
    x) exit 0;;
    X) exit 0;;
		*) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
	esac
}
#end find test masternode menu
find_Masternodes(){
local Count
Count=0
nodeunit=
function_find_Masternodes
nodeunit=0
until [[ $nodeunit = 10 ]]; do
function_find_Masternodes
nodeunit=$[$nodeunit+1]
#if [ ${nodeunit} -eq "4" ]; then
#  pause
#fi
done
pause
}
# Find Masternode Test Function
function_find_Masternodes(){
local choice
  if [ -d /home/${COINl}${nodeunit} ]; then
    if [ -z ${nodeunit} ]; then
    echo -e ${GREEN}"Found ICA-Oldnode Installation Found - /home/${COINl}" ${CLEAR}
  else
    echo -e ${GREEN}"Found ICA-${nodeunit} Installation Found - /home/${COINl}${nodeunit}" ${CLEAR}
  fi
  ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} masternode status &> ${DPATH}ICAMN${nodeunit}.tmp
    if grep -q "Hot node, waiting for remote activation" ${DPATH}ICAMN${nodeunit}.tmp; then
      echo -e ${YELLOW} "Masternode Ready, waiting for activation from Wallet" ${CLEAR}
    elif grep -q "Loading block index..." ${DPATH}ICAMN${nodeunit}.tmp; then
    echo -e ${YELLOW} "Masternode is still loading block Index, please wait." ${CLEAR}
    elif grep -q "Masternode successfully started" ${DPATH}ICAMN${nodeunit}.tmp; then
      echo -e ${GREEN} "Masternode Successfully Started" ${CLEAR}
    elif grep -q "Masternode not found in the list of available masternodes. Current status: Node just started, not yet activated" ${DPATH}ICAMN${nodeunit}.tmp; then
      echo -e ${YELLOW} "Masternode is loading blocks, Please Wait " ${CLEAR}
    elif grep -q "error: couldn't connect to server" ${DPATH}ICAMN${nodeunit}.tmp; then
      echo -e ${RED} "Masternode not running, Please Start"
      echo
      echo -e ${GREEN} "Would you like to attempt to start the Masternode? (Y/N) "
      read -p "Enter choice : " choice
      case $choice in
        y) start_masternode ;;
        Y) start_masternode ;;
        n) echo -e "backing out" ;;
        N) echo -e "backing out" ;;
        *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2
      esac
    fi
      ${COINDAEMONCLI} -datadir=${COINHOME}${nodeunit}/${COINCORE} masternode status &> ${DPATH}ICAMN${nodeunit}.tmp
      DISPIP=$(sed -n '4p' < /usr/local/nullentrydev/ICAMN${nodeunit}.tmp | cut -d'"' -f4 | cut -d':' -f1)
        if [[ "$DISPIP" =~ (([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5])\.([01]{,1}[0-9]{1,2}|2[0-4][0-9]|25[0-5]))$ ]]; then
          echo -e "Running on IPv4 :${YELLOW} ${DISPIP}" ${CLEAR}
        else
        DISPIP=$(sed -n '4p' < /usr/local/nullentrydev/ICAMN${nodeunit}.tmp | cut -d'"' -f4 | cut -d':' -f1-8)
          echo -e "Running on IPv6 : ${YELLOW} ${DISPIP}" ${CLEAR}
        fi
        rm -r /usr/local/nullentrydev/ICAMN${nodeunit}.tmp
#        echo "Running on IP : ${DISPIP}"
ICAOld="1"
ICA=$ICA+1
#else
#  if [ ! -z ${nodeunit} ]; then
# echo -e ${RED}"No Installation Found for Masternode ${nodeunit} - /home/${COINl}${nodeunit}" ${CLEAR}
#  fi
fi
echo
}
#start function_update
function_update() {
    echo -e ${RED}"Updating Apps"${CLEAR}
    sudo apt-get -y update
    sudo apt-get -y upgrade
}
# Operating Systems Check
function_first_run(){
        if [[ $(lsb_release -d) != *16.04* ]]; then
          echo -e ${RED}"The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."${CLEAR}
          exit 1
        fi
#Null Entry Logs configuration file check
        if [ ! -d /usr/local/nullentrydev/ ]; then
          echo "Making /usr/local/nullentrydev "
          sudo mkdir /usr/local/nullentrydev
          else
          echo "Found /usr/local/nullentrydev "
        fi
        if [ ! -f /usr/local/nullentrydev/${COIN3l}.log ]; then
          echo "Making /usr/local/nullentrydev/${COIN3l}.log"
          sudo touch /usr/local/nullentrydev/${COIN3l}.log
          else
            echo "Found /usr/local/nullentrydev/${COIN3l}.log"
        fi
        if [ ! -f /usr/local/nullentrydev/mnodes.log ]; then
          echo "Making /usr/local/nullentrydev/mnodes.log"
          sudo touch /usr/local/nullentrydev/mnodes.log
          else
          echo "Found /usr/local/nullentrydev/mnodes.log"
        fi
        function_first_nodecheck
      }
# Checking to see if Dependencies & Software Libraries have been installed
function_dependencies(){
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
  echo -e ${RED}"Press ENTER when prompted"${CLEAR}
  sudo add-apt-repository -yu ppa:bitcoin/bitcoin
  sudo apt-get update
  sudo apt-get -y install libdb4.8-dev
  sudo apt-get -y install libdb4.8++-dev
  echo -e ${YELLOW} "Here be dragons"${CLEAR}
  sudo apt-get -y install libminiupnpc-dev libzmq3-dev libevent-pthreads-2.0-5
  sudo apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev
  sudo apt-get -y install libqrencode-dev bsdmainutils unzip
    # Recording Dependencies & Software Libraries insatllation complete
    if [[ $NULLREC = "y" ]] ; then
      sudo echo "dependenciesInstalled: true" >> /usr/local/nullentrydev/mnodes.log
    fi
    fi
  echo "firstrun_complete: true" >> /usr/local/nullentrydev/mnodes.log
}
#Firstnode Installation Check
function_first_nodecheck(){
        if [ -d /home/${COINl} ]; then
          echo -e ${GREEN}"Found ${COINl}-Oldnode Installation Found - /home/${COINl}" ${CLEAR}
          pause
        else
          if [ -d /home/${COINl}1 ]; then
          echo -e ${GREEN}"Found ${COINl} Masternode Installation Found - /home/${COINl}" ${CLEAR}
          pause
        else
        #install FirstMasternode - Start!
        nodeunit=1
        clear
        echo
        echo
        echo
        echo -e "${RED}Let's set up your first ${COINl} masternode before we continue..."
        echo -e "${GREEN}This is going to take a few minutes, and when done will display"
        echo -e "${GREEN}information you need for your masternode.conf on your local wallet"
        echo
        echo -e ${GREEN}"Please Enter Your First Masternode Private Key:"${CLEAR}
        read MNKEY

        function_install
        #add Regex or "are you sure"
        fi
      fi
      }
#### end apps/update  install functions?
#>>>>>>>>>><<<<<<<<<<<<<<  make function for IP tables
### Start Building IP Tables function
#end function_iptables
#>>>>>>>>>><<<<<<<<<<< break into function, swap space >>>>>>>>>>>><<<<<<<<<<<<<<<<<
#start function_swap_space
function_swap_space(){
if grep -Fxq "swapInstalled: true" /usr/local/nullentrydev/mnodes.log
then
echo -e ${RED}"Skipping... Swap Area already made"${CLEAR}
else
cd /var
sudo touch swap.img
sudo chmod 600 swap.img
echo -e ${YELLOW} "You should check out https://youtu.be/l9nh1l8ZIJQ"${CLEAR}
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=4096
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
fi
}
###end test find masternode function
download_coinfiles(){
  cd ~
if [ ! -d /root/${COIN3l} ]; then
  sudo mkdir /root/${COIN3l}
fi
cd /root/${COIN3l}
#Download Wallet Files
echo "Downloading latest ${COIN} binaries"
wget https://github.com/IchibaCoin/ICHIBA/releases/download/v1.0/IchibaCoin-.Daemon_Ubuntu-16.04.tar.gz
tar -xzf IchibaCoin-.Daemon_Ubuntu-16.04.tar.gz
sleep 3
sudo mv /root/${COIN3l}/${COINDAEMON} /root/${COIN3l}/${COINDAEMONCLI} /usr/local/bin
sudo chmod 755 -R  /usr/local/bin/${COINl}*
rm -rf /root/${COIN3l}
}
##Make Node configuration file
function_build_node_configuration(){
  echo -e "${GREEN}Configuring ${COIN} Masternode #${nodeunit} ${CLEAR}"
  sudo mkdir /home/${COINl}${nodeunit}/.${COINl}
  sudo touch /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "rpcallowip=127.0.0.1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "server=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "daemon=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "maxconnections=250" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "masternode=1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
##need to build master statement for coinport
  RPCPORT=$(($COINRPCPORT+$nodeunit-1))
  echo "rpcport=${RPCPORT}" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "listen=0" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  if [[ $nodeunit -eq 1 ]] ; then
    echo "externalip=${MNIP1}:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
    elif [[ $nodeunit -eq 2 ]] ; then
      echo "externalip=[${MNIP2}]:$COINPORT" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  fi
  echo "masternodeprivkey=$privkey" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  ###Add Nodes Updates if 1st node skip, otherwise add 1st node as add node
  if [[ $nodeunit -eq 1 ]] ; then
  echo "addnode=$ADDNODE0" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE1" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE2" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE3" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE4" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  echo "addnode=$ADDNODE5" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  else
  echo "addnode=${MNIP1}" >> /home/${COINl}${nodeunit}/.${COINl}/${COINCONFIG}
  fi
}
## End Make Node Configuration Files
## Start Launch First node
launch_first_node(){
  echo -e ${BOLD}"Launching First ${COIN3} Node"${CLEAR}
  ${COINDAEMON} -datadir=/home/${COINl}1/.${COINl} -daemon
  sleep 1
    if [ -f /usr/local/nullentrydev/${COIN3l}.log ]; then
      sudo rm -rf /usr/local/nullentrydev/${COIN3l}.log
      sudo touch /usr/local/nullentrydev/${COIN3l}.log
    fi
    echo "masterNode1 : true" >> /usr/local/nullentrydev/${COIN3l}.log
    echo "walletVersion1 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
    echo "scriptVersion1 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
    test_pause
}
##End Launch first node
##Start Waiting for Launch of First Nodes
wait_first_node_launch(){
echo
echo -e "${RED}This process can take a while!${CLEAR}"
echo -e "${YELLOW}Waiting on First Masternode Block Chain to Synchronize${CLEAR}"
echo -e "${YELLOW}Once complete, it will stop and copy the block chain to${CLEAR}"
echo -e "${YELLOW}the other masternodes.  This prevent all masternodes${CLEAR}"
echo -e "${YELLOW}from downloading the block chain individually; taking up${CLEAR}"
echo -e "${YELLOW}more time and resources.  Current Block count will be displayed below.${CLEAR}"
ichiba-cli -datadir=/home/ichiba/.ichiba getblockcount
sleep 5
#node 1 sync check
until ichiba-cli -datadir=/home/ichiba/.ichiba mnsync status | grep -m 1 'IsBlockchainSynced" : true'; do
    ichiba-cli -datadir=/home/ichiba/.ichiba getblockcount
    sleep 5
  done
  test_pause
}
##End launch of first nodes
##Start of replicate nodes
replicate_node(){
  echo -e "${GREEN}Haulting and Replicating First ${COIN} Node${CLEAR}"
  echo
  sleep 5
  cd /
  ichiba-cli -datadir=/home/ichiba/.ichiba stop
  sleep 10
  sudo cp -r /home/${COINl}/.${COINl}/* /home/${COINl}2/.${COINl}/
  sudo rm /home/${COINl}2/.${COINl}/${COINCONFIG}
  sudo cp -r /home/${COINl}2/${COINCONFIG} /home/${COINl}2/.${COINl}/${COINCONFIG}
  sleep 5
start_All_Nodes
}
##Configure other nodes
configure_nonleadNodes(){
  echo
echo -e "${GREEN}Configuring Second ${COIN} Node${CLEAR}"
sudo mkdir /home/${COINl}2/.${COINl}
sudo touch /home/${COINl}2/${COINCONFIG}
echo "rpcuser=user"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}2/${COINCONFIG}
echo "rpcpassword=pass"`shuf -i 100000-9999999 -n 1` >> /home/${COINl}2/${COINCONFIG}
echo "rpcallowip=127.0.0.1" >> /home/${COINl}2/${COINCONFIG}
echo "server=1" >> /home/${COINl}2/${COINCONFIG}
echo "daemon=1" >> /home/${COINl}2/${COINCONFIG}
echo "maxconnections=250" >> /home/${COINl}2/${COINCONFIG}
echo "masternode=1" >> /home/${COINl}2/${COINCONFIG}
echo "rpcport=${COINRPCPORT2}" >> /home/${COINl}2/${COINCONFIG}
echo "listen=0" >> /home/${COINl}2/${COINCONFIG}
echo "externalip=[${MNIP2}]:$COINPORT" >> /home/${COINl}2/${COINCONFIG}
echo "masternodeprivkey=$privkey2" >> /home/${COINl}2/${COINCONFIG}
# Inserting Version to nullentrydev files
if [[ $NULLREC = "y" ]] ; then
  echo "masterNode2 : true" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "walletVersion2 : $COINVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
  echo "scriptVersion2 : $SCRIPTVERSION" >> /usr/local/nullentrydev/${COIN3l}.log
fi
sleep 3
echo
# Starting Second Masternode daemon
echo -e ${BOLD}"Second ${COIN3} Node Staged for launch"${CLEAR}
}

### Start - Masternode function_calculate_Masternode_Install
function_new_masternode_install_menu(){
  echo -e ${GREEN}" How many ${COIN3} Masternode(s) would you like to Install? [1 - 8]"${CLEAR}
  echo -e "Press [C] to exit"
  read -p "Enter Number : " Install_Count
  case $Install_Count in
    1-10) echo "test fire ${Install_Count}" ;;
    c) exit 0 ;;
    c) exit 0 ;;
    *) echo -e "${RED}Invalid Amount!${STD}" ${CLEAR} && sleep 2 ;;
  esac
  #set permaters to install
}
### End -  Masternode function_calculate_Masternode_Install
function_install_math() {
  echo ${Install_Count}
  #figure out how many MNs exists
  #Figure out where to start installation from
  #limit installation to 10
}
### Start - Masternode function_Masternode_upgrade
function_masternode_upgrade(){
    clear
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "   How Many Masternode Do you want to Run?"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo -e "1 - One Masternode"
    echo -e "2 - Masternode Two"
    echo -e "3 - Masternode Three"
    echo -e "4 - Masternode Four"
    echo -e "5 - Masternode Five"
    echo -e "6 - Masternode Six"
    echo -e "7 - Masternode Seven"
    echo -e "8 - Masternode Eight"
    echo -e "B - Back out of Menu"
    echo -e "X - Exit"
    function_read_masternode_upgrade
  }
  #end function_menu_Reindex_Masternodes
  #start - read Start Masternodes Menu
  function_read_masternode_upgrade(){
    local choice
  	read -p "Enter choice " choice
    case $choice in
      1) build_first_node ;;
      2)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/Ichiba_MN_Script/master/Ichibacoin_2pack.sh)
      pause ;;
      3)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/Ichiba_MN_Script/master/Ichibacoin_3pack.sh)
      pause ;;
      4)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/Ichiba_MN_Script/master/Ichibacoin_4pack.sh)
      pause ;;
      5)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/Ichiba_MN_Script/master/Ichibacoin_5pack.sh)
      pause ;;
      6)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/Ichiba_MN_Script/master/Ichibacoin_6pack.sh)
      pause ;;
      7)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/Ichiba_MN_Script/master/Ichibacoin_7pack.sh)
      pause ;;
      8)bash <(curl -Ls https://raw.githubusercontent.com/sburns1369/Ichiba_MN_Script/master/Ichibacoin_8pack.sh)
      pause ;;
      b) echo -e "backing out" ;;
      B) echo -e "backing out" ;;
      x) exit 0;;
      X) exit 0;;
      *) echo -e "${RED}Error...${STD}" ${CLEAR} && sleep 2 && function_read_masternode_upgrade
    esac
  }
  #End read Start Masternodes Menu
  #subtracts currently running masternodes
function_masternode_migrate(){
  #attempt to move legacy masternode
  echo null#possible attempt to relocate stock scripts
}
function_Donations(){
  #attempt to move legacy masternode
    clear
    echo
    echo
    echo
    echo -e "Donations can be made to multiple addresses for multiple projects"
    echo
    echo -e "IchibaCoin address: iAAVTcoF14zQgVbUcoVASoRGDxWy3kYzRz"
    echo -e ${BLUE}" Your patronage is apprappreciated, tipping addresses"${CLEAR}
    echo -e ${BLUE}" BGX address: BayScFpFgPBiDU1XxdvozJYVzM2BQvNFgM"${CLEAR}
    echo -e ${BLUE}" BTC address: 32FzghE1yUZRdDmCkj3bJ6vJyXxUVPKY93"${CLEAR}
    echo -e ${BLUE}" LTC address: MUdDdVr4Az1dVw47uC4srJ31Ksi5SNkC7H"${CLEAR}
    echo -e ${BLUE}" XGS address: GcToAa57WXPsVwXB9LKvui215AC3bsvneA"${CLEAR}
    echo
    echo -e ${YELLOW}"Need help?  Find Sburns1369#1584 one Discord - https://discord.gg/YhJ8v3g"${CLEAR}
    pause

}
function_build_IP(){
if [[ customIP = "y" ]] ; then
echo -e ${GREEN}"IP for Masternode 1"${CLEAR}
read MNIP1
echo -e ${GREEN}"IP for Masternode 2"${CLEAR}
read MNIP2
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
sudo touch ${DPATH}ip.tmp
for i in {15361..15375}; do printf "${IP}:%.4x\n" $i >> ${DPATH}ip.tmp; done
MNIP1=$(hostname -I | cut -f1 -d' ')
MNIP2=$(sed -n '2p' < ${DPATH}ip.tmp)
rm -rf ${DPATH}ip.tmp
fi

}
build_first_node(){
function_update
}
### End - Masternode function_Masternode_upgrade
function_user_add_check(){
if id "${COINl}${nodeunit}" >/dev/null 2>&1; then
echo "${COINl}${nodeunit}user exists"
MN${nodeunit}=1
else
sudo adduser --system --home /home/${COINl}${nodeunit} ${COINl}${nodeunit}
MN${nodeunit}=0
fi
}
## Start Bootstrap
function_bootstrap(){
  cd ~
if [ ! -d /root/${COIN3l} ]; then
  sudo mkdir /root/${COIN3l}
fi
cd /root/${COIN3l}
echo "Attempting to get Bootstrap, please wait"
pause
wget ${NEBootStrap}
sleep 3
sudo echo tar -xzf bootstrap.rar
if [ ! -d ${COINl}1/.${COINl} ]; then
  echo "Making /home/${COINl}${nodeunit}/.${COINl} "
  sudo mkdir /home/${COINl}${nodeunit}/.${COINl}
  else
  echo "Found /home/${COINl}${nodeunit}/.${COINl} "
fi
sudo mv /root/${COIN3l}/bootstrap.rar /home/${COINl}${nodeunit}/.${COINl}
test_pause
rm -rf /root/${COIN3l}
}


# installation Core
function_install(){
function_swap_space
function_update
function_dependencies
function_user_add_check
download_coinfiles
function_bootstrap
function_build_IP
function_build_node_configuration
launch_first_node
wait_first_node_launch
}
#End installation Core

#Program Core
clear
null_logo
BitCoinGenX_Logo
IchibaCoin_Logo
function_check_first_run
function_first_nodecheck
while true
do
	show_mainMenu
  echo
done