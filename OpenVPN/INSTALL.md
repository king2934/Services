# 安装
	yum update -y
	yum install -y gcc gcc-c++ wget git automake autoconf openssl-devel openssl lzo lzo-devel pam-devel libtool net-tools
	
	wget -O openvpn-2.4.6.tar.gz https://github.com/OpenVPN/openvpn/archive/v2.4.6.tar.gz
	
	tar -zxvf openvpn-2.4.6.tar.gz
	cd openvpn-2.4.6
	
	autoreconf -i -v -f
	./configure --prefix=/usr/local/openVPN
	make
	make install
	
	wget -O easy-rsa-3.0.6.tar.gz https://github.com/OpenVPN/easy-rsa/archive/v3.0.6.tar.gz
	tar -zxvf easy-rsa-3.0.6.tar.gz
	cd easy-rsa-3.0.6
	cp -r easyrsa3 /usr/local/openVPN/easy-rsa
	cd /usr/local/openVPN/easy-rsa
	
	cp vars.example vars
	
#####	编辑vars文件，修改这几处：

	vi vars
		set_var EASYRSA_REQ_COUNTRY     "CN"
		set_var EASYRSA_REQ_PROVINCE    "ShangHai"
		set_var EASYRSA_REQ_CITY        "ShangHai"
		set_var EASYRSA_REQ_ORG 		"Copyleft org "
		set_var EASYRSA_REQ_EMAIL       "king2934@126.com"
		set_var EASYRSA_REQ_OU          "My openvpn"
		
#####	创建服务器端证书和Key	
	./easyrsa init-pki
	
#####	创建根证书(CA)

	./easyrsa build-ca
		1.输入密码
		2.再次输入密码 两次相同
		3.输入一个common name
		
#####	创建服务器端证书
	./easyrsa gen-req server nopass
		1.输入一个common name 与上面的common name不要相同 CA
		
#####	签约服务器端证书
	./easyrsa sign server server
		1.输入：yes
		2.输入上面设置的密码 CA密码
		
#####	创建Diffie-Hellman，确保key穿越不安全网络的命令：

	./easyrsa gen-dh
	
	
##### 创建客户端证书：

	mkdir /root/client
	cd /root/client
	cp -r /usr/local/openVPN/easy-rsa   ./
	
	cd easy-rsa
	./easyrsa init-pki

#####	生成客户端证书生成请求和key：

	./easyrsa gen-req Ops
		1.输入密码
		2.再次输入密码
		3.输入common name
		
#####	将生成的客户端请求导入并签约：

	cd /usr/local/openVPN/easy-rsa/
	./easyrsa import-req  /root/client/easy-rsa/pki/reqs/Ops.req Ops
		#显示如下：
		Note: using Easy-RSA configuration from: ./vars

		The request has been successfully imported with a short name of: Ops
		You may now use this name to perform signing operations on this request.
		
#####	签约客户端证书：

	./easyrsa sign client Ops
		1.输入：yes
		2.输入CA密码
		3.客户端证书 /usr/local/openVPN/easy-rsa/pki/issued/Ops.crt 
		
#####	客户端和服务端的证书已经配置完毕

#####	服务器密钥及证书
	1. /usr/local/openVPN/easy-rsa/pki/ca.crt
	2. /usr/local/openVPN/easy-rsa/pki/private/server.key
	3. /usr/local/openVPN/easy-rsa/pki/issued/server.crt
	4. /usr/local/openVPN/easy-rsa/pki/dh.pem
	
#####	客户端证书和秘钥
	1. /usr/local/openVPN/easy-rsa/pki/ca.crt
	2. /usr/local/openVPN/easy-rsa/pki/issued/Ops.crt
	3. /root/client/easy-rsa/pki/private/Ops.key
	
#####	为服务端编写openvpn的配置文件
	
	mkdir /usr/local/openVPN/etc
	cp /usr/src/soft/openvpn-2.4.6/sample/sample-config-files/server.conf /usr/local/openVPN/etc/

#####	生成ta.key文件 （防DDos攻击、UDP淹没等恶意攻击）

	/usr/local/openVPN/sbin/openvpn --genkey --secret /usr/local/openVPN/ta.key
	
	grep -v ^# /usr/local/openVPN/etc/server.conf | grep -v ^$ | grep -v  ^\;
	
		ca		/usr/local/openVPN/easy-rsa/pki/ca.crt
		cert	/usr/local/openVPN/easy-rsa/pki/server.crt
		key		/usr/local/openVPN/easy-rsa/pki/server.key 
		dh 		/usr/local/openVPN/easy-rsa/pki/dh.pem
		tls-auth /usr/local/openVPN/ta.key 0 
	
#####	启动服务

	/usr/local/openVPN/sbin/openvpn /usr/local/openVPN/etc/server.conf &

#####	开放端口
	firewall-cmd --zone=public --add-port=1194/tcp --permanent
	firewall-cmd --reload
	
#####	客户端配置
		