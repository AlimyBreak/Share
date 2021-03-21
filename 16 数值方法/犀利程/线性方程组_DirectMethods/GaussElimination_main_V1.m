% AlimyBreak 2021年3月21日 16:39:42
% Version 1.0 不支持换行的
close all;
clear;
clc;


% 0. Initialization
A = [1,1,1;2,3,4;6,8,11];%系数矩阵
x = [1,2.05,1.01]'; %原始待求解值
b = A*x; %生成系数
extra_matrix = [A,b]; %拼接增广矩阵
[M,N] = size(extra_matrix);%获取size 行数和列数
xx = zeros(1,N-1)';%求解结果存放向量
% 1. Elimination
n = 1;
while n < N
    for k = (n+1):M
        extra_matrix(k,:) = extra_matrix(k,:) - extra_matrix(n,:)*extra_matrix(k,n)/extra_matrix(n,n);
    end
    n = n + 1;
end


% 2. Backward sustitution
% 遍历每一列
n = N-1;
while n > 0
    xx(n) = (extra_matrix(n,N) -  extra_matrix(n,1:(N-1)  )*xx) / extra_matrix(n,n);
    n = n - 1;
end

xx