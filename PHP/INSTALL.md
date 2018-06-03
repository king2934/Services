# PHP的安装说明与配置  

## 1. PHP单独安装
	yum install libxml2-devel 
	wget http://php.net/distributions/php-7.2.6.tar.gz
	
	tar -zxf php-7.2.6.tar.gz
	cd php-7.2.6
	
	./configure --prefix=/usr/local/php \
	--with-apxs2=/usr/local/apache/bin/apxs \
	--with-config-file-path=/usr/local/php/etc
	
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