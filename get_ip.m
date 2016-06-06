
function ip  = get_ip(iface_str)
	[status, text] = system(['ifconfig ' iface_str]);
	if status ~= 0 % exe failed!
		disp('get_ip system failed.');
		ip = -1;
		return;
	end
	%disp('get_ip ifconfig succeedded.');
	
	ip_str_start = strfind(text, 'inet addr:');
	if isempty(ip_str_start)
		disp('get_ip can not find ip.');
		ip = -1;
		return;
	end
	
	ip_str_start = ip_str_start + 10;
	
	a = text(ip_str_start:(ip_str_start+18));
	ip_str_end = strfind(a, ' ');
	ip_str_end = ip_str_end(1)-1;
	
	%disp([ip_str_start ip_str_end]);
	ip = a(1:ip_str_end);
	
	