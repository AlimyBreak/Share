## 环境

+ win10
+ Python 3.8.3 (default, Jul  2 2020, 17:30:36) [MSC v.1916 64 bit (AMD64)] :: Anaconda, Inc. on win32
+ Anaconda

## 安装步骤

+ 安装Anaconda3（Python3.8.3）
+ 打开Anaconda Prompt（命令行），联网情况下运行命令
```bash
pip install spacepy
```

***

+ 安装 NASA CDF library（根据需要下载自己用的版本）

  + [cdf37_1_0-setup-64.exe](https://spdf.gsfc.nasa.gov/pub/software/cdf/dist/cdf37_1/windows/cdf37_1_0-setup-64.exe)
  
+ Spyder 测试代码,图片为展示结果

```python
import spacepy.pycdf as spy
import numpy as np
import matplotlib.pyplot as plt

fileName = r'C:\Users\admin\Desktop\CDF_File\mms1_dsp_slow_l2_bpsd_20200101_v2.2.0.cdf'
cdf_data = spy.CDF(fileName);
x = np.zeros(len(cdf_data['Epoch']));
for i in range(len(cdf_data['Epoch'])):
    x[i] = i
plt.plot(x,cdf_data['Epoch'])
```

![Figure_1](.\Figure_1.jpeg)


## 相关链接

+ [Anaconda](https://www.anaconda.com/products/individual)
+ https://spacepy.github.io/install_windows.html#dependencies-via-conda
+ https://spacepy.github.io/install_windows.html#fortran-and-ffnet
+ https://stackoverflow.com/questions/56495234/how-to-read-cdf-file-with-python-on-mac

***

<div align=right>
    YQW/alimy1990@foxmail.com
<div align = right>
    2020.10.16
</div>





