#!/bin/ash
ifconfig eth0 up
udhcpc -i eth0 -s /etc/udhcpc/sample.script
ping 192.168.11.55
