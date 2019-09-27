#	Tomcat 9 安装

###	一、安装 apr
	wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-1.7.0.tar.gz
	tar -zxvf apr-1.7.0.tar.gz
	cd apr-1.7.0
	./configure --prefix=/usr/local/apr
	make && make install
	
###	二、安装 apr-util
	wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-util-1.6.1.tar.gz
	tar -zxvf apr-util-1.6.1.tar.gz
	cd apr-util-1.6.1
	./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr
	make && make install
	
###	三、安装	tomcat-native
	wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-connectors/native/1.2.23/source/tomcat-native-1.2.23-src.tar.gz
	tar -zxvf tomcat-native-1.2.23-src.tar.gz
	cd tomcat-native-1.2.23-src/native
	./configure --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util
	make && make install
	
	
###	四、安装	tomcat 9
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
	
##### 配置基于域名的虚拟主机
	<Host name="java.lanhuispace.com"  appBase="webapps" unpackWARs="true" autoDeploy="true">
		<Alias>java.lanhuispace.com</Alias>
		<Alias>www.java.lanhuispace.com</Alias>
		<Context path="" docBase="/usr/local/apache/htdocs/www/java.lanhuispace.com" debug="0" reloadable="false" crossContext="true"/> 
		<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
			prefix="java_lanhuispace_com_access_log" suffix=".txt"
			pattern="%h %l %u %t &quot;%r&quot; %s %b" />
	</Host>
	
#END 结束