#!/bin/sh

yum update -y

yum install -y wget bzip2 gcc openssl openssl-devel tcp_wrappers-devel pam pam-devel db4 db4-devel libcap libcap-devel

mkdir /usr/local/apache
mkdir /usr/local/apache/htdocs	
mkdir /usr/local/apache/htdocs/user1	
mkdir /usr/local/apache/htdocs/user2
mkdir /usr/local/vsftpd
mkdir /usr/local/vsftpd/conf
mkdir /usr/local/vsftpd/user_conf
mkdir /usr/local/vsftpd/bin
mkdir /usr/local/vsftpd/lib
mkdir /usr/local/vsftpd/logs
mkdir /usr/local/vsftpd/empty

groupadd wwwftp
useradd -g wwwftp wwwftp -d /usr/local/apache/htdocs/  -s /sbin/nologin
chown -R wwwftp:wwwftp /usr/local/apache/htdocs
chmod -R 700 /usr/local/vsftpd/empty
chown -R wwwftp:wwwftp /usr/local/vsftpd/empty/

echo "user1">/usr/local/vsftpd/chroot_list
echo "user2">>/usr/local/vsftpd/chroot_list

echo "user1">/usr/local/vsftpd/user_list
echo "user2">>/usr/local/vsftpd/user_list

echo "write_enable=YES">/usr/local/vsftpd/user_conf/user1
echo "local_umask=022">>/usr/local/vsftpd/user_conf/user1
echo "local_root=/usr/local/apache/htdocs/user1">>/usr/local/vsftpd/user_conf/user1

cp /lib64/security/pam_userdb.so	/usr/local/vsftpd/lib

wget http://wang.wshike.com/download/vsftpd-3.0.3.tar.gz
tar -zxf vsftpd-3.0.3.tar.gz
cd vsftpd-3.0.3
make
cd ..

cp vsftpd-3.0.3/vsftpd /usr/local/vsftpd/bin/vsftpd
rm -rf vsftpd-3.0.3*

echo "auth    required        /usr/local/vsftpd/lib/pam_userdb.so     db=/usr/local/vsftpd/users">/etc/pam.d/vsftpd
echo "account required        /usr/local/vsftpd/lib/pam_userdb.so     db=/usr/local/vsftpd/users">>/etc/pam.d/vsftpd

echo "local_enable=YES">/usr/local/vsftpd/conf/vsftpd.conf
echo "anonymous_enable=NO">>/usr/local/vsftpd/conf/vsftpd.conf
echo "anon_upload_enable=NO">>/usr/local/vsftpd/conf/vsftpd.conf
echo "anon_other_write_enable=NO">>/usr/local/vsftpd/conf/vsftpd.conf
echo "anon_mkdir_write_enable=NO">>/usr/local/vsftpd/conf/vsftpd.conf
echo "allow_writeable_chroot=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "ftpd_banner=Welcome to FTP service.">>/usr/local/vsftpd/conf/vsftpd.conf
echo "listen=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "listen_port=21">>/usr/local/vsftpd/conf/vsftpd.conf
echo "connect_from_port_20=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "nopriv_user=nobody">>/usr/local/vsftpd/conf/vsftpd.conf
echo "tcp_wrappers=NO">>/usr/local/vsftpd/conf/vsftpd.conf
echo "chroot_local_user=NO">>/usr/local/vsftpd/conf/vsftpd.conf
echo "chroot_list_enable=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "chroot_list_file=/usr/local/vsftpd/chroot_list">>/usr/local/vsftpd/conf/vsftpd.conf
echo "userlist_enable=yes">>/usr/local/vsftpd/conf/vsftpd.conf
echo "userlist_deny=no">>/usr/local/vsftpd/conf/vsftpd.conf
echo "userlist_file=/usr/local/vsftpd/user_list">>/usr/local/vsftpd/conf/vsftpd.conf
echo "dual_log_enable=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "vsftpd_log_file=/usr/local/vsftpd/logs/vsftpd.log">>/usr/local/vsftpd/conf/vsftpd.conf
echo "xferlog_enable=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "xferlog_file=/usr/local/vsftpd/logs/xferlog">>/usr/local/vsftpd/conf/vsftpd.conf
echo "pasv_enable=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "pasv_min_port=10060">>/usr/local/vsftpd/conf/vsftpd.conf
echo "pasv_max_port=10090">>/usr/local/vsftpd/conf/vsftpd.conf
echo "guest_enable=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "guest_username=wwwftp">>/usr/local/vsftpd/conf/vsftpd.conf
echo "pam_service_name=vsftpd">>/usr/local/vsftpd/conf/vsftpd.conf
echo "virtual_use_local_privs=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "use_localtime=YES">>/usr/local/vsftpd/conf/vsftpd.conf
echo "user_config_dir=/usr/local/vsftpd/user_conf">>/usr/local/vsftpd/conf/vsftpd.conf
echo "secure_chroot_dir=/usr/local/vsftpd/empty">>/usr/local/vsftpd/conf/vsftpd.conf


echo "user1">/usr/local/vsftpd/users.txt
echo "123456">>/usr/local/vsftpd/users.txt
echo "user2">>/usr/local/vsftpd/users.txt
echo "654321">>/usr/local/vsftpd/users.txt
	
db_load -T -t hash -f /usr/local/vsftpd/users.txt  /usr/local/vsftpd/users.db
	
/usr/local/vsftpd/bin/vsftpd  /usr/local/vsftpd/conf/vsftpd.conf &

echo "statd vsftpd"
