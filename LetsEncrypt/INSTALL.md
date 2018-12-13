# Let's Encrypt证书申请及与Apache服务器整合配置

##### 获取Certbot工具
	git clone https://github.com/letsencrypt/letsencrypt
	cd letsencrypt
	./certbot-auto --help all
	
##### Certbot命令 申请通配符证书 以DNS域名TXT解析方式验证你的域名所有权
	./certbot-auto certonly  -d *.lanhuispace.com --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory 
	
* certonly，表示安装模式
* --manual 表示手动安装插件
* -d 主机名（为哪个主机申请证书，通配符用[*.主机名]）
* --preferred-challenges dns，使用 DNS 方式校验域名所有权
* --server，Let's Encrypt ACME v2 版本使用的服务器不同于 v1 版本，需要显示指定。

