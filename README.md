# Apollo 漫游指南
# The Hitchhiker's Guide to the Apollo


## 配置 Ubuntu

### 替换更新源为阿里云源

**Ubuntu 14.04** 安装完成后替换系统更新源为国内镜像源。

1. 按 Ctrl + Alt + T 打开终端，输入以下命令：
  
	```
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak  #备份源
	sudo gedit /etc/apt/sources.list  #编辑源列表
	#复制井号后文字不影响命令
	```
	> 如需使用 VIM ，在更新源结束后输入`sudo apt-get install vim`

2. 复制下列源完全替换之前的源：

	```
	# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
	deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty main restricted universe multiverse
	# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty main restricted universe multiverse
	deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse
	# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-updates main restricted universe multiverse
	deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse
	# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-backports main restricted universe multiverse
	deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-security main restricted universe multiverse
	# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ trusty-security main restricted universe multiverse
	```

3. 执行软件更新器

	```
	sudo apt-get update  #更新列表
	sudo apt-get upgrade  #更新软件
	```

### 安装内核

1. 打开终端，输入以下命令安装 Linux 4.4 内核：

	```
	sudo apt-get install linux-generic-lts-xenial
	```
  
2. 安装完成后输入 `sudo reboot` 命令重启系统

3. **拷贝预编译的内核到根目录下**，输入以下命令：

	```
	tar zxvf ~/linux-4.4.32-apollo-1.5.5.tar.gz  #解压包
	cd ~/install
	sudo bash install_kernel.sh
	```

4. 安装完成后输入 `sudo reboot` 命令重启系统

5. 重启后在终端输入：`cat /proc/version` 查看内核版本

	>添加 Ubuntu 对 exfat 的支持： `sudo apt-get install exfat-utils`
	
## 安装 CAN 卡驱动

### 根据工控机上的 CAN 卡选择安装的驱动

### 1. 安装 ESC_CAN 驱动

1. **拷贝驱动文件到根目录下**，在终端中输入以下命令：

	```
	sudo apt-get install dkms
	cd ~/esdcan-pcie402-linux-2.6.x-x86_64-3.10.3
	sudo -i
	```
  
2. 输入以下命令安装驱动：

	```
	dkms add ./src
	dkms build esdcan-pcie402-linux-2.6.x-x86_64/3.10.3
	dkms install esdcan-pcie402-linux-2.6.x-x86_64/3.10.3
	```
3. 创建索引节点：

	```
	cd /dev
	sudo mknod --mode=a+rw can0 c 52 0
	```

4. **关闭终端或者退出 root 用户**

5. 拷贝 ESDCAN 库到 Apollo 文件夹（在 CAN 卡适配指南中）

### 2. 安装 SOCKET_CAN 驱动

1. **拷贝驱动文件到根目录下**，在终端中输入以下命令：

	```
	cd ~/EMUC-B202_SocketCAN_Driver_v2.2_Utility_v2.2
	sudo make clean
	make
	```

2. 拷贝 emuc2socketcan.ko 文件

	```
	cp ~/EMUC-B202_SocketCAN_Driver_v2.2_Utility_v2.2/driver/emuc2socketcan.ko ~/can/
	```

3. 输入以下命令安装驱动：

	```
	sudo bash ~/can/install_can.sh
	```

## 安装 NVIDIA 驱动、CUDA、cuDNN 工具

1. **拷贝驱动文件到根目录下**，输入以下命令：

	```
	sudo bash ~/NVIDIA-Linux-x86_64-375.39.run --no-x-check -a -s --no-kernel-module
	```
  
	>笔记本安装时需要在最后加上：`--no-opengl-files`

2. 在终端中输入以下命令，并根据提示安装 CUDA 工具，**<mark>在选择是否安装 NVIDIA 驱动时选否</mark>**：

	```
	sudo chmod a+x ~/cuda_8.0.61_375.26_linux.run  #编辑权限
	sudo bash ~/cuda_8.0.61_375.26_linux.run
	echo "export PATH=$PATH:/usr/local/cuda/bin" >> ${HOME}/.bashrc
	```

3. 安装完成后输入`sudo reboot`命令重启系统，重启后在应用中能看到 NVIDIA 工具以及 CUDA 工具

4. 打开终端，输入以下命令安装 cuDNN 工具：

	```
	tar -xzvf cudnn-8.0-linux-x64-v7.tgz
	sudo cp cuda/include/cudnn.h /usr/local/cuda/include
	sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
	sudo chmod a+r /usr/local/cuda/include/cudnn.h 
	sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
	sudo dpkg -i libcudnn7-dev_7.1.1.5-1+cuda8.0_amd64.deb
	```
  
	完成后重启系统
  
## 运行 Apollo

### 获取 Apollo 源码

使用 git 工具获取 Apollo 源码：

```
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get update
sudo apt-get -y install openssh-server exfat-utils git git-lfs
git-lfs clone https://github.com/ApolloAuto/apollo.git
```

Github 访问慢的解决方案：

- VPN加速方法见 [ShadowSocks 附加指南](https://github.com/liyubang/The-Hitchhikers-Guide-to-the-Apollo/blob/master/The-Additional-guide-to-the-SS.md)

- 修改 hosts 加速方法：

	1. 浏览器打开如下网站

		>[http://github.global.ssl.fastly.net.ipaddress.com/](http://github.global.ssl.fastly.net.ipaddress.com/)
		
		记录对应IP地址，例如：151.101.xx.xx
    
	2. 浏览器打开另外一个网站

		>[http://github.com.ipaddress.com/](http://github.com.ipaddress.com/)
		
		记录对应IP地址。例如：192.30.xx.xx

	3. 编辑hosts文件

		```
		sudo apt-get install vim
		sudo vim /etc/hosts
		```

		在文件中加入如下两行

		```
		151.101.xx.xx github.global.ssl.fastly.net
 		192.30.xx.xx github.com  #替换成之前记录的IP地址
		```

### 配置环境变量

打开终端，输入以下命令：

```
echo "export APOLLO_HOME=~/apollo" >> ~/.bashrc
echo "export PATH=~/apollo/docker/scripts:$PATH" >> ~/.bashrc
source ~/.bashrc
```

### 安装 Docker

1. 打开终端，输入以下命令
  
	```
	bash ~/apollo/docker/setup_host/install_docker.sh
	```

2. 安装完成后输入`sudo reboot`命令重启系统

3. **重启后验证非管理员权限下访问 Docker**，在终端中输入以下命令：

	```
	docker run hello-world
	```

	安装并配置成功的话会拉取镜像并显示 Docker 欢迎界面

### 拉取 Apollo 镜像

1. 打开终端，输入以下命令拉取 Apollo 搭建所需要的镜像：

	```
	dev_start.sh -C  #'-C'表示从中国镜像网站拉取
	```

2. 完成后输入以下命令：

	```
	dev_into.sh #进入 Docker 容器环境
	```

### 基于源代码编译 Apollo

**在 Docker 环境中**，输入以下命令编译 Apollo：

```
bash apollo.sh build 
```

### 启动 Dreamview

**编译完成后**，输入以下命令以启动 Dreamview WEB 交互界面：

```
bash scripts/bootstrap.sh
```

用浏览器访问 [http://localhost:8888](http://localhost:8888)

- `bash scripts/bootstrap.sh stop  #退出 Dreamview`

### 更新 Apollo 源码
进入 Apollo 文件夹，输入以下命令：

```
git add . #添加文件到暂寸区
git commit -a #提交文件到仓库区
git pull #取回远程仓库的变化
```
