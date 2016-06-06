function write_iptables_rules(filename, ip)
	fid = fopen(filename, 'w');
	if fid == -1
		disp('write_iptables_rules fopen failed!');
		return;
	end
	
	fprintf(fid, '*nat\n');
	fprintf(fid, ':PREROUTING ACCEPT [619:46668]\n');
	fprintf(fid, ':INPUT ACCEPT [77:5275]\n');
	fprintf(fid, ':OUTPUT ACCEPT [552:35286]\n');
	fprintf(fid, ':POSTROUTING ACCEPT [552:35286]\n');
	fprintf(fid, '-A POSTROUTING -s 192.168.0.0/24 -o wlan2 -j SNAT --to-source %s\n', ip);
	
	fprintf(fid, 'COMMIT\n');
	fprintf(fid, '*filter\n');
	fprintf(fid, ':INPUT ACCEPT [4144:1002307]\n');
	fprintf(fid, ':FORWARD ACCEPT [0:0]\n');
	fprintf(fid, ':OUTPUT ACCEPT [3610:2892097]\n');
	fprintf(fid, '-A FORWARD -j ACCEPT\n');
	fprintf(fid, 'COMMIT\n');
	
		
	fclose(fid);
	