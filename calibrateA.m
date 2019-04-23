function X=calibrateA(delta_L,y_L,r,tar_wL,tar_uL,k,A)
w_L=tar_wL*y_L; %set the wage to the target level
theta_L=(1+r)*(y_L-w_L)/((r+delta_L)*k)-A %theta would be dtermined by A as a variable
p=theta_L/(A+theta_L);%solve theta
uL=delta_L/(p+delta_L);%calculate staedy unemployment
X=tar_uL-uL;%peg the unemployment_L to the target
end