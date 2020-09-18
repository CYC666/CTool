# CTool

CocoaPods  

Add pod 'CTool' to your Podfile.  
Run pod install or pod update.  
Import "CTool.h"  


![Animation](Images/TopTipView.gif "Animation")  
  
![Screenshots](Images/Home.png "Screenshots")    

![Screenshots](Images/CopyLabel.png "Screenshots")    


1.0.7

UIButton+CButton：按钮的快速点击响应  
UILabel+CLabel：文本标签的快速点击响应  
UIImageView+CImageView：图片视图的快速点击响应  
UITextField+CTextField：输入框的回车响应  
TopTipView：类似于远程通知在屏幕顶部的提示样式  
1、文本多行可滑动查看  
2、单行支持向上清扫即可关闭  
3、可自定义：背景颜色、文本颜色、文本字体、弹出/收起动画时长、显示时长、左右边距  


1.0.8  
1、解决图片资源不能下载的问题  
      CTool.podspec 里面添加源文件路径 s.resources = 'CTool/CToolImages.bundle'

1.0.9
1、新增CToast提示
2、新增字符串小数位控制

1.1.0
1、添加了按钮快速设置标题颜色
2、添加CCopyLabel，可实现长按Label拷贝  

1.1.1
1、增加了打印对象方法，可实现打印网络请求返回的对象，直接输出中文  
2、增加了字符串、按钮的快速设置  
3、添加了UIView+CXibExt，使得xib中支持直接设置视图的描边、阴影等  
4、添加了CTimer

1.1.6 
1、UIView+CXibExt中的属性名太长，在xib中显示不完全，改短

1.1.7 
1、添加了UILabel+CXibExt，可快速设置文本的333、666、999颜色

1.1.8  
1、添加了宏定义  
  
1.1.9  
1、添加了按钮的一些宏定义  
2、添加了view阴影、指定圆角宏定义

1.2.0 
1、新增渐变色方法

1.2.1
1、新增view的frame控制

1.2.3
1、新增UIView的点击响应

1.3.0
1、一个方法创建UILabel、UIButton、UITextField
2、一些基础控件的链式语法
