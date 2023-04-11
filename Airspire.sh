#!/bin/bash

#Title............: Airspire
#Description......: ADS-B Software Manager
#Author...........: Adhithya Pasupuleti
#Version..........: 1.0
#Social Platform..: arcticfox.92 (instagram) 
#The copyright of packages, libraries, and repositories included in the installation belongs of their respective owners.

#########################################################################################################################

update="sudo apt-get update"

function check_package_installed () { # fr ins
    local package_name="$1"
    if [ -x "$(command -v $package_name)" ]; then
        echo "0" # 
    else
        echo "1" # package is not installed
    fi
}

# [ Piaware ]
function piaware_check() { 
			   if [ -x "$(command -v piaware)" ]; then
			   pc="\e[32mPiaware\e[0m" # green
			   else
			   pc="\e[31mPiaware\e[0m" # red
    fi
}

function piaware_install() { 
			     clear
			     intro
			     $update
			     local piaware_installed="$(check_package_installed "piaware")"
			     local dump1090_installed="$(check_package_installed "dump1090-fa")"
			     
    if [ "$piaware_installed" = "0" ] && [ "$dump1090_installed" = "0" ]; then
        		     echo "Piaware is already installed"
			     sleep 2.5
			     prime
			     read -p "Press any key to continue..."
    elif [ "$piaware_installed" = "0" ] && [ "$dump1090_installed" = "1" ]; then
       			     echo "piaware is installed but dump1090-fa is not installed"
			     echo ""
			     echo "installing dump1090-fa"
			     sudo apt install dump1090-fa -y
			     echo ""
			     sleep 4
			     prime
			     read -p "Press any key to continue..."
    elif [ "$piaware_installed" = "1" ] && [ "$dump1090_installed" = "0" ]; then
        		     echo "piaware is not installed but dump1090-fa is installed"
			     $update
			     sudo wget https://flightaware.com/adsb/piaware/files/packages/pool/piaware/f/flightaware-apt-repository/flightaware-apt-repository_1.1_all.deb
			     sudo dpkg -i flightaware-apt-repository_1.1_all.deb
			     $update
			     sudo apt-get install piaware -y
			     sudo piaware-config allow-auto-updates yes
			     sudo piaware-config allow-manual-updates yes
			     echo ""
			     sleep 4
			     prime
			     read -p "Press any key to continue..."
    else
        echo "Installing piaware and dump1090-fa"
        $update
        sudo wget https://flightaware.com/adsb/piaware/files/packages/pool/piaware/f/flightaware-apt-repository/flightaware-apt-repository_1.1_all.deb
        sudo dpkg -i flightaware-apt-repository_1.1_all.deb
        sudo apt-get update
        sudo apt-get install piaware -y
        sudo piaware-config allow-auto-updates yes
        sudo piaware-config allow-manual-updates yes
        sudo apt-get install dump1090-fa -y
        echo ""
        sleep 4
        prime
        read -p "Press any key to continue..."
    fi
}

function piaware_uninstall() {
			       sudo systemctl stop piaware
			       sudo systemctl stop dump1090-fa
			       sudo apt-get remove piaware dump1090-fa -y
			       sudo apt purge -y piaware dump1090-fa
			       sudo apt-get remove flightaware-apt-repository -y
			       sudo apt-get autoremove -y
			       sudo apt-get autoclean
			       sudo rm -rf /etc/piaware.conf /usr/lib/piaware /usr/share/dump1090-fa /etc/lighttpd/conf-available/89-dump1090-fa.conf /etc/lighttpd/conf-enabled/89-dump1090-fa.conf
			       echo ""
			       sleep 4
			       prime
			       read -p "Press any key to continue..."
}

# [FlightRadar24]
function fr24_check() { 
			   if [ -x "$(command -v fr24feed)" ]; then
			   frc="\e[32mFr24\e[0m" # green
			   else
			   frc="\e[31mFr24\e[0m" # red
    fi
}
			  
function fr24_install() { 
			     clear
			     intro
			     $update
			     local fr24_installed="$(check_package_installed "fr24feed")"		     
    if [ "$fr24_installed" = "0" ]; then
        		     echo "Fr24 is already installed"
			     sleep 2.5
			     prime
			     read -p "Press any key to continue..."
    else
        echo "Installing fr24feed"
        intro
	$update
	sudo apt install wget -y git dpkg dpkg-dev make cmake 
	sudo wget https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_1.0.34-0_armhf.deb
	sudo dpkg -i fr24feed_1.0.34-0_armhf.deb    #test🟢🔴🔺🔻🚩🔽🔼✨ #
        echo ""
        sleep 4
        prime
        read -p "Press any key to continue..."
    fi
}

function fr24_uninstall() {
			       sudo systemctl stop fr24feed
			       sudo apt-get remove fr24feed -y
			       sudo rm -rf /etc/fr24feed
			       sudo apt-get autoremove -y
}

			     
# [Radarbox]
function rbfeeder_check() { 
			   if [ -x "$(command -v rbfeeder)" ]; then
			   rbc="\e[32mRadarbox\e[0m" # green
			   else
			   rbc="\e[31mRadarbox\e[0m" # red
    fi
}
			  
function rbfeeder_install() { 
			     clear
			     intro
			     $update
			     local fr24_installed="$(check_package_installed "rbfeeder")"		     
    if [ "$rbfeeder_installed" = "0" ]; then
        		     echo "radarbox is already installed"
			     sleep 2.5
			     prime
			     read -p "Press any key to continue..."
    else
        echo "Installing Radarbox"
        intro
	$update
	sudo bash -c "$(wget -O - http://apt.rb24.com/inst_rbfeeder.sh)"
	sudo apt update && sudo apt upgrade -y
	sudo apt-get install mlat-client -y
	sudo systemctl restart rbfeeder
	sleep 4
        prime
        read -p "Press any key to continue..."
    fi
}

function rbfeeder_uninstall() {
			       ssudo systemctl stop rbfeeder

			       sudo apt-get remove fr24feed -y
			       sudo rm -rf /etc/fr24feed
			       sudo apt-get autoremove -y
}



function main () {
    echo "┌─────────────┐"
    echo "│  Main Menu  │"
    echo "└─────────────┘"
    echo -e "\033[33mPlease select the feeder:\033[0m"
    echo ""
    piaware_check
    echo -e "1 - $pc"
    echo ""
    echo "2 - $frc"
    echo ""
    echo "3 - $rbc"
    echo ""
    echo "4 - Opensky-Network"
    echo ""
    echo "5 - AdsbExchange"
    echo ""
    echo "6 - AdsbHub"
    echo ""
    read -p "Enter the Selected feeder [1-6]: " Main_choice
    echo ""

    case $Main_choice in
        1) choice="$pc"
        ;;
        2) choice="Flightradar24"
        ;;
        3) choice="Radarbox"
        ;;
        4) choice="Opensky-Network"
        ;;
        5) choice="AdsbExchange"
        ;;
        6) choice="AdsbHub"
        ;;
        *) choice="Invalid selection"
        ;;
    esac
}

function feeder_menu () {
    if [[ $choice == "$pc" || $choice == "$frc" || $choice == "$rbc" || $choice == "Opensky-Network" || $choice == "AdsbExchange" || $choice == "AdsbHub" ]]; then
        intro
        echo -e "\033[35mYou have selected : $choice\033[0m"
        echo ""
        echo -e "\033[33mSelect from the Following\033[0m"
        echo ""
        echo "0. Back to Main menu"
        echo ""
        echo "1 - Install"
        echo ""
        echo "2 - uninstall"
        echo ""
        echo "3 - Configure"
        echo ""
        echo "4 - Activity"
        echo ""
        read -p "Enter the number of the action you want to perform: " number
        echo ""
        if [[ $number == 0 ]]; then
            prime
        fi
    fi
}


INT2="\033[33m  Streamline your aviation setup with one simple installation\033[0m"
INT="   
          
           _                _           
     /\   (_)              (_)          
    /  \   _ _ __ ___ _ __  _ _ __ ___  
   / /\ \ | | '__/ __| '_ \| | '__/ _ \ 
  / ____ \| | |  \__ \ |_) | | | |  __/ 
 /_/    \_\_|_|  |___/ .__/|_|_|  \___| 
                     | |                
                     |_|                

"
name="                   Developed by Arcticfox"
line="********************************************************************************"
v="                             Version 1.0"

function intro () {
		    clear
		    echo "$line" 
		    echo -e "$INT"
		    echo -e "$v"
		    echo ""
		    sleep 0.5
		    echo -e "$INT2"
		    sleep 0.5
		    echo ""
		    echo "$line" 
		    echo -e ""
}

function boot_intro () {
		    clear
		    echo "$line" 
		    echo -e "\033[31m$INT\033[0m"
		    echo -e "\033[35m$name\033[0m"
		    echo ""
		    echo "$line"
		    sleep 0.6
		    clear
		    echo "$line"
		    echo -e "\033[32m$INT\033[0m"
		    echo -e "\033[34m$name\033[0m"
		    echo ""
		    echo "$line"
		    sleep 0.6
		    clear
		    echo "$line"
		    echo -e "\033[33m$INT\033[0m"
		    echo -e "\033[33m$name\033[0m"
		    echo ""
		    echo "$line"
		    sleep 0.6
		    clear
		    echo "$line"
		    echo -e "\033[34m$INT\033[0m"
		    echo -e "\033[32m$name\033[0m"
		    echo ""
		    echo "$line"
		    sleep 0.6
		    clear
		    echo "$line"
		    echo -e "\033[35m$INT\033[0m"
		    echo -e "\033[31m$name\033[0m"
		    echo ""
		    echo "$line"
		    sleep 0.6
		    clear
}

function prime () {
		    intro
		    main
		    feeder_menu
		    piaware_install
		    fr24_install
		    rbfeeder_install
}

boot_intro
prime 

777777777777777777777777

This script is only for educational purposes. Be good boyz&girlz!
Use it only on your own networks!!





A graphical X windows system has been detected but airgeddon was unable to detect resolution. Try executing "xhost +" command before launching airgeddon. If it does not work, probably your system is missing one of these two commands "loginctl", "xdpyinfo". Install the needed packages and then try again. For the first one, package name is systemd, for the second one there are some possibilities (it may vary depending on your Linux distribution). Some suggested package names are: x11-utils, xdpyinfo or xorg-xdpyinfo

*********************************** Exiting ************************************
Exiting airgeddon script v11.11 - See you soon! :)

Checking if cleaning/restoring tasks are needed...
No tasks to perform on exit





























######################################################

#/usr/local/bin/

#1.Update and Upgrade - ✅

function update () {
			sudo apt update && sudo apt upgrade -y
}

#2.RaspBerry Pi Graphical UI Installation - ✅ ( Piaware only )
function gui () {
                  sudo apt install xserver-xorg -y
                  sleep 6
                  sudo apt install raspberrypi-ui-mods -y
                  sleep 6
                  clear
                  sudo apt install -y raspberrypi-kernel-headers bc build-essential dkms git
}

#3.ModesMixer2 Installation - ✅ ( raspberry [ARM] ) 
function armm2 () {
                  cd ~
                  sudo wget "https://www.dropbox.com/s/mi1wijxgq9n7nt4/mm2.zip?dl=0"
                  sleep 3
                  sudo unzip 'mm2.zip?dl=0'
                  sleep 3
		  sudo rm 'mm2.zip?dl=0'
                  cd mm2/
		  sudo chmod +x mm2.sh
		  sudo chmod +x modesmixer2
		  sleep 2
		  cd ~
		  user=$(who | awk '{print $1}' | sort | uniq)
		  cat <(crontab -l) <(echo "* * * * * /home/$user/mm2/mm2.sh >/dev/null 2>&1") | crontab -
}

#3A.ModesMixer2 Installation - X (raspberry [docker])
function docmm2 () {
		     sudo mkdir 
#cd my-docker-project

# Create a Docker Compose file with the specified settings
#cat > docker-compose.yml <<EOF
#version: "3"

services:
  piaware:
    image: navikey/raspbian-buster
    command: sleep infinity
    privileged: true
    restart: unless-stopped
    ports:
      - "8088:8080"
      - "30009:30009"
    volumes:
      - "/home/admin/doc:/home"
EOF

# Run the Docker Compose file
docker-compose up -d


#RadarBox Installation - NO
function mm2 () {
                  cd ~
                  sudo bash -c "$(wget -O - http://apt.rb24.com/inst_rbfeeder.sh)"
		  sudo wget "https://www.dropbox.com/s/jk3vhwh4tcy6bu7/rbfeeder.zip?dl=0"
		  sudo unzip 'rbfeeder.zip?dl=0'
		  sudo rm -r 'rbfeeder.zip?dl=0'
		  sudo mv rbfeeder.ini /etc/
		  update
		  sudo systemctl restart rbfeeder
}

######################################################

#Beast - RTL X Piaware
function beast_rtl_piaware () {
				if grep -q "receiver-type rtl-sdr" /boot/piaware-config.txt; then
  echo "✔ receiver-type is set to rtl-sdr"
else
  echo "✘ receiver-type is not set to rtl-sdr"
fi


#sed -i 's/external_host=127.0.0.1/external_host=$ip/g' /etc/rbfeeder.ini
#sed -i 's/external_host=127.0.0.1/external_host=<new_ip_address>/g' /etc/rbfeeder.ini
