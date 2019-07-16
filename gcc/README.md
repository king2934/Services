#	gcc 编译安装
###	官方网址 https://gcc.gnu.org/

#####	gcc 依赖 三个包分别是MP、 GMP、MPFR。以下是三个包的网址
	http://www.multiprecision.org/mpc
	ftp://ftp.gnu.org/gnu/gmp
	https://ftp.gnu.org/gnu/mpfr/
	
	取得所需软件
	wget ftp://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.bz2
	wget https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz	
	wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.0.2.tar.bz2
	wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-8.3.0/gcc-8.3.0.tar.xz

	安装顺序
	
	第一步要先安装gmp
	
	tar -jxvf gmp-6.1.2.tar.bz2
	cd gmp-6.1.2
	./configure --prefix=/usr/local/gmp
	make
	make install
	
	第二步安装mpfr
	tar -jxvf mpfr-4.0.2.tar.bz2
	cd mpfr-4.0.2
	./configure --prefix=/usr/local/mpfr --with-gmp=/usr/local/gmp/
	make
	make install
	
	第三步安装mpc
	tar -xvf mpc-1.0.3.tar.gz
	cd mpc-1.0.3
	./configure --prefix=/usr/local/mpc --with-gmp=/usr/local/gmp/  --with-mpfr=/usr/local/mpfr/
	(将src/mul.c内的所有mpfr_fmma函数改名为mpfr_fmma_mul,三处地方)
	make
	make install
	
	第四步安装gcc
	tar -xvf gcc-8.3.0.tar.xz
	cd gcc-8.3.0
	./configure \
	--prefix=/usr/local/gcc \
	--enable-checking=release --enable-languages=c,c++ --disable-multilib \
	--with-gmp=/usr/local/gmp/  \
	--with-mpfr=/usr/local/mpfr/  \
	--with-mpc=/usr/local/mpc/ \
	
	参数解释：
	--prefix=/usr/local/gcc 安装到路径
	–enable-checking=release 增加一些检查，也可以–disable-checking生成的编译器在编译过程中不做额外检查 
	–enable-languages=c,c++ 你要让你的gcc支持的编程语言 
	–disable-multilib 取消多目标库编译(取消32位库编译)
	
	
	


