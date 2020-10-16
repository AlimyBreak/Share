close all;
clear;
clc;


FileName = 'mms1_dsp_slow_l2_bpsd_20200101_v2.2.0.cdf';
info = spdfcdfinfo(FileName);
Epoch = spdfcdfread(FileName,'Variable', {'Epoch'}); 

plot(Epoch/1e5)

