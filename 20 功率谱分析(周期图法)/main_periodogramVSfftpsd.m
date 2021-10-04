
close all;
clear;
clc;

max_psd = [];


figure('pos',[0,0,2000,900]);
for ii = 8:15
    NS = 2^ii;
    NF = NS/2;
    Fs = 35e3;
    Ts = 1/Fs;
    x = (1:NS)*Ts;
    
    f1 = 3000; %Hz
    f2 = 4500; %Hz
    f3 = 6000; %Hz
    
    A1 = 30;
    A2 = 13;
    A3 = 53;
    
    y = A1*sin(2*pi*f1*x)  + A2*sin(2*pi*f2*x) + A3*sin(2*pi*f3*x);
    A_hat = (A1^2 + A2^2 + A3^2)/sqrt(2);
    %plot(x,y);    
    y = y.*hanning(NS)';
    win = ones(1,NS);
    [pxx,f] = periodogram(y,win,NS,Fs);
    pxx = pxx(1:end-1);
    f  = f(1:end-1);
    pxx(1)  =   2*pxx(1)    ;
    pxx     =   4*pxx           ;
    [Psd] = calculateFFTPSD_V1(y,win,NF,NS,Fs);
    max_psd = [max_psd,max(Psd)];
    temp = find(f > 2000);
    S_ind = temp(1);
    temp = find(f < 7000);
    E_ind = temp(end);

    Q1 = trapz(f(S_ind:E_ind),pxx(S_ind:E_ind));
    Q2 = trapz(f(S_ind:E_ind),Psd(S_ind:E_ind));
    subplot(3,3,ii - 7);
    semilogy(f,pxx,'b','marker','*');
    hold on;
    semilogy(f,Psd,'r');
    legend({'periodogram','FFTPSD'});
    legend('boxoff');
    xlim([0,12e3]);
    ylim(10.^[-10,5]);
    title(['N = ',num2str(2^ii)]);
    text(10,1e4,['Q1=Q2=',num2str(Q1)]);
    
end



subplot(3,3,9);
loglog(2.^(8:15),sqrt(max_psd),'*');
xlabel('NS');
ylabel('Peak amplitude');
ylim(10.^[-1,2]);
title('peak');
text(100,30,{'窗固定时,peak随着fft点数在变','但在特定频率区间','进行梯形积分得到总能量是不变的',['A\_hat = ',num2str(A_hat)]});

print('F1.eps','-depsc2');