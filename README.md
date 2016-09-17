# home_nat_script
home nat script


For Linux
NOTE!

Change and put iptables.up.rules into /etc/network/iptables.up.rules!!!

Run "sudo iptables-apply"

Or add following to /etc/rc.local:

    echo '1' > /proc/sys/net/ipv4/ip_forward
    iptables -F
    iptables -A FORWARD -j ACCEPT
    #iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o wlan1 -j SNAT --to-source 192.168.182.8
    iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o wlan0 -j MASQUERADE
    exit 0

Fan control operations are disabled by default for safety reasons.

To enable fan control, the module parameter fan_control=1 must be given to thinkpad-acpi.

For example, in Ubuntu 8.04 (Hardy Heron), add the following to /etc/modprobe.d/options: options thinkpad_acpi fan_control=1

For Debian Squeeze (testing) create /etc/modprobe.d/thinkpad_acpi.conf with: options thinkpad_acpi fan_control=1 and install the package thinkfan

Having done so, reboot and you can use the following commands to control fan speed:

# echo level 0 > /proc/acpi/ibm/fan (fan off)

# echo level 2 > /proc/acpi/ibm/fan (low speed)

# echo level 4 > /proc/acpi/ibm/fan (medium speed)

# echo level 7 > /proc/acpi/ibm/fan (maximum speed)

# echo level auto > /proc/acpi/ibm/fan (automatic - default)

# echo level disengaged > /proc/acpi/ibm/fan (disengaged) 
