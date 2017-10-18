#!/bin/sh


vpn_1= #IP cliant address
vpn_2= #IP client address 


echo "VPN master watchdog script"

#Ping vpn tunnels

ping -4 -c 10 -W 5 $vpn_1
result=$?
echo "VPN 1 result= $result"

if test $result -ne 0
then
	logger -p "news.info" -t "vpn_watchdog" VPN 1 ping timeout !
	/etc/init.d/openvpn restart
fi

ping -4 -c 10 -W 5 $vpn_2
result=$?
echo "VPN 2 result= $result"

if test $result -ne 0
then
	logger -p "news.info" -t "vpn_watchdog" VPN 2 ping timeout !
	/etc/init.d/openvpn restart
fi
logger -p "news.info" -t "vpn_watchdog" VPN ping check OK !
exit
