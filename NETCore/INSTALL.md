.NET Core for Linux  
===================================
	rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl= https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo'
	yum -y install libunwind libicu
	
#####	查看最新的版本
	yum list dotnet-sdk
	
#####	安装最新版本
	yum -y install dotnet-sdk-2.2

#####	查看安装后的版本信息
	dotnet --info

#####	测试 输出 Hello World!
	dotnet new console --output sample1
	dotnet run --project sample1	
#END 结束