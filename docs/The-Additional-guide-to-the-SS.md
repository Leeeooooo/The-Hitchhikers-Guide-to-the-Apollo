# ShadowSocks 附加指南
# The Additional Guide to the SS

## 安装 libsodium 库
 
 1. 获取 root 权限:`sudo su`
 
 2. 拷贝文件到根目录，输入以下命令解压并生成配置文件：

	```
	tar xzvf LATEST.tar.gz && cd libsodium-stable && ./configure
	```

3. 编译并安装
  
	```
	make -j8 && make install
	```

4. 添加运行库位置并加载运行库：

	```
	echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf && ldconfig
	```
  
5. **关闭终端或者退出 root 用户**

## 安装并启动 ShadowSocks
1. 打开终端，输入以下命令安装 Python 版 ShadowSocks ：

	```
	sudo apt-get install git
	sudo apt-get install python-pip
	sudo pip install git+https://github.com/shadowsocks/shadowsocks.git@master
	sudo apt-get install proxychains
	```

2. 拷贝配置文件 shadowsocks.json 到 /etc 目录下:
  
	```
	sudo cp ~/shadowsocks.json /etc/
	```

3. 用 VIM 或 Gedit 编辑 /etc/proxychains.conf 修改最后一行为：`socks5 127.0.0.1 1080`

exprot lib

4. 启动 ShadowSocks

	```
	sudo /usr/local/bin/sslocal -c /etc/shadowsocks.json -d start
	```
  
5. 拉取 Apollo 源码

	```
	proxychains git clone https://github.com/ApolloAuto/apollo.git
	```
  
6. 安装 Docker

	```
	proxychains bash ~/apollo/docker/setup_host/install_docker.sh
	```
  