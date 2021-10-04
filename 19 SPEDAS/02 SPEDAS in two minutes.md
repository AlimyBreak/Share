一、打开spd\_gui,加载THEMIS的一下数据(2010-03/23 00:00:00 - 2010-03/24 00:00:00)

+ Instrument  **ESA** ，Probes **A** ,  level2 **peif\_density**
+ Instrument  **ESA** ，Probes **A** ,  level2 **peif\_avgtemp**
+ Instrument  **SST** ，Probes **A** ,  level2 **psif\_en\_eflux**
+ Instrument  **STATE** ，Coordinate **GEI**,Probes **A** ,  level1 **pos**



二、通过Plot将 peif\_density,peif\_avgtemp和state_pos 以line的方式add，psif\_en_eflux 以spec的方式add。

![image-20210930173651248](.\02 SPEDAS in two minutes.assets\image-20210930173651248.png)

![image-20210930173605706](.\02 SPEDAS in two minutes.assets\image-20210930173605706.png)



三、部分功能

 1.  Zoom out 感兴趣的区域，生成新的page；

 2.  通过Pages切换图，关闭不需要的子图；

 3.  数据计算: Analysis-Calculate(举一个彩图取log的例子).

     ![image-20210930181546617](.\02 SPEDAS in two minutes.assets\image-20210930181546617.png)

 4.  数据导出：Data-Save Data as- csv（供其他软件处理）









参考链接：

1、[SPEDAS in two minutes(官方视频,需要梯子)](https://www.youtube.com/watch?v=dIsbow-cA1Q)

2、[spedas wiki](wiki.spedas.org)

3、[免费屏幕录制软件](http://www.xiaoheiqun.vip/topic-2020.html)  特别鸣谢 科技小黑群论坛(http://www.xiaoheiqun.vip/)