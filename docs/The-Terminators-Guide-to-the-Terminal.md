# Terminal 终结指南
# The Terminator's Guide to the Terminal

## 安装

```
sudo apt-get update
sudo apt-get install terminator
```

## 美化

```
cd ~/.config/terminator/ 
sudo vim config
```

我的配置如下：

```
[global_config]
  title_transmit_bg_color = "#d30102"
  focus = system
  suppress_multiple_term_dialog = True
[keybindings]
[profiles]
  [[default]]
    palette = "#2d2d2d:#f2777a:#99cc99:#ffcc66:#6699cc:#cc99cc:#66cccc:#d3d0c8:#747369:#f2777a:#99cc99:#ffcc66:#6699cc:#cc99cc:#66cccc:#f2f0ec"
    background_color = "#2D2D2D" # 背景颜色
    background_image = None   
    background_darkness = 0.85 
    cursor_color = "#EEE9E9" # 光标颜色
    cursor_blink = True # 光标是否闪烁
    foreground_color = "#EEE9E9" # 文字的颜色
    use_system_font = False # 是否启用系统字体
    font = Ubuntu Mono 13  # 字体设置，后面的数字表示字体大小
    show_titlebar = False # 不显示标题栏，也就是 terminator 中那个默认的红色的标题栏
[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
      profile = default
    [[[window0]]]
      type = Window
      parent = ""
[plugins]
```

## 设置为默认终端

```
sudo apt-get install dconf-tools
gsettings set org.gnome.desktop.default-applications.terminal exec   /usr/bin/terminator
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"
```

## 常用快捷键

快捷键 | 功能
:---: | :---:
Ctrl + Shift + E | 垂直分割窗口
Ctrl + Shift + O | 水平分割窗口
Ctrl + Shift + X | 当前窗口全屏
Ctrl + Shift + Z | 回到多窗口界面
Ctrl + Tap | 切换窗口
Ctrl + D | 关闭当前窗口
