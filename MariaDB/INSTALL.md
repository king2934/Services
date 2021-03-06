# mariadb数据库的安装说明与配置  
	yum -y install wget gcc gcc-c++ cmake ncurses ncurses-devel bison
	
	groupadd mariadb
	useradd -s /sbin/nologin -M -g mariadb mariadb
	
	mkdir /usr/local/mariadb
	mkdir /usr/local/mariadb/etc
	mkdir /usr/local/mariadb/data
	chown -R mariadb:mariadb /usr/local/mariadb
	
	vi /usr/local/mariadb/etc/my.cnf
		[mysqld]
		user    =mariadb
		port    =3306
		basedir =/usr/local/mariadb
		datadir =/usr/local/mariadb/data
		socket  =/usr/local/mariadb/mariadb.sock
		
		[mysqld_safe]
		log-error=/usr/local/mariadb/logs/mariadb.log
		pid-file=/usr/local/mariadb/mariadb.pid
	
	wget https://mirrors.shu.edu.cn/mariadb/mariadb-10.3.7/source/mariadb-10.3.7.tar.gz
	tar -zxf mariadb-10.3.7.tar.gz
	cd mariadb-10.3.7
	
	cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr/local/mariadb \
	-DSYSCONFDIR=/usr/local/mariadb/etc \
	-DMYSQL_DATADIR=/usr/local/mariadb/data \
	-DMYSQL_UNIX_ADDR=/usr/local/mariadb/mariadb.sock \
	-DWITH_ARIA_STORAGE_ENGINE=1 \
	-DWITH_XTRADB_STORAGE_ENGINE=1 \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DWITH_FEDERATED_STORAGE_ENGINE=1 \
	-DEXTRA_CHARSETS=all \
	-DDEFAULT_CHARSET=utf8 \
	-DDEFAULT_COLLATION=utf8_general_ci \
	-DWITH_READLINE=1 \
	-DWITH_EMBEDDED_SERVER=1 \
	-DENABLED_LOCAL_INFILE=1 \
	-DWITHOUT_TOKUDB=1
	
	make -j4
	make install
	
	/usr/local/mariadb/scripts/mysql_install_db \
	--user=mariadb \
	--defaults-file=/usr/local/mariadb/etc/my.cnf \
	--defaults-extra-file=/usr/local/mariadb/etc/my.cnf \
	--basedir=/usr/local/mariadb \
	--datadir=/usr/local/mariadb/data 
	
	chown -R mariadb:mariadb /usr/local/mariadb
	
#	systemctl
	
	vi /etc/systemd/system/mariadb.service
	
		[Unit]
		Description=The MariaDB Database Server

		[Service]
		Type=simple
		ExecStart=/usr/local/mariadb/bin/mysqld_safe --defaults-file=/usr/local/mariadb/etc/my.cnf 
		ExecStop=/bin/kill -WINCH ${MAINPID}

		[Install]
		WantedBy=multi-user.target
		
#	主从配置
###	master节点
#####	my.cnf
	[mysqld]
	log-bin=mysql-bin-master          #启用二进制日志
	server-id=1                       #本机数据库ID 标示
	binlog-do-db=zn                   #可以被从服务器复制的库, 二进制需要同步的数据库名
	binlog-ignore-db=mysql            #不可以被从服务器复制的库
#####	SQL
	grant replication slave on *.* to slave@'%'  identified by "123456";
	show master status;
	
	mysqldump -uroot -ppass 要导出数据库名 > databak.sql
	
###	slave节点
#####	my.cnf
	[mysqld]
	server-id=2
#####	SQL
	show variables like '%version%';
	mysql -uslave -p123456 -h ip地址
	
	mysql -uroot -ppass 要入的数据库名 < databak.sql
	
#####	库中执行
	stop slave;
	change master to master_host='ip地址',master_user='slave',master_password='123456';
	start slave;
	
#	主从不同步修复
###	master节点 查看bin-log的位置
	show master status; 
	show binlog events\G
###	slave节点
#####	根据show master status的结果，二进制数据库记录回归
	stop slave;
	change master to master_log_file='mysql-bin-master.000002',master_log_pos=245;
	slave start;
	show slave status\G
		Slave_IO_Running: Yes #yes代表已在同步
		Slave_SQL_Running: Yes
	