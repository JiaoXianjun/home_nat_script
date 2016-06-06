%function network_auto_script
% this script must be run as root!

wait_connect_countdown = 0; % should be connect in 1 min
system('echo y | sudo iptables-apply');
sleep(1);
system('echo y | sudo iptables-apply');

while 1
	sleep(1);
	
	ip = get_ip('wlan2');
	if ip == -1
		if  wait_connect_countdown == 0
			% disable network
			system('nmcli nm enable false');
			disp('nmcli nm enable false');
			sleep(3);
			
			% enable network
			system('nmcli nm enable true');
			disp('nmcli nm enable true');
			sleep(1);
			
			system('nmcli nm wifi on');
			disp('nmcli nm wifi on');
			%sleep(3);
			%system('nmcli d wifi connect PROXIMUS_FON iface wlan2');
			%disp('nmcli d wifi connect PROXIMUS_FON iface wlan2');
			
			% set wait count down
			wait_connect_countdown = 45; 
			
			continue;
		else
			wait_connect_countdown = wait_connect_countdown - 1;
			disp(['wait_connect_countdown ' num2str(wait_connect_countdown)]);
			continue;
		end
	end
	
	wait_connect_countdown = 0;
	
	ip_in_rules = read_iptables_rules('/etc/network/iptables.up.rules');
	if ~strcmpi(ip_in_rules, ip)
		write_iptables_rules('/etc/network/iptables.up.rules', ip);
		sleep(1);
		system('echo y | sudo iptables-apply');
		disp(['Change IP from ' ip_in_rules ' to ' ip]);
	else
		disp([ip_in_rules ' = ' ip '. Will not update iptables.']);
	end
end
