# Terminal 终结指南
# The Terminator's Guide to the Terminal

## 使用 zsh

### 安装配置 zsh

1. 查看系统中是否有 zsh

	```
	cat /etc/shells
	 ```
	
2. 若系统中没有 zsh ，则需要安装

	```
	sudo apt-get install zsh
	```
	
3. 把默认的Shell改成zsh

	```
	chsh -s /bin/zsh
	```
	
4. 配置密码文件，解决chsh: PAM认证失败的问题

	```
	sudo vim /etc/passwd
	```
	把第一行的 /bin/bash 改成 /bin/zsh ，把最后一行的 /bin/bash 改成 /bin/zsh
	
### 安装配置 Oh My Zsh

1. 安装

	```
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	```
	
2. 配置 
	
	- 访问[https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)查看指南
	
3. 安装zsh-autosuggestion

	```
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/
	```
并且在.zshrc的plugins中添加： `zsh-autosuggestions`

4. 安装高亮插件

	```
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/
	```
并且在.zshrc的plugins中添加： `zsh-syntax-highlighting`
然后在文件的最后一行添加： `source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`
	
### 美化 zsh

1. 安装 powerlevel9k 主题
	
	访问[bhilburn/powerlevel9k](https://github.com/bhilburn/powerlevel9k)查看指南
	
2. 安装 Powerline 字体

	sudo apt-get install fonts-powerline
	
3. 安装 Awesome-Powerline 字体

	访问[gabrielelana/awesome-terminal-fonts](https://github.com/gabrielelana/awesome-terminal-fonts)查看指南

4. （可选）拷贝我的配置文件
	
	```
	cp ./terminal-conf/zshrc ~/.zshrc
	```

## 修改终端配色

访问[Anthony25/gnome-terminal-colors-solarized](https://github.com/Anthony25/gnome-terminal-colors-solarized)查看指南

	
## 配置 VIM

访问[wklken/k-vim](https://github.com/wklken/k-vim)查看指南
> （可选）拷贝我的配置文件	
> 
> ```
> cp ./terminal-conf/vimrc ~/k-vim/vimrc
> cp ./terminal-conf/vimrc.bundles ~/k-vim/vimrc.bundles
> ```

### YCM安装问题

- 检查vim对python的支持
- 检查cmake版本
