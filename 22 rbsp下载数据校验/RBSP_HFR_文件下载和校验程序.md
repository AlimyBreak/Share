1. rbsp计划A卫星HFR仪器的waveform的cdf文件下载地址：

https://spdf.gsfc.nasa.gov/pub/data/rbsp/rbspa/l2/emfisis/hfr/waveform/2015

2. 校验思路:Space Physics Data Facility(SPDF)在cdf文件夹里面提供了每个文件的SHA1值，我们只要计算下载下来的cdf文件的sha1值并和提供的值做对比即可找出没有下载或者下载失败的文件。

3. 程序入口

   ```matlab
   %{
       rbsp_cdfFileCheckSha1_V1: YQW/2021.10.07  
       输入:
           work_dir    : cdf文件和SHA1SUM文件所在的文件夹
           sha1file    : 'SHA1SUM' 或者 'SHA1SUM.txt'
       输出:
           无.
   %}
   function [] = rbsp_cdfFileCheckSha1_V1(work_dir,sha1file)
   end
   ```
   
4. 演示。

5. 本程序适合SPDF网站上所有提供了SHA1SUM文件的下载数据校验。


***
### 参考链接:

1. [web_spdf](https://spdf.gsfc.nasa.gov/)

2. [web_rbsp_a_HFR_waveform](https://spdf.gsfc.nasa.gov/pub/data/rbsp/rbspa/l2/emfisis/hfr/waveform/)

3. [生成、查看文件的MD5、SHA1、SHA2、SHA3值](https://blog.csdn.net/COCO56/article/details/106161207)

4. [MATLAB实现SHA-512/SHA-256等加密算法以及生成随机的0/1二进制码流](https://blog.csdn.net/Harbour_zhang/article/details/103084622)

5. [科技小黑群 在线屏幕录像工具](http://www.xiaoheiqun.vip/topic-2020.html)

   

   

