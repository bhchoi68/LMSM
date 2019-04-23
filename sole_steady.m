function [u_H,u_L,w_L,w_H,p_L,p_H,wage_ratio, wage_output_ratio_L]=sole_steady(y_L,y_H,k,r,delta_L,A,b,delta_H)
p=@(z)z/(A+z);

%Corresponds to equation (8) in solution
theta_L=@(w_L)(1+r)*(y_L-w_L)/(  (r+delta_L)*k)-A; 
theta_H=@(w_H)(1+r)*(y_H-w_H)/(  (r+delta_H)*k)-A;


pbar_L=@(x)p(theta_L(x));
pbar_H=@(x)p(theta_H(x));

%The value of quitting for workers
U_NS_L=((1+r)*b*y_L)/r;
U_NS_H=((1+r)*b*y_H)/r;

%utillity functions for both types

     U_L=@(x) ( (r+delta_L)*(1-pbar_L(x))*b*y_L+pbar_L(x)*x*(1+r) )/( r+delta_L+(1-delta_L)*pbar_L(x));
     U_H=@(x) ( (r+delta_H)*(1-pbar_H(x))*b*y_H+pbar_H(x)*x*(1+r) )/( r+delta_H+(1-delta_H)*pbar_H(x));


%Caveats: theta might be negative. First we know theta is a decreasing
%function of w. Use root finding procedure to find the w that has the zero market
%tightness. Use that w as the upper bound to generate grids of wage. Plug
%the wages into utility function, then locate the w that generates highest
%utility as the solution

 bar_WL=broyden(theta_L,.4);
 W_L=0:0.0001:bar_WL;
 U_L_temp=nan(length(W_L),1);
 for i=1:length(W_L)
    U_L_temp(i)=U_L(W_L(i));
    
 end
 [~,pos]=max(U_L_temp);
 w_L=W_L(pos);

%By equation (9)
u_L=delta_L/(pbar_L(w_L)+delta_L);
p_L=p(theta_L(w_L));

%If worker is better-off watching Netflix all day, wage is zero, the
%market is infnitely tight.
if U_NS_L>U_L(w_L)
    w_L=0;
    u_L=1;
    p_L=1;
end
 
%Same as L type
 bar_WH=broyden(theta_H,1);
 W_H=0:0.0001:bar_WH;
 U_H_temp=nan(length(W_H),1);
 for i=1:length(W_H)
    U_H_temp(i)=U_H(W_H(i)); 
 end
 [~,pos]=max(U_H_temp);
 w_H=W_H(pos);

u_H=delta_H/(pbar_H(w_H)+delta_H);
p_H=p(theta_H(w_H));


if U_NS_H>U_H(w_H)
    w_H=0;
    u_H=1;
    p_H=1;
end




wage_ratio=w_H/w_L;
wage_output_ratio_L=w_L/y_L;


  
end

