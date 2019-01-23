### MSSQLServer（MicroSoft Structured Query Language Server）
# 微软数据库 重置密码操作
##### CMD 窗口

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

#####	恢复windows验证登录sqlserver方式 sa 登录  执行以下SQL
	exec sp_grantlogin '主机名\Administrator'
	exec sp_addsrvrolemember '主机名\Administrator','sysadmin'
#
#	End
	
	
	