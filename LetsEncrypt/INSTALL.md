# Let's Encrypt证书申请及与Apache服务器整合配置

## 获取Certbot工具
	git clone https://github.com/letsencrypt/letsencrypt
	cd letsencrypt
	./certbot-auto --help all
	
## Certbot命令 申请通配符证书 以DNS域名TXT解析方式验证你的域名所有权
	./certbot-auto certonly  -d *.lanhuispace.com --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory 
