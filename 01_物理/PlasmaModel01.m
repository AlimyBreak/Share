% ������������ �������˶�ģ�����
% ����չ��/AlimyBreak 2020.07.19 
% ��л: https://www.bilibili.com/video/av61631165
close all;
clear;
clc;


% ���ӵĳ�ʼλ��
pos1 = [0,0,0];
pos2 = [0,0,0];

% ������ų�
B0 = [0,0,1];
E0 = [0,0,0];

% ���ӵĳ�ʼλ��
v1 = [1,0,0];
v2 = v1;


% ��������(����Ϲ���õģ�Ϊ�˷����������뾶���ú��ʱ�ֱ�ӵ���1)
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
view(3); %��ά�ӽ�
hold on;



plant1 = plot3(pos1(1),pos1(2),pos1(3),'r:.','markersize',20);
plant2 = plot3(pos2(1),pos2(2),pos2(3),'g:.','markersize',20);


%������̬����
h1 = animatedline('color','r');
h2 = animatedline('color','g');




xlabel('X');
ylabel('Y');
zlabel('Z');
frame_count = 0;


writerObj = VideoWriter('test.avi');
open(writerObj); %// �򿪸���Ƶ�ļ�
while true

    temp1   =   E0 + cross(v1,B0);
    a1      =   temp1*q1/m1;
    temp2   =   E0 + cross(v2,B0);
    a2      =   temp2*q2/m2;
    
    %������λ��
    pos1 = pos1 + v1*dt + 0.5*a1*dt^2;
    pos2 = pos2 + v2*dt + 0.5*a2*dt^2;

    %�������ٶ�
    v1 = v1 + a1*dt;
    v2 = v2 + a2*dt;
    
    %ÿ10000�βŲ���һ��
    frame_count = frame_count+1;
    if frame_count == 5000*2
        frame_count = 0;
        set(plant1,'Xdata',pos1(1),'Ydata',pos1(2),'Zdata',pos1(3));
        set(plant2,'Xdata',pos2(1),'Ydata',pos2(2),'Zdata',pos2(3));

        addpoints(h1,pos1(1),pos1(2),pos1(3));
        addpoints(h2,pos2(1),pos2(2),pos2(3));

        drawnow
        
        frame = getframe;%getframe������ȡ��ǰfigure�ϵ�ͼ��
        writeVideo(writerObj,frame);%��ͼ�������Ƶ�ļ���
        
    end
    
end


close(writerObj);