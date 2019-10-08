VSFTPD vsftpd 安装与配置 全过程 测试平台 阿里云 ecs 
===================================
####	检查
	
	modprobe ppp-compress-18 && echo ok #返回OK
	zgrep MPPE /proc/config.gz #返回CONFIG_PPP_MPPE=y 或 =m
	cat /dev/net/tun #返回cat: /dev/net/tun: File descriptor in bad state
	以上三条命令满足一条即为支持PPTP
	
####	Start 开始安装

	yum update -y ppp pptpd epel-release
	
	vi /etc/pptpd.conf
		localip 192.168.0.1
		remoteip 192.168.0.101-199
		#remoteip 192.168.0.214,192.168.0.245
		
	
	vi  /etc/ppp/options.pptpd
		nologfd
		logfile /var/log/pptpd.log
		ms-dns 10.23.255.1
		ms-dns 10.23.255.2
		ms-dns 114.114.114.114
	
	vi /etc/ppp/chap-secrets
		user	servername	pass	ip
		user1	*	123456	*
		
	
	firewall-cmd --zone=public --add-port=1723/tcp --permanent
	firewall-cmd --reload
	
#####	可选
	
	vi /etc/sysctl.conf
		net.ipv4.ip_forward=1
	sysctl -p
	
#####	启动
	systemctl start pptpd
	
#####	开机启动

	systemctl enable pptpd
	
#END 结束