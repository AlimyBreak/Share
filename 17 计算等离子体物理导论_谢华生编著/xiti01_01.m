close all;
clear;
clc;

G = 6.67e-11;
k = 9.0e9;
m = [9.11e-31,1.67e-27];
q = 1.6e-19;

m_1 = m(2);
m_2 = m(2);


scale = G*m_1*m_2 /(k*q*q)