# MSSQLServer（MicroSoft Structured Query Language Server）
# 微软数据库 重置密码操作

	net stop mssqlserver
	
	net start mssqlserver /m
	
	sqlcmd -S 服务器主机名 -E
	
	1> alter login sa enable
	2> go
	
	1> alter login sa with password='123456'
	2> go
	
	1> exit
	
	net stop mssqlserver
	net start mssqlserver

#### 正常sa登录密码123456	
#
#	End
	
	
	