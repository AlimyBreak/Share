% AlimyBreak 2021年3月21日 16:39:42
% Version 2.0 
close all;
clear;
clc;


% 0. Initialization
A = [6,2,2,3;2,2/3,1/3,1;1,2,-1,2;1,3,6,8];%系数矩阵
%x = [1,2.05,1.01]'; %原始待求解值
b = [-2,1,0,10]'; %生成系数
extra_matrix = [A,b]; %拼接增广矩阵
[M,N] = size(extra_matrix);%获取size 行数和列数
xx = zeros(1,N-1)';%求解结果存放向量
% 1. Elimination
n = 1;
while n < N
    pivot_valid = 0;
    temp_idx = n;
    while temp_idx <= M
        if extra_matrix(temp_idx,n) > 1e-3
            if temp_idx == n
                pivot_valid = 1;
            else
                pivot_valid = 2;
            end
            break;
        end
        temp_idx = temp_idx + 1;
    end
    
    if pivot_valid == 0
        fprintf('can not be pivoting,please check data \n')
    elseif pivot_valid == 2
        temp = extra_matrix(n,:);
        extra_matrix(n,:) = extra_matrix(temp_idx,:);
        extra_matrix(temp_idx,:) = temp;
    end
    
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
A*xx - b