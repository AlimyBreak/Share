% 等离子体物理 单粒子运动模拟程序
% 南喵展昭/AlimyBreak 2020.07.19 
% 致谢: https://www.bilibili.com/video/av61631165
close all;
clear;
clc;


% 粒子的初始位置
pos1 = [0,0,0];
pos2 = [0,0,0];

% 环境电磁场
B0 = [0,0,1];
E0 = [0,0,0];

% 粒子的初始位置
v1 = [1,0,0];
v2 = v1;


% 基本参数(质量瞎设置的，为了方便计算回旋半径，让荷质比直接等于1)
q1 = -1.6*10^-19;
m1 = 1.6*10^-19;
q2 = 1.6*10^-19;
m2 = 1.6*10^-19;
dt = 0.000001;

%
fobj = figure('pos',[100,100,500,500]);
colordef black
grid on;
axis equal;
view(3); %三维视角
hold on;



plant1 = plot3(pos1(1),pos1(2),pos1(3),'r:.','markersize',20);
plant2 = plot3(pos2(1),pos2(2),pos2(3),'g:.','markersize',20);


%三条动态线条
h1 = animatedline('color','r');
h2 = animatedline('color','g');




xlabel('X');
ylabel('Y');
zlabel('Z');
frame_count = 0;


writerObj = VideoWriter('test.avi');
open(writerObj); %// 打开该视频文件
while true

    temp1   =   E0 + cross(v1,B0);
    a1      =   temp1*q1/m1;
    temp2   =   E0 + cross(v2,B0);
    a2      =   temp2*q2/m2;
    
    %计算新位置
    pos1 = pos1 + v1*dt + 0.5*a1*dt^2;
    pos2 = pos2 + v2*dt + 0.5*a2*dt^2;

    %计算新速度
    v1 = v1 + a1*dt;
    v2 = v2 + a2*dt;
    
    %每10000次才插入一次
    frame_count = frame_count+1;
    if frame_count == 5000*2
        frame_count = 0;
        set(plant1,'Xdata',pos1(1),'Ydata',pos1(2),'Zdata',pos1(3));
        set(plant2,'Xdata',pos2(1),'Ydata',pos2(2),'Zdata',pos2(3));

        addpoints(h1,pos1(1),pos1(2),pos1(3));
        addpoints(h2,pos2(1),pos2(2),pos2(3));

        drawnow
        
        frame = getframe;%getframe方法获取当前figure上的图像
        writeVideo(writerObj,frame);%把图像存入视频文件中
        
    end
    
end


close(writerObj);