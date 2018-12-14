# MariaDB 的操作手册
##	新建数据库
	create database db_name;
	create database if not exists db_name default charset utf8 collate utf8_general_ci;	
	create database if not exists db_name default charset gbk collate gbk_chinese_ci;
##	新建数据库用户 用户授权 回收用户权限
	数据库新建用户 第2种方式是用户授权 同时创建用户（如果用户不存在）
	1.create user 'db_user'@'localhost' identified by '123456';
	2.grant all on db_name.* to 'db_user'@'%' identified by '123456';
	3.insert into mysql.user(user,host,password) values('db_user','%',password('123456'));
	flush privileges;
	
	回收用户权限
	revoke all on db_name.* to 'db_user'@'%';
	flush privileges;
	
##	新建数据库表
	create table if not exists table_name(
		id int not null primary key auto_increment comment '自增主键',
		name varchar(32) null comment '姓名字段',
		index name(name)
	)default charset=utf8 auto_increment=1;
