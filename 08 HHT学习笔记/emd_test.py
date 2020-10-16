# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 16:01:27 2019

@author: veepoo
"""


from pyhht.visualization import plot_imfs
import numpy as np
import pyhht
import math 


t = np.linspace(0, 100, 1000);
fs1 = 4;
fs2 = 10;
modes = np.cos(math.radians(2 * math.pi * fs1 * t)) + np.cos(math.radians(2 * math.pi * fs2 * t))
x = modes + t
decomposer = pyhht.EMD(x)
imfs = decomposer.decompose()
plot_imfs(x, imfs, t) #doctest: +SKIP