% 等离子体物理 单粒子运动模拟程序-用在E×B漂移运动模拟
% 南喵展昭/AlimyBreak 2021.05.25 
% 原始代码致谢: https://www.bilibili.com/video/av61631165
% 相关参数取自(计算等离子体物理导论 谢华生 p71.)
close all;
clear;
clc;


% 粒子的初始位置
pos1 = [0,0,0];
% 环境电磁场
B0 = [0,0,1];
E0 = [0,1,0];

% 粒子的初始位置
v1 = [0,0,0];
% 电荷基本参数
q1 = 1;
m1 = 1;

dt = 0.000001;

%
fobj = figure('pos',[100,100,500,500]);
colordef black
grid on;
axis equal;
view(3); %三维视角
hold on;

plant1 = plot3(pos1(1),pos1(2),pos1(3),'r:.','markersize',20);
%三条动态线条
h1 = animatedline('color','r');
xlabel('X');
ylabel('Y');
zlabel('Z');
frame_count = 0;
xlim([0,100])
ylim([-5,10])
zlim([-5,5])

writerObj = VideoWriter('test.avi');
open(writerObj); %// 打开该视频文件
H = text(60,10,5,['(',num2str(pos1(1)),',',num2str(pos1(3)),',',num2str(pos1(3)),','')']);
while true

    % 计算加速度
    temp1   =   E0 + cross(v1,B0);
    a1      =   temp1*q1/m1;
    % 计算新位置
    pos1 = pos1 + v1*dt + 0.5*a1*dt^2;
    % 计算新速度
    v1 = v1 + a1*dt;
    frame_count = frame_count+1;
    if frame_count == 100000
        frame_count = 0;
        set(plant1,'Xdata',pos1(1),'Ydata',pos1(2),'Zdata',pos1(3));
        H.String = ['(',num2str(pos1(1),'%.2f'),',',num2str(pos1(2),'%.2f'),',',num2str(pos1(3),'%.2f'),')'];
        addpoints(h1,pos1(1),pos1(2),pos1(3));
        drawnow
        rect=[0 0 500 500];
        frame = getframe(gcf,rect);%getframe方法获取当前figure上的图像
        writeVideo(writerObj,frame);%把图像存入视频文件中 
    end 
end
close(writerObj); % Ctrl+C 停止程序后需要手动执行这句话才能生成视频文件