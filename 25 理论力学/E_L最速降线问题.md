$$
\begin{eqnarray}
T &= & \int_{0}^{x_1}\sqrt{\frac{1+y'^2}{2gy}}dx \\

L(y,y') &=&\sqrt{\frac{1+y'^2}{2gy}} \\

\frac{\part L}{\part y} &=& \frac{d}{dx}\left( \frac{\part L}{\part y'}\right)


\end{eqnarray}
$$

根据
$$
\begin{eqnarray}
\frac{d L}{dx} &=&  \frac{\part L}{\part y}\frac{\part y}{\part x}  + \frac{\part L}{\part y'}\frac{\part y'}{\part x}   \\
&=& \frac{\part L}{\part y}y' + \frac{\part L}{\part y'}y''\\

\frac{d}{dx}\left(y'\frac{\part L}{\part y'}\right) &=&  y''\frac{\part L}{\part y'} + y'\frac{d}{dx}\left(\frac{\part L }{\part y'}\right)


\end{eqnarray}
$$
$(5)-(6)$可以得到
$$
\begin{eqnarray}
\frac{d}{dx}\left(L - y'\frac{\part L}{\part y'}\right) &=& \frac{\part L}{\part y}y' - y'\frac{d}{dx}\left(\frac{\part L}{\part y'}\right) \\
&=& y'\left(\frac{\part L}{\part y} - \frac{d}{dx}\left(\frac{\part L}{\part y'}\right)\right)
\end{eqnarray}
$$
根据$(3)$和$(8)$，可以得到
$$
\begin{eqnarray}
\frac{d}{dx}\left(L - y'\frac{\part L}{\part y'}\right) &=& 0 \\

L - y'\frac{\part L}{\part y'} &=& C\\


\frac{\part L}{\part y'} &=&  \frac{y'}{\sqrt{2gy}\sqrt{1+y'^2}} \\

L - y'\frac{\part L}{\part y'} &=&  \sqrt{\frac{1+y'^2}{2gy}} - \frac{y'^2}{\sqrt{2gy}\sqrt{1+y'^2}} \\

&=& \frac{1}{\sqrt{2gy}\sqrt{1+y'^2}} \\
&=&C

\end{eqnarray}
$$
我们可以得到
$$
\begin{eqnarray}
y(1+y'^2) &=& \frac{1}{2gC^2} \\
\end{eqnarray}
$$


令$1/2gC^2 = 2r,x = x(\theta),y'= \cot\frac{\theta}{2}=\frac{\cos\frac{\theta}{2}}{\sin\frac{\theta}{2}}$

可以得到
$$
\begin{eqnarray}
y(1+y'^2)&=& y \left(1+ \frac{\cos^2\frac{\theta}{2}}{\sin^2\frac{\theta}{2}}\right) \\
&=& y\frac{1}{\sin^2\frac{\theta}{2}} &=& 2r
\\
y &=& 2r\sin^2\frac{\theta}{2} &=& r(1-\cos\theta)\\

\frac{dy}{d\theta} &=& \frac{dy}{dx}\frac{dx}{d\theta} \\
&=& \cot\frac{\theta}{2}\frac{dx}{d\theta} = r\sin\theta \\

\frac{dx}{d\theta} &=& \frac{r\sin\theta}{\cot\frac{\theta}{2}}
\\
&=& 2r\sin^2\frac{\theta}{2} \\
&=& r(1-\cos\theta)\\

x &=& r(\theta - \sin\theta)  + C_2

\end{eqnarray}
$$




***

**错误的推导**

$x,y$过零点,所以当$\theta = 0$时，$x=y = 0$

x,y过极值点,所以当$\theta = \pi$时,$x=x_1,y=y_1$
$$
\begin{eqnarray}
x(0) &=& C_2 = 0 \\
y(0) &=& 0 \\

x(\pi) &=&  r\pi = x_1 \\
y(\pi) &=&   2r = y_1



\end{eqnarray}
$$
摆线**顶点**构成的集合是一条直线
$$
y = \frac{2}{\pi}x
$$


****

参考链接：

1. [寻找“最好”（2）——欧拉-拉格朗日方程](https://www.cnblogs.com/bigmonkey/p/9519387.html)

2. [matlab拉格朗日曲线_欧拉神作之四——从“最速降曲线”问题到创立新学科](https://blog.csdn.net/weixin_39897127/article/details/112067472)
3. [从最速降线问题到欧拉-拉格朗日方程](https://zhuanlan.zhihu.com/p/45912984)

