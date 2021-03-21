[Ref](https://www.bilibili.com/video/BV1K54y187dt?p=6)









# Gauss Elimination

## 1. Limitation

+ 系数矩阵为方阵且增广矩阵满秩。

## 2.  Steps

+ Initialization

```matlab
% 0. Initialization
A = [1,1,1;2,3,4;6,8,11];%系数矩阵
x = [1,2.05,1.01]'; %原始待求解值
b = A*x; %生成系数
extra_matrix = [A,b]; %拼接增广矩阵
[M,N] = size(extra_matrix);%获取size 行数和列数
xx = zeros(1,N-1)';%求解结果存放向量
```

+ Elimination

```matlab
% 1. Elimination
n = 1;
while n < N
    for k = (n+1):M
        extra_matrix(k,:) = extra_matrix(k,:) - extra_matrix(n,:)*extra_matrix(k,n)/extra_matrix(n,n);
    end
    n = n + 1;
end
  
```

+ Backward Substitution

```matlab
% 2. Backward sustitution
% 遍历每一列
n = N-1;
while n > 0
    xx(n) = (extra_matrix(n,N) -  extra_matrix(n,1:(N-1)  )*xx) / extra_matrix(n,n);
    n = n - 1;
end
xx %数据计算结果，并且与原始的x做比较
```



***

Pivoting 改进后:

```matlab
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
```

***

# LU分解(降低求解运算复杂度)

$$
\begin{eqnarray}
Ax&=&b\\
A&=&\left|
\begin{matrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33} \\
\end{matrix} 
\right|=LU=
\left|
\begin{matrix}
1 & 0 & 0 \\
l_{21} & 1 & 0 \\
l_{31} & l_{32} & 1 \\
\end{matrix} 
\right|
\left|
\begin{matrix}
u_{11} & u_{12} & u_{13} \\
0 & u_{22} & u_{23} \\
0 & 0 & u_{33} \\
\end{matrix} 
\right|

\\
a_{11} &=& u_{11}\\
a_{12} &=& u_{12}\\
a_{13} &=& u_{13}\\
a_{21} &=& l_{21}u_{11}\\
a_{22} &=& l_{21}u_{12}+u_{22}\\
a_{23} &=& l_{21}u_{13}+u_{23}\\
a_{31} &=& l_{31}u_{11}\\
a_{32} &=& l_{31}u_{12} + l_{32}u_{22}\\
a_{33} &=& l_{31}u_{13} + l_{32}u_{23} + u_{33}\\

u_{11} &=& a_{11}\\
u_{12} &=& a_{12}\\
u_{13} &=& a_{13}\\
l_{21} &=&\frac{a_{21}}{u_{11}}=\frac{a_{21}}{a_{11}}\\
u_{22} &=&a_{22} - l_{21}u_{12} =a_{22}-\frac{a_{21}}{a_{11}}a_{12}\\
u_{23} &=&a_{23} - l_{21}u_{13} = a_{23} - \frac{a_{21}}{a_{11}}a_{13}\\
l_{31} &=&\frac{a_{31}}{u_{11}} = \frac{a_{31}}{a_{11}}\\
l_{32} &=&\frac{a_{32}-l_{31}u_{12}}{u_{22}}=\frac{a_{32}-a_{12}a_{31}/a_{11}}{a_{22}-a_{21}a_{12}/a_{11}}\\
u_{33} &=& a_{33} -l_{31}u_{13} -  l_{32}u_{23} = a_{33} - \frac{a_{31}}{a_{11}}a_{13} -\left(\frac{a_{32}-a_{12}a_{31}/a_{11}}{a_{22}-a_{21}a_{12}/a_{11}}\right)\left(a_{23} - \frac{a_{21}}{a_{11}}a_{13}\right)\\


A&=&\left|
\begin{matrix}
1 & 0 & 0	\\
\frac{a_{21}}{a_{11}} & 1 & 0\\
\frac{a_{31}}{a_{11}} & \frac{a_{32}-a_{12}a_{31}/a_{11}}{a_{22}-a_{21}a_{12}/a_{11}} & 1
\end{matrix}
\right|
\left|
\begin{matrix}

a_{11} & a_{12} & a_{13}\\
0 & a_{22}-\frac{a_{21}}{a_{11}}a_{12} & a_{23} - \frac{a_{21}}{a_{11}}a_{13} \\
0 & 0 &a_{33} - \frac{a_{31}}{a_{11}}a_{13} -\left(\frac{a_{32}-a_{12}a_{31}/a_{11}}{a_{22}-a_{21}a_{12}/a_{11}}\right)\left(a_{23} - \frac{a_{21}}{a_{11}}a_{13}\right)

\end{matrix}



\right|


\end{eqnarray}
$$

***

# Tridiagonal Matrix:三对角矩阵

+ 示例如下
  $$
  A = \left|
  \begin{matrix}
  b_1 & c_1 & 0 & 0 \\
  a_1 & b_2 & c_2 & 0 \\
  0 &  a_2 & b_3 & c_3 \\
  0 & 0 & a_{3} & b_{4}
  
  \end{matrix}
  \right|
  $$

+ 其组成的方程形式为$a_ix_{i-1}+b_{i+1}x_{i} + c_{i+1}x_{i+1} = d_i$

+ 也可以通过LU分解将复杂度压低

