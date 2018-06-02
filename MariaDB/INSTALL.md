# MariaDB数据库的安装说明与配置  
	yum -y install wget gcc gcc-c++ cmake ncurses ncurses-devel bison
	
	groupadd mariadb
	useradd -s /sbin/nologin -M -g mariadb mariadb
	
	mkdir /usr/local/MariaDB
	mkdir /usr/local/MariaDB/etc
	mkdir /usr/local/MariaDB/data
	chown -R mariadb:mariadb /usr/local/MariaDB/data
	
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