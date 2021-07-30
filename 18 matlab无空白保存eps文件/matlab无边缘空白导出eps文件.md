+ 动机：很多期刊投稿要求提交eps文件，然而matlab直接saveas或者print的eps文件一般都具有

+  前置条件：

  + Win10
  + 已经安装了matlab的某个版本
  + 电脑已经安装了Ghostscript 的某个版本，并且能够成功打开eps文件

+ 用到的工具包：以Yair Altman 为主要作者开发 export_fig 工具包

  ***

  1. 下载：通过github链接下载即可；

  2. 安装：解压以后将文件夹放到matlab安装路径下的toolbox文件夹下，打开matlab将该路径加入路径，添加以后重启matlab；

  3. readme文件提供的测试代码

     ```matlab
     plot(cos(linspace(0, 7, 1000)));
     set(gcf, 'Position', [100 100 150 150]);
     saveas(gcf, 'test.png');
     export_fig test2.eps
     ```

  4. 运行后，会生成test2.eps和test.png两个文件，安装成功；若提示找不到export_fig命令，则是安装没有成功，需要检查路径。





参考链接：

[如何输出彩色eps图片，并且无白边](https://www.ilovematlab.cn/forum.php?mod=viewthread&tid=511925)

[github 仓库地址](https://github.com/altmany/export_fig)

[file exchage 链接](https://ww2.mathworks.cn/matlabcentral/fileexchange/23629-export_fig)

2021.07.30

