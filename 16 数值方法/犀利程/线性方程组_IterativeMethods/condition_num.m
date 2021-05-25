close all;
clear;
clc;


A = [1,1,1;1,2,3;1,3,100];

A_inver = A^-1;

condition_numer = norm(A,2)*norm(A_inver,2)