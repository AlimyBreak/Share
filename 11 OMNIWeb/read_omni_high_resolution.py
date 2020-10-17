# -*- coding: utf-8 -*-
"""
Created on Sat Oct 17 16:03:13 2020
@author: YQW/alimy1990@foxmail.com

***
High-Resolution OMNI data set(https://omniweb.gsfc.nasa.gov/html/HROdocum.html)

 WORDS                        Format  Fill val     Comments
 1 Year			        I4	                1995 .....
 2 Day			        I4	                 1 ... 365 or 366
 3 Hour			        I3	                 0 ... 23
 4 Minute			I3   	            0 ... 59 at start of average
 5 ID for IMF spacecraft	I3       99          See  footnote D below
 6 ID for SW Plasma spacecraft	 I3	 99                 See  footnote D below
 7 # of points in IMF averages	 I4      999
 8 # of points in Plasma averages I4     999
 9 Percent interp		I4	 999       See  footnote A above
10 Timeshift, sec		I7     999999
11 RMS, Timeshift		I7     999999
12 RMS, Phase front normal	F6.2	99.99       See Footnotes E, F below
13 Time btwn observations, sec	I7      999999        DBOT1, See  footnote C above
14 Field magnitude average, nT	F8.2   9999.99
15 Bx, nT (GSE, GSM)		F8.2   9999.99
16 By, nT (GSE)		        F8.2   9999.99
17 Bz, nT (GSE)		        F8.2   9999.99
18 By, nT (GSM)	                F8.2   9999.99	        Determined from post-shift GSE components
19 Bz, nT (GSM)	                F8.2   9999.99          Determined from post-shift GSE components
20 RMS SD B scalar, nT	        F8.2   9999.99
21 RMS SD field vector, nT	F8.2   9999.99	              See  footnote E below
22 Flow speed, km/s		F8.1   99999.9
23 Vx Velocity, km/s, GSE	F8.1   99999.9
24 Vy Velocity, km/s, GSE	F8.1   99999.9
25 Vz Velocity, km/s, GSE	F8.1   99999.9
26 Proton Density, n/cc		F7.2    999.99
27 Temperature, K		F9.0   9999999.
28 Flow pressure, nPa		F6.2	 99.99           See  footnote G below		
29 Electric field, mV/m		F7.2	999.99          See  footnote G below
30 Plasma beta		        F7.2	999.99          See  footnote G below
31 Alfven mach number		F6.1	 999.9          See  footnote G below
32 X(s/c), GSE, Re		F8.2   9999.99
33 Y(s/c), GSE, Re		F8.2   9999.99
34 Z(s/c), GSE, Re		F8.2   9999.99
35 BSN location, Xgse, Re	F8.2   9999.99            BSN = bow shock nose
36 BSN location, Ygse, Re	F8.2   9999.99
37 BSN location, Zgse, Re 	F8.2   9999.99

38 AE-index, nT                 I6       99999       See World Data Center for Geomagnetism, Kyoto
39 AL-index, nT                 I6       99999       See World Data Center for Geomagnetism, Kyoto
40 AU-index, nT                 I6       99999       See World Data Center for Geomagnetism, Kyoto
41 SYM/D index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
42 SYM/H index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
43 ASY/D index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
44 ASY/H index, nT              I6       99999       See World Data Center for Geomagnetism, Kyoto
45 PC(N) index,                 F7.2    999.99       See World Data Center for Geomagnetism, Copenhagen

46 Magnetosonic mach number     F5.1     99.9        See  footnote G below



***
"""





import os
import datetime
import matplotlib.pyplot as plt
import numpy as np



def smooth(a,WSZ):
  # from: https://www.yzlfxy.com/jiaocheng/python/338117.html
  # a:原始数据，NumPy 1-D array containing the data to be smoothed
  # 必须是1-D的，如果不是，请使用 np.ravel()或者np.squeeze()转化 
  # WSZ: smoothing window size needs, which must be odd number,
  # as in the original MATLAB implementation
  out0 = np.convolve(a,np.ones(WSZ,dtype=int),'valid')/WSZ
  r = np.arange(1,WSZ-1,2)
  start = np.cumsum(a[:WSZ-1])[::2]/r
  stop = (np.cumsum(a[:-WSZ:-1])[::2]/r)[::-1]
  return np.concatenate(( start , out0, stop ))


        
def readYearData(file_path,file_name,time_begin,time_end,var_list):
    """
    Parameters
    ----------
    file_path : str
        file dir path.
    file_name : str
        file name 
    time_begin : datetime
        begin time(UTC).
    time_end : datetime
        end time(UTC).
    var_list : str
        names of data you want to get.
        
    Returns
    -------
    data : TYPE
        DESCRIPTION.

    """

    data = dict()
    data['Time'] = []
    for each in varList:
        data[each] = []
        
        
    with open(os.path.join(file_path,file_name)) as fp:
        for line in fp.readlines():
            curLine         = line.split()   
            Year            =   int(curLine[0])
            day             =   int(curLine[1])
            Hour            =   int(curLine[2])
            Minute          =   int(curLine[3])
            id1             =   int(curLine[4])     # ID for IMF spacecraft
            id2             =   int(curLine[5])     # ID for SW Plasma spacecraftt
            points1         =   int(curLine[6])     # of points in IMF averages	
            points2         =   int(curLine[7])     # of points in Plasma averages
            percentInterp   =   int(curLine[8])
            Timeshift       =   int(curLine[9])     # in unit of sec
            RMS1            =   int(curLine[10])    # in unit of Timeshift
            RMS2            =   float(curLine[11])  # Phase front normal
            TBO             =   int(curLine[12])    # in unit of sec,Time btwn observations
            fma             =   float(curLine[13])  # in unit of nT,Field magnitude average
            Bx              =   float(curLine[14])  # Bx, nT (GSE, GSM)	
            By_GSE          =   float(curLine[15])  # By, nT (GSE)
            Bz_GSE          =   float(curLine[16])  # Bz, nT (GSE)
            By_GSM          =   float(curLine[17])  # By, nT (GSM)
            Bz_GSM          =   float(curLine[18])  # Bz, nT (GSM)
            RMS_B           =   float(curLine[19])  # RMS SD B scalar, nT
            RMS_FV          =   float(curLine[20])  # RMS SD field vector, nT
            flowSpeed       =   float(curLine[21])  # Flow speed, km/s
            Vx              =   float(curLine[22])  # Vx Velocity, km/s, GSE
            Vy              =   float(curLine[23])  # Vx Velocity, km/s, GSE        
            Vz              =   float(curLine[24])  # Vx Velocity, km/s, GSE      
            protonDensity   =   float(curLine[25])  # Proton Density, n/cc
            Temperature     =   float(curLine[26])  # Temperature, K
            flowPressure    =   float(curLine[27])  # Flow pressure, nPa
            electricField   =   float(curLine[28])  # Electric field, mV/m
            plasmaBeta      =   float(curLine[29])  # Plasma beta
            AlfvenMachNum   =   float(curLine[30])  # Alfven mach number
            X_sc            =   float(curLine[31])  # X(s/c), GSE, Re
            Y_sc            =   float(curLine[32])  # Y(s/c), GSE, Re        
            Z_sc            =   float(curLine[33])  # Z(s/c), GSE, Re
            Xgse            =   float(curLine[34])  # BSN location, Xgse, Re
            Ygse            =   float(curLine[35])  # BSN location, Ygse, Re        
            Zgse            =   float(curLine[36])  # BSN location, Zgse, Re
            AE              =   int(curLine[37])    # AE-index, nT
            AL              =   int(curLine[38])    # AL-index, nT
            AU              =   int(curLine[39])    # AU-index, nT
            SYM_D           =   int(curLine[40])    # SYM/D index, nT
            SYM_H           =   int(curLine[41])    # SYM/H index, nT
            ASY_D           =   int(curLine[42])    # ASY/D index, nT
            ASY_H           =   int(curLine[43])    # ASY/H index, nT
            PCN             =   float(curLine[44])  # PC(N) index
            MagMachNum      =   float(curLine[45])  # Magnetosonic mach number

            cur_day = dayth2Monthday(Year,day)
            curTime = datetime.datetime(cur_day.year,cur_day.month,cur_day.day,Hour,Minute);
            if curTime >= time_begin and curTime <= time_end:
                data['Time'].append(curTime)
                for each in varList:
                    data[each].append(locals()[each])
        return data
    
    
    
    
    
# 将某年的第某天转化为year mouth day            
def dayth2Monthday(year,day):
    """
    From: https://blog.csdn.net/qq_40728667/article/details/107777252
    Parameters
    ----------
    year : int
        year number.
    day : int
       the day's number in the year  
    Returns
    -------
    wanted_day : datetime
        Calendar day
    """
    # 输入的字符串类型的年和日转换为整型
    #first_day：此年的第一天
    #类型：datetime
    first_day=datetime.datetime(year,1,1)
    #用一年的第一天+天数-1，即可得到我们期望的日期
    #-1是因为当年的第一天也算一天
    wanted_day=first_day+datetime.timedelta(day-1)
    #返回需要的字符串形式的日期
    #wanted_day=datetime.datetime.strftime(wanted_day,'%Y%m')
    return wanted_day






file_path   =   r'D:\DATA\omni_hig_res'
file_name   =   r'omni_min2015.asc'
time_begin  =   datetime.datetime(2015,12,11,0,0)
time_end    =   datetime.datetime(2015,12,12,0,0)
varList     =   ['AE','AL']
data        =   readYearData(file_path,file_name,time_begin,time_end,varList)
AE          =   smooth(data['AE'],11)
AE          =   smooth(AE,11)
AE          =   smooth(AE,11)
plt.plot(AE)
plt.ylim((100,500))