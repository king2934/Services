# MariaDB数据库的安装说明与配置  
	yum -y install wget gcc gcc-c++ cmake ncurses ncurses-devel bison
	
	groupadd mariadb
	useradd -s /sbin/nologin -M -g mariadb mariadb
	
	mkdir /usr/local/MariaDB
	mkdir /usr/local/MariaDB/etc
	mkdir /usr/local/MariaDB/data
	chown -R mariadb:mariadb /usr/local/MariaDB/data
	
	vi /usr/local/MariaDB/etc/my.cnf
		[mysqld]
		user    =mariadb
		port    =3306
		basedir =/usr/local/MariaDB
		datadir =/usr/local/MariaDB/data
		socket  =/usr/local/MariaDB/mariadb.sock
		
		[mysqld_safe]
		log-error=/usr/local/MariaDB/logs/mariadb.log
		pid-file=/usr/local/MariaDB/mariadb.pid
	
	wget https://mirrors.shu.edu.cn/mariadb/mariadb-10.3.7/source/mariadb-10.3.7.tar.gz
	tar -zxf mariadb-10.3.7.tar.gz
	cd mariadb-10.3.7
	
	cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr/local/MariaDB \
	-DSYSCONFDIR=/usr/local/MariaDB/etc \
	-DMYSQL_DATADIR=/usr/local/MariaDB/data \
	-DMYSQL_UNIX_ADDR=/usr/local/MariaDB/mysql.sock \
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
	
	make 
	make install
	
	/usr/local/MariaDB/scripts/mysql_install_db \
	--user=mariadb \
	--defaults-file=/usr/local/MariaDB/etc/my.cnf \
	--defaults-extra-file=/usr/local/MariaDB/etc/my.cnf \
	--basedir=/usr/local/MariaDB \
	--datadir=/usr/local/MariaDB/data 
	
	chown -R mariadb:mariadb /usr/local/MariaDB