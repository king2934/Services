# 安装
	
	chmod +x shadowsocks.sh
	./shadowsocks.sh 2>&1 | tee shadowsocks.log
	

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