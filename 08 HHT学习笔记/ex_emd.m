clear;
close all;
clc;


x = linspace(0,100,1000);
fs1 = 4;
fs2 = 10;
y1 = cosd(2*pi*fs1*x);
y2 = cosd(2*pi*fs2*x);
y  = y1 + y2;

if 0
    figure()
    subplot(3,1,1);
    plot(x,y1);
    xlabel('x');
    ylabel('y_1');
    subplot(3,1,2);
    plot(x,y2);
    xlabel('x');
    ylabel('y_2');
    subplot(3,1,3);
    plot(x,y);
    xlabel('x');
    ylabel('y');
end

[imf,residual] = emd(y);

sub_pic_num = 1+2 + size(imf,2) + 1;

figure();
subplot(sub_pic_num,1,1);
plot(x,y);
xlabel('x');
ylabel('y');
subplot(sub_pic_num,1,2);
plot(x,y1);
xlabel('x');
ylabel('y_1');
subplot(sub_pic_num,1,3);
plot(x,y2);
xlabel('x');
ylabel('y_2');

for i = 1:size(imf,2)
	subplot(sub_pic_num,1,i+3);
    plot(x,imf(:,i));
    xlabel('x');
    ylabel(['imf', num2str(i)]);
end
subplot(sub_pic_num,1,sub_pic_num);
plot(x,residual);
xlabel('x');
ylabel('residual');
