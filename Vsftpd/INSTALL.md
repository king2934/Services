VSFTPD vsftpd 安装与配置 全过程 测试平台 阿里云 ecs 
===================================
	[root@root ~]# lsb_release -a
		LSB Version:    :core-4.1-amd64:core-4.1-noarch
		Distributor ID: CentOS
		Description:    CentOS Linux release 7.5.1804 (Core) 
		Release:        7.5.1804
		Codename:       Core
		
#Start 开始安装

	yum update -y
	yum install -y wget bzip2 gcc 
	yum install -y openssl openssl-devel tcp_wrappers-devel
	yum install -y pam pam-devel db4 db4-devel libcap libcap-devel
	
	mkdir /usr/local/apache
	mkdir /usr/local/apache/htdocs	
	mkdir /usr/local/apache/htdocs/user1	
	mkdir /usr/local/apache/htdocs/user2
	mkdir /usr/local/vsftpd
	mkdir /usr/local/vsftpd/conf
	mkdir /usr/local/vsftpd/user_conf
	mkdir /usr/local/vsftpd/bin
	mkdir /usr/local/vsftpd/lib
	mkdir /usr/local/vsftpd/logs
	mkdir /usr/local/vsftpd/empty
	
	groupadd wwwftp
	useradd -g wwwftp wwwftp -d /usr/local/apache/htdocs/  -s /sbin/nologin
	chown -R wwwftp:wwwftp /usr/local/apache/htdocs
	chmod -R 700 /usr/local/vsftpd/empty
	chown -R wwwftp:wwwftp /usr/local/vsftpd/empty/
	
	vi /usr/local/vsftpd/chroot_list
		user1
		user2
		
	vi /usr/local/vsftpd/user_list
		user1
		user2
	
	cp /lib64/security/pam_userdb.so	/usr/local/vsftpd/lib	
	
	# http://wang.wshike.com/download/vsftpd-3.0.3.tar.gz
	wget https://security.appspot.com/downloads/vsftpd-3.0.3.tar.gz
	tar -zxf vsftpd-3.0.3.tar.gz
	cd vsftpd-3.0.3
	make
	cp vsftpd /usr/local/vsftpd/bin/vsftpd
	cp vsftpd.conf /usr/local/vsftpd/conf/vsftpd.conf
	vi /usr/local/vsftpd/conf/vsftpd.conf
	
	vi /usr/local/vsftpd/users.txt
		user1
		123456
		user2
		654321
	
	db_load -T -t hash -f /usr/local/vsftpd/users.txt  /usr/local/vsftpd/users.db
	
	/usr/local/vsftpd/bin/vsftpd  /usr/local/vsftpd/conf/vsftpd.conf &
	
	firewall-cmd --zome=public --add-port=20-21/tcp --permanent
	firewall-cmd --zome=public --add-port=10060-10090/tcp --permanent
	firewall-cmd --reload
	
#END 结束