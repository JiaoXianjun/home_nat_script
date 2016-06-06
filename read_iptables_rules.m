function ip = read_iptables_rules(filename)
	fid = fopen(filename, 'r');
	if fid == -1
		disp('read_iptables_rules fopen failed!');
		ip = '0.0.0.0';
		return;
	end
	
	while 1
		line_text = fgetl(fid);
		if ~isempty(strfind(line_text, '-A POSTROUTING'))
			ip = line_text(63:end);
			break;
		end
	end
	
	fclose(fid);