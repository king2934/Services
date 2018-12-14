# MariaDB 的说明文件 安装说明请查看INSTALL.md
##	新建数据库
	create database db_name;
	create database if not exists db_name default charset utf8 collate utf8_general_ci;	
	create database if not exists db_name default charset gbk collate gbk_chinese_ci;
	