%Han Yang, PSU, Econ PHD, Econ 558 final Exam

clc
clear
%specify the baseline parameter
y_L=1;
y_H=2;
k=0.15;
r=0.004;
delta_L=0.04;

%specify the target
tar_wL=0.4;
tar_uL=0.09;
tar_uH=0.03;

%Calibrate A using Broyden root finding procedure
A_cali=@(x)calibrateA(delta_L,y_L,r,tar_wL,tar_uL,k,x);
A=broyden(A_cali,1)

%Calibrate b using Broyden root finding procedure
b_cali=@(b)cali_b(delta_L,y_L,r,tar_wL,k,A,b);
b=broyden(b_cali,0)

%Save the calibrated parameters
save('para.mat','A','b')