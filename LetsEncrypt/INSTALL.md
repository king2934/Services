# Let's Encrypt证书申请及与Apache服务器整合配置

##### 获取Certbot工具
	git clone https://github.com/letsencrypt/letsencrypt
	cd letsencrypt
	./certbot-auto --help all
	
##### Certbot命令 申请通配符证书 以DNS域名TXT解析方式验证你的域名所有权
	./certbot-auto certonly  -d *.lanhuispace.com --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory 
	
*	certonly，表示安装模式
*	--manual 表示手动安装插件
*	-d 主机名（为哪个主机申请证书，通配符用[*.主机名]）
*	--preferred-challenges dns，使用 DNS 方式校验域名所有权
*	--server，Let's Encrypt ACME v2 版本使用的服务器不同于 v1 版本，需要显示指定。
	
	(A)gree/(C)ancel: A
	
	Are you OK with your IP being logged?
	(Y)es/(N)o: y
	
	上述有两个交互式的提示
	确认同意才能继续

#####	要注意以下画面时不要操作 完成【验证步骤】后回车
	-------------------------------------------------------------------------------
	Please deploy a DNS TXT record under the name
	_acme-challenge.lanhuispace.com with the following value:

	69JC26cO8JaZDPhwSsVtumYEOcuT7-1nMHi1_SFVH2A

	Before continuing, verify the record is deployed.
	-------------------------------------------------------------------------------
	Press Enter to Continue
	Waiting for verification...
	Cleaning up challenges
#####	验证步骤 1 添加一条DNS解析 以验证你对此域名的所有权
<div>
	<table border="0">
		<tr>
			<td>记录类型</td>
			<td>主机记录</td>
			<td>记录值</td>
		</tr>
		<tr>
			<td>TXT</td>
			<td>_acme-challenge</td>
			<td>69JC26cO8JaZDPhwSsVtumYEOcuT7-1nMHi1_SFVH2A</td>
		</tr>
	</table>
</div>

#####	验证步骤 2 在完成【验证步骤 1】后 验证是否生效 windows 下cmd 命令窗口
	windows 下cmd 命令窗口
	
	nslookup -q=txt _acme-challenge.lanhuispace.com
	
	非权威应答:
	_acme-challenge.lanhuispace.com text =

        "69JC26cO8JaZDPhwSsVtumYEOcuT7-1nMHi1_SFVH2A"

	
#####	【验证步骤】结束

	