clc;
clear;

y_L=1;
y_H=2;
k=0.25;
r=0.004;
delta_L=0.04;

load('para.mat')
delta_H=0.0157;

[u_H,u_L,w_L,w_H,p_L,p_H,wage_ratio, wage_output_ratio_L] = sole_steady(y_L,y_H,k,r,delta_L,A,b,delta_H)
