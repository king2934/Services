# 安装说明
	yum install -y autoconf libtool expat-devel openssl openssl-devel
	wget http://mirrors.tuna.tsinghua.edu.cn/apache//httpd/httpd-2.4.33.tar.gz
	wget http://mirrors.hust.edu.cn/apache//apr/apr-1.6.3.tar.gz
	wget http://mirrors.hust.edu.cn/apache//apr/apr-util-1.6.1.tar.gz

	tar -zxf httpd-2.4.33.tar.gz 
	tar -zxf apr-1.6.3.tar.gz 
	tar -zxf apr-util-1.6.1.tar.gz 
	
	mv apr-1.6.3 httpd-2.4.33/srclib/apr
	mv apr-util-1.6.1 httpd-2.4.33/srclib/apr-util
	
	cd httpd-2.4.33/
	./buildconf
	
	./configure --prefix=/usr/local/apache/  --enable-so  --enable-ssl --with-mpm=event  --with-included-apr
	make 
	make install
	
	vi /etc/profile.d/httpd.sh
		pathmunge /usr/local/apache/bin
	
	vi /etc/systemd/system/httpd.service
		[Unit]
		Description=The Apache HTTP Server
		After=network.target

		[Service]
		Type=forking
		ExecStart=/usr/local/apache/bin/apachectl -k start
		ExecReload=//usr/local/apache/bin/apachectl -k graceful
		ExecStop=/usr/local/apache/bin/apachectl -k graceful-stop
		PIDFile=/usr/local/apache/logs/httpd.pid
		PrivateTmp=true

		[Install]
		WantenBy=multi-user.target
		
	systemctl daemon-reload
	systemctl start httpd
	systemctl enable httpd
	