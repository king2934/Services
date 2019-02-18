#	SSR+BBR安装
	
#####	安装步骤

	wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
	chmod +x shadowsocks-all.sh
	./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
		

#####	卸载方法

	./shadowsocks-all.sh uninstall
	
#####	启动脚本	

	/etc/init.d/shadowsocks-r start | stop | restart | status
	
#####	配置文件	
	/etc/shadowsocks-r/config.json
	
	{
		"server":"0.0.0.0",
		"local_address":"127.0.0.1",
		"local_port":1080,
		"port_password":{
			"2018":"password",
			"2019":"password",
			"2020":"password"
		},
		"timeout":120,
		"method":"chacha20-ietf",
		"protocol":"origin",
		"protocol_param":"",
		"obfs":"http_simple_compatible",
		"obfs_param":"",
		"redirect":"",
		"dns_ipv6":false,
		"fast_open":false,
		"workers":1
	}

#####	开放端口

	firewall-cmd --zone=public --add-port=2018/tcp --permanent
	firewall-cmd --zone=public --add-port=2019/tcp --permanent
	firewall-cmd --zone=public --add-port=2020/tcp --permanent
	firewall-cmd --reload

#####	一键安装最新内核并开启 BBR 脚本
	
	wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

#####	End 重启电脑
