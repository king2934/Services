#	Tomcat 9 安装

	wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-9/v9.0.26/bin/apache-tomcat-9.0.26.zip
	unzip apache-tomcat-9.0.26.zip
	
	mv apache-tomcat-9.0.26 /usr/local/tomcat
	cd /usr/local/tomcat
	bin/startup.sh //启动 | 停止 bin/shutdown.sh
	
###	配置文件 server.xml

#####	端口为 8080
	<Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />
	
#####	https 端口为 8443
	<Connector
		protocol="org.apache.coyote.http11.Http11AprProtocol"
		port="8443" maxThreads="200"
		scheme="https" secure="true" SSLEnabled="true"
		SSLCertificateFile="/etc/letsencrypt/live/lanhuispace.com/fullchain.pem"
		SSLCertificateKeyFile="/etc/letsencrypt/live/lanhuispace.com/privkey.pem"
		SSLVerifyClient="optional" SSLProtocol="TLSv1+TLSv1.1+TLSv1.2"/>

##### 开启 SSL （https） 
	<Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
	
	
#END 结束