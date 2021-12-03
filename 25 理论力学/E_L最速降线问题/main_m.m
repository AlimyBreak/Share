close all;
clear;
clc;

r = linspace(0,100,100);

theta = linspace(0,pi,1000);

for ii = 1:length(r)
    x = r(ii).*(theta - sin(theta) );
    y = r(ii).*(1 - cos(theta));
    
    plot(x,y);
    hold on

end


x1 = linspace(0,100*pi,100);
y1 = 2/pi*x1;
plot(x1,y1,'linewidth',2);



