# MariaDB 的操作手册
##	新建数据库
	create database db_name;
	create database if not exists db_name default charset utf8 collate utf8_general_ci;	
	create database if not exists db_name default charset gbk collate gbk_chinese_ci;
##	新建数据库用户 用户授权 回收用户权限
	grant all on db_name.* to 'db_user'@'%' identified by '123456';
	flush privileges;
	
	revoke all on db_name.* to 'db_user'@'%';
	flush privileges;
	

