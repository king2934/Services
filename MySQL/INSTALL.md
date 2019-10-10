#	MySQL 数据库的安装说明与配置

#####	下载并解压，进入目录
	wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.27.tar.gz
	tar -zxvf mysql-5.7.27.tar.gz
	cd mysql-5.7.27
#####	cmake 编译配置
	cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr/local/mysql5727 \
	-DSYSCONFDIR=/usr/local/mysql5727/etc \
	-DMYSQL_DATADIR=/usr/local/mysql5727/data \
	-DMYSQL_UNIX_ADDR=/usr/local/mysql5727/mysql5727.sock \
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
	-DWITHOUT_TOKUDB=1 \
	-DDOWNLOAD_BOOST=1 -DWITH_BOOST=boost
	
	make -j4
	make install
	
#####	初始化数据库	

	/usr/local/mysql5727/scripts/mysql_install_db \
	--user=mysql \
	--defaults-file=/usr/local/mysql5727/etc/my.cnf \
	--defaults-extra-file=/usr/local/mysql5727/etc/my.cnf \
	--basedir=/usr/local/mysql5727 \
	--datadir=/usr/local/mysql5727/data 

	chown -R mysql:mysql /usr/local/mysql5727

#End