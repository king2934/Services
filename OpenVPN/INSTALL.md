# 安装
	yum update -y
	yum install -y git wget automake autoconf openssl-devel openssl lzo lzo-devel pam-devel libtool net-tools
	
	wget -O openvpn-2.4.6.tar.gz https://github.com/OpenVPN/openvpn/archive/v2.4.6.tar.gz
	
	autoreconf -i -v -f
	./configure --prefix=/usr/local/openVPN
	make
	make install