Canal 安装与配置 全过程 测试平台 阿里云 ecs 
#Start	开始

###	一. 安装JDK

######	1.1. 查看可用的JDK软件包列表
	yum search java | grep -i --color JDK
	
######	1.2. 选择合适的版本
	yum install java-1.8.0-openjdk-devel.x86_64

#####	1.3. 配置环境变量
	vi /etc/profile
		export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.71-2.b15.el7_2.x86_64
		export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
		export PATH=$PATH:$JAVA_HOME/bin
	
	source /etc/profile

###	二. 安装并启动Canal-server
#####	2.1. 下载并解压Canal-deployer
	wget https://github.com/alibaba/canal/releases/download/canal-1.1.4/canal.deployer-1.1.4.tar.gz
	tar -zxvf canal.deployer-1.1.4.tar.gz
	
#####	2.2. 配置文件
	vi conf/example/instance.properties
		canal.instance.master.address=127.0.0.1:3306
		canal.instance.dbUsername=canal
		canal.instance.dbPassword=canal
		
#####	2.2. 启动并查看日志

	./bin/startup.sh
	
	cat logs/canal/canal.log

	
#END 结束