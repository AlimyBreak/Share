# <center>EMD学习笔记</center>

Author:YQW

Time:20190605

Ref:

1.  这篇文章能让你明白经验模态分解（EMD）——基础理论篇 https://zhuanlan.zhihu.com/p/40005057
2.  这篇文章能让你明白经验模态分解（EMD）——IMF的物理含义 https://zhuanlan.zhihu.com/p/44833026
3.  几种改善EMD端点效应方法的比较研究 http://www.dzsc.com/data/2013-12-31/104760.html

***

# 一.  why EMD?

+ EMD:经验模态分解(Emprirical Mode Decompirison)
+ EMD最显著的特点，就是其__克服了基函数无自适应性的问题__。常用的小波分析（傅立叶分析），我们会需要选定某个小波基，小波基的选择对整个小波分析的结果影响很大，一旦确定了小波基，在整个分析过程中将无法更换，即使该小波在全局可能是最佳的，但在某些局部可能并不是，所以__小波分析的基函数缺乏适应性__；
+ EMD的好处：对于一段未知信号，不需要做预先分析和研究，就可以直接开始分解，这个方法会自动按照一些__固模式__按__层次__分好，而不需要人额为设置和干预（__固模式应该怎么理解，和基函数的区别是啥__）；
+ EMD就像一台机器，把一堆混在一起的硬币扔进去，他会自动按1元、5毛、1毛、5分、1分地分成几份。

# 二.  内涵模态分量(IMF)

+ IMF:内涵模态分量(Intrinsic Mode Functions)
+ IMF就是原始信号被EMD分解之后得到的各层信号分量。EMD的提出人黄锷认为，__任何信号都可以拆分成若干个内涵模态分量之和__。
+ IMF的约束条件有两个
  + 在整个数据段内，极值点的个数和过零点的个数必须相等或相差最多不能超过一个(IMF图像要反复跨越x轴，而不能某次穿过零点后出现多个极点)；
  + 在任意时刻，由局部极大值点形成的上包络线和由局部极小值点形成的下包络线的平均值为0.(包络线要对称)



# 三.  EMD分解步骤

+ 根据原始信号上下极点，分别画出上、下包络线；
+ 求上、下包络线的均值，画出均值包络线；
+ 原信号减均值包络线，得到中间信号；
+ 判断该中间信号是否满足IMF的两个条件，如果满足，该信号就是一个IMF分量；如果不是，则以该信号为基础重复以上过程，IMF分量的获取通常需要若干次的迭代。
+ 使用上述方法得到第一个IMF后，用原始信号减IMF1，作为新的原始信号，在通过上述过程分析，得到IMF2，以此类推，完成EMD分解。



# 四.  IMF的物理意义

 + 首先生成一段信号，他由4Hz的正弦波和10Hz的正弦波组成

   ```matlab
   x   = linspace(0,100,4000);
   fs1 = 4;
   fs2 = 10;
   y1  = cosd(2*pi*fs1*x);
   y2  = cosd(2*pi*fs2*x);
   y   = y1+y2;
   figure();
   subplot(3,1,1);
   plot(x,y1);
   xlabel('x');
   ylabel('y_1');
   subplot(3,1,2);
   plot(x,y2);
   xlabel('x');
   ylabel('y_2');
   plot(x,y);
   xlabel('x');
   ylabel('y');
   % 图片结果见:EMD_FIG01.jpg
   ```

+ 对y进行EMD分解

  ```matlab
  [imf,residual] = emd(y);
  sub_pic_num = 1 + 2 + size(imf,2) + 1;
  figure();
  subplot(sub_pic_num,1,1);
  plot(x,y);
  xlabel('x');
  ylabel('y');
  subplot(sub_pic_num,1,2);
  plot(x,y1);
  xlabel('x');
  ylabel('y_1');
  subplot(sub_pic_num,1,3);
  plot(x,y2);
  xlabel('x');
  ylabel('y_2');
  for i = 1:size(imf,2)
  	subplot(sub_pic_num,1,i+3);
  	plot(x,imf(:,i));
  	xlabel('x');
  	ylabel(['imf',num2str(i)]);
  end
  subplot(sub_pic_num,1,sub_pic_num);
  plot(x,residual);
  xlabel('x');
  ylabel('residual');
  
  % 结果见：EMD_FIG02.jpg
  ```

  + 其中imf(:,i)为IMFi，residual为残差.
  + imf1与y~2~图像特征一致，imf2与y~1~图像特征一直
  + imf3及后续分量代表了__EMD端点效应__等带来的副作用

+ EMD的一大特点：__自适应地进行信号主要成分分析(非PCA)__，EMD分解信号不需要实现预定或强制给定基函数，而是依赖信号本身特征而自适应地进行分解。

+ 现实中的信号分量(IMF)不会像例子中一样保持完全稳定的频率和振幅，常常无法从各分量中直接开除信号规律。

+ EMD分解经常被用作信号特征提取的一个预先处理手段，将各IMF分量作为后续分析方法的输入，以完成更加复杂的工作。







