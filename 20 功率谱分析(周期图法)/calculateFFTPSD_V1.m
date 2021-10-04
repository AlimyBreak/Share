%{
    calculateFFTPSD_V1: YQW/2021.10.01
    输入:
    x       :   信号值,长度为 NS
    win     :   加窗取值
    NF      :   NS/2
    NS      :   数据长度,FFT长度
    Fs      :   采样频率,Hz
    输出:
    PSD     :   power spectral density 
%}

function [PSD] = calculateFFTPSD_V1(x,win,NF,NS,Fs)
    YyT         =   2*fft(x.*win)           ;
    Yy          =   YyT(1:NF)               ;
    PSD         =   2*Yy.*conj(Yy)/NS/Fs    ;
end