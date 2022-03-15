#!/bin/bash
# Author: Ahmad Abdolmaleki (ahmadubuntu)
# Download Address: github.com/ahmadubuntu/uburmovaghat
# Version: 1.0

function check_current_dns () {
	echo "Current DNS settings are:"
	echo "=============================================================================="
	grep -v "^#" /etc/resolv.conf | grep  '[^[:space:]]'
	echo "=============================================================================="

    shecan_is_enable=$(grep '185.51.200.2' /etc/resolv.conf 2>&1 >> /dev/null || grep '178.22.122.100' /etc/resolv.conf 2>&1 >> /dev/null ; echo $?)
	begzar_is_enable=$(grep '185.55.226.25' /etc/resolv.conf 2>&1 >> /dev/null || grep '185.55.226.26' /etc/resolv.conf 2>&1 >> /dev/null ; echo $?)
	if [ $shecan_is_enable -eq 0 ] ; then
		echo "It seems that you are using Begzar DNS Service."
	elif [ $begzar_is_enable -eq 0 ] ; then
                echo "It seems that you are using Begzar DNS Service."
	else
		echo "It seems that you are using default system or DHCP dns settings."
	fi
}

function set_dns () {
        dnss=$1
	while true
	do
		case $dnss in
			1)
				echo "restoring your default dns settings ..." 
				sudo cp /etc/resolv.conf.backup /etc/resolv.conf
				sudo rm -f /etc/resolv.conf.backup
				echo "Job done. Nice to meet you, $USER."
				break	
    		    ;;
			2)
			    echo "shecan is enabling ..."
			    sudo cp /etc/resolv.conf /etc/resolv.conf.backup
			    echo "nameserver 185.51.200.2"   | sudo tee /etc/resolv.conf > /dev/null
			    echo "nameserver 178.22.122.100" | sudo tee -a /etc/resolv.conf > /dev/null
				echo "Job done. Nice to meet you, $USER."
				break
				;;
			3)
                echo "Begzar is enabling ..."
                sudo cp /etc/resolv.conf /etc/resolv.conf.backup
                echo "nameserver 185.55.226.26"   | sudo tee /etc/resolv.conf > /dev/null
                echo "nameserver 185.55.226.25"   | sudo tee -a /etc/resolv.conf > /dev/null
				echo "Job done. Nice to meet you, $USER."
				break
                ;;
			q|Q)
				echo "OK, but why you called me?!"
				echo "Nice to meet you, $USER" 
				break
				;;
			*)
				echo 'Please insert one of the above options:' 
				read dnss
				;;
		esac
	done
}


check_current_dns

echo -e "Please insert the number of one of these options: \n 1) DHCP' DNS \n 2) Shecan  \n 3) Begzar \n q|Q) Quit"
read sdi

set_dns $sdi


