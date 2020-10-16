% ����ĳ��BվUp��,������������.
% ����������ģ�������������ڳ�ʼ�ٶȺ���������������������˶��켣.
close all;
clear;
clc;

% �������������
m1 = rand()*10^23;
m2 = rand()*10^23;
m3 = rand()*10^23;
% ��������ĳ�ʼλ��
pos1 = [rand()*10^7,rand()*10^7,rand()*10^7];
pos2 = [rand()*10^7,rand()*10^7,rand()*10^7];
pos3 = [rand()*10^7,rand()*10^7,rand()*10^7];

% ��������ĳ�ʼ�ٶ�
v1 = [rand()*1000,rand()*1000,rand()*1000];
v2 = [rand()*1000,-v1(2),rand()*1000];
v3 = [rand()*1000,-v1(2),rand()*1000];

% ��������
G = 6.67*10^(-11);
dt = 0.001;

%
fobj = figure('pos',[100,100,500,500]);
colordef black
grid on;
axis equal;
view(3); %��ά�ӽ�
hold on;



plant1 = plot3(pos1(1),pos1(2),pos1(3),'r:.','markersize',20);
plant2 = plot3(pos2(1),pos2(2),pos2(3),'g:.','markersize',20);
plant3 = plot3(pos3(1),pos3(2),pos3(3),'b:.','markersize',20);

%������̬����
h1 = animatedline('color','r');
h2 = animatedline('color','g');
h3 = animatedline('color','b');



xlabel('X');
ylabel('Y');
zlabel('Z');
frame_count = 0;


writerObj = VideoWriter('test.avi');
open(writerObj); %// �򿪸���Ƶ�ļ�
while true
    % �������
    d12 = normest(pos2-pos1);
    d23 = normest(pos3-pos2);
    d13 = normest(pos3-pos1);
    
    %�������������Ĵ�С
    F12_val = G*m1*m2 /(d12^2);
    F23_val = G*m2*m3 /(d23^2);
    F13_val = G*m1*m3 /(d13^2);
    
    %�������������ķ���
    F12_dir = (pos2-pos1)/normest(pos2-pos1);
    F23_dir = (pos3-pos2)/normest(pos3-pos2);
    F13_dir = (pos3-pos1)/normest(pos3-pos1);
    
    %������������������������ɵļ��ٶ�
    a1 = ( F12_val*F12_dir + F12_val*F13_dir)/m1;
    a2 = (-F12_val*F12_dir + F23_val*F23_dir)/m2;
    a3 = (-F13_val*F13_dir - F23_val*F23_dir)/m3;
    
    %������λ��
    pos1 = pos1 + v1*dt + 0.5*a1*dt^2;
    pos2 = pos2 + v2*dt + 0.5*a2*dt^2;
    pos3 = pos3 + v3*dt + 0.5*a3*dt^2;
    %�������ٶ�
    v1 = v1 + a1*dt;
    v2 = v2 + a2*dt;
    v3 = v3 + a3*dt;
    
    %ÿ1000�βŲ���һ��
    frame_count = frame_count+1;
    if frame_count == 1000
        frame_count = 0;
        set(plant1,'Xdata',pos1(1),'Ydata',pos1(2),'Zdata',pos1(3));
        set(plant2,'Xdata',pos2(1),'Ydata',pos2(2),'Zdata',pos2(3));
        set(plant3,'Xdata',pos3(1),'Ydata',pos3(2),'Zdata',pos3(3));
        addpoints(h1,pos1(1),pos1(2),pos1(3));
        addpoints(h2,pos2(1),pos2(2),pos2(3));
        addpoints(h3,pos3(1),pos3(2),pos3(3));
        drawnow
        
        frame = getframe;%getframe������ȡ��ǰfigure�ϵ�ͼ��
        writeVideo(writerObj,frame);%��ͼ�������Ƶ�ļ���
        
    end
    
    if d12 == 0 || d23 == 0 || d13 == 0
        break;
    end
    
end


close(writerObj);