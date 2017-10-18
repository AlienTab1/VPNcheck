#!/bin/sh


vpn_starak=172.30.8.1
vpn_brno=172.30.4.1


echo "VPN master watchdog script"

#Ping vpn tunnels

ping -4 -c 10 -W 5 $vpn_starak
result=$?
echo "VPN starak result= $result"

if test $result -ne 0
then
	logger -p "news.info" -t "vpn_watchdog" VPN starak ping timeout !
	/etc/init.d/openvpn restart
fi

ping -4 -c 10 -W 5 $vpn_brno
result=$?
echo "VPN brno result= $result"

if test $result -ne 0
then
	logger -p "news.info" -t "vpn_watchdog" VPN brno ping timeout !
	/etc/init.d/openvpn restart
fi
logger -p "news.info" -t "vpn_watchdog" VPN ping check OK !
exit
