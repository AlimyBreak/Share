close all;
clear;
clc;


%load franke
%sf = fit([x, y],z,'poly23');
% x,y,z 的size要一致, 



f = [1:100];
t = (1:200)/10;
x = [];
y = [];
for ii = 1:length(t)
   x = [x,f]; 
end

for ii = 1:length(t)
    y = [y, repmat(t(ii),1,length(f))];
end

x = x';
y = y';

psd = y*0; % get size

for ii = 1:length(psd)
    psd(ii) = 30*x(ii)*y(ii) + 2*x(ii)*x(ii) + 7*y(ii)*y(ii) + 1 + rand;
end
%sf = fit([x, y],psd,'poly23')
A_init = [1,1,1,1,1,1,1,1,1];
ft = [x,y];

A_hat = lsqcurvefit(@func_handle_psd,A_init,ft,psd);


    

return
x = repmat(f,size(t,1));

aaa = fit( [f,t],psd);