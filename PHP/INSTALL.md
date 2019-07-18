# PHP的安装说明与配置  

## 1. PHP安装 apache(httpd)
	yum install libxml2-devel 
	wget http://php.net/distributions/php-7.2.6.tar.gz
	
	tar -zxf php-7.2.6.tar.gz
	cd php-7.2.6
	
	export PHP_OPENSSL_DIR=yes

	./configure --prefix=/usr/local/php \
	--with-apxs2=/usr/local/apache/bin/apxs \
	--with-config-file-path=/usr/local/php/etc \
	--with-mysqli=/usr/local/mariadb/bin/mysql_config \
	--with-openssl-dir=/usr/include/openssl \
	--disable-fileinfo \
	--enable-mbstring 
	
	
	make -j4
	make install

## 2. PHP扩展安装 mysqli扩展
	cd ext/mysqli
	/usr/local/php/bin/phpize 
	mkdir ext
	cp -r ../mysqlnd ext/
	cp /usr/local/mariadb/include/mysql/server/*.h .
	cp -r /usr/local/mariadb/include/mysql/server/mysql .
	
	
	./configure --with-php-config=/usr/local/php/bin/php-config \
	--with-mysqli=/usr/local/mariadb/bin/mysql_config \
	--with-mysql-sock=/usr/local/mariadb/mariadb.sock 
	
	
	make -j4
	make install

#	段错误

#####	 开启core dump 
	ulimit -c unlimited 
#####	重新运行代码，输出：段错误 (core dumped)，同时生成core dump文件
	php index.php
####	使用gdb调试coredump文件
	gdb php -c core.[\d]+
	(gdb) bt
	