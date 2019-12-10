# PHP的安装说明与配置  

## 1. PHP安装 apache(httpd)
	yum install libxml2-devel 
	wget http://php.net/distributions/php-7.4.0.tar.gz
	
	tar -zxf php-7.4.0.tar.gz
	cd php-7.4.0
	
	export PHP_OPENSSL_DIR=yes

	./configure --prefix=/usr/local/php \
	--with-apxs2=/usr/local/apache/bin/apxs \
	--with-config-file-path=/usr/local/php/etc \
	--with-openssl-dir=/usr/include/openssl \
	--enable-mbstring 
	
	
	make -j4
	make install

## 2. PHP扩展安装 mysqli扩展
	cd ext/mysqli
	/usr/local/php/bin/phpize 
	mkdir ext
	cp -r ../mysqlnd ext/
#####	mariadb 10.3.11
	cp /usr/local/mariadb/include/mysql/server/*.h .
	cp -r /usr/local/mariadb/include/mysql/server/mysql .
#####	mariadb 10.4.10 增加部分
	cp -r /usr/local/mariadb/include/mysql/server/private/*.h .
	cp -r /usr/local/mariadb/include/mysql/server/private/atomic .
	
	
	./configure --with-php-config=/usr/local/php/bin/php-config \
	--with-mysqli=/usr/local/mariadb/bin/mysql_config \
	--with-mysql-sock=/usr/local/mariadb/mariadb.sock 
	
	
	make -j4
	make install

#	段错误 Segmentation fault

#####	 开启core dump 
	ulimit -c unlimited 
#####	重新运行代码，输出：段错误 (core dumped)，同时生成core dump文件
	php index.php
####	使用gdb调试coredump文件
	gdb php -c core.[\d]+
	(gdb) bt
	