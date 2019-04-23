function X=cali_b(delta_L,y_L,r,tar_wL,k,A,b)
x=tar_wL*y_L;
the_L=(1+r)*(y_L-x)/((r+delta_L)*k)-A;
p=the_L/(A+the_L);

dp=-A/(A+the_L)^2*(1+r)/((r+delta_L)*k);
X= ( (1+r)*(dp*x+p)-(r+delta_L)*dp*b*y_L )*(r+delta_L+(1-delta_L)*p)...
    -(1-delta_L)*dp*( (1+r)*p*x+(r+delta_L)*(1-p)*b*y_L  );
end