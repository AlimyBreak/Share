



+ 下载$\text{matlabR2020a}$ 打开cdf需要的插件

  + [nasa下载网页](https://cdf.gsfc.nasa.gov/html/matlab_cdf_patch.html)
  + 下载对应的$\text{self-extracting files}$,我的电脑是64bit，我下载的是
    + Build from **MS Visual Studio 2015**， **64-bit Windows:** [Windows (64-bit).](https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf38_0/matlab/matlab_cdf380_win64_VS2015.exe)

+ Double-click the downloaded file to extract the files included        in the patch to a directory. The files will be extracted into       **c:\matlab_cdf380_patch** by default.（可以自行决定安装路径，相应地在第三步要做对应匹配

+ 在matlab中增加插件:打开$\text{MatlabR2020a}$,"主页"-"设置路径"，将插件文件夹的全路径增加到进去（图片中我的安装位置是D盘）
  $$
  \text{C:\matlab_cdf380_path}
  $$
  
  ![Matlab增加cdf路径](.\Matlab增加cdf路径.png)
  
  
  
+ 测试代码

  ```matlab
  close all;
  clear;
  clc;
  FileName = 'mms1_dsp_slow_l2_bpsd_20200101_v2.2.0.cdf';
  info = spdfcdfinfo(FileName);
  Epoch = spdfcdfread(FileName,'Variable', {'Epoch'}); 
  plot(Epoch/1e5);
  ```


***

<div align=right>
    YQW/alimy1990@foxmail.com
</div>
<div align = right>
    2020.10.16
</div>







