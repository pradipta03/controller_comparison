function dx = PD_Computed_Torques_Uncertainty(t, x)


%% x - x(1):error1, x(2):error2, x(3):dot_error1, x(4):dot_error2

global m1 m2 L1 L2 g
global m1_U m2_U L1_U L2_U
global Kv Kp


theta = zeros(2,1);
theta(1) = x(1);   
theta(2) = x(3);
 c1 = cos(theta(1));             s1 = sin(theta(1));
 c2 = cos(theta(2));             s2 = sin(theta(2));
c12 = cos(theta(1)+theta(2));   s12 = sin(theta(1)+theta(2));


%% Calculated Parameters %%
J_11 = (m1*L1^2)/3 + m2*L1^2 + (m2*L2^2)/3 + m2*L1*L2*c2;
J_12 = (m2*L2^2)/3 + (m2*L1*L2*c2)/2;
J_21 = (m2*L2^2)/3 + (m2*L1*L2*c2)/2;
J_22 = (m2*L2^2)/3;

D_11 = 0;                  D_12 = -(m2*L1*L2*s2)/2;
D_21 =  (m2*L1*L2*s2)/2;   D_22 = 0;

C_11 = -(m2*L1*L2*s2)/2;   C_12 = -(m2*L1*L2*s2)/2;
C_21 = 0;                  C_22 = 0;

G_1 = (m1/2 + m2)*g*L1*c1 + (m2*g*L2*c12)/2;
G_2 = (m2*g*L2*c12)/2;


%% Uncertainty included Parameters %%
J_11_U = (m1_U*L1_U^2)/3 + m2_U*L1_U^2 + (m2_U*L2_U^2)/3 + m2_U*L1_U*L2_U*c2;
J_12_U = (m2_U*L2_U^2)/3 + (m2_U*L1_U*L2_U*c2)/2;
J_21_U = J_12_U ;
J_22_U = (m2_U*L2_U^2)/3;

D_11_U = 0;                        D_12_U = -(m2_U*L1_U*L2_U*s2)/2;
D_21_U =  (m2_U*L1_U*L2_U*s2)/2;   D_22_U = 0;

C_11_U = -(m2_U*L1_U*L2_U*s2)/2;   C_12_U = -(m2_U*L1_U*L2_U*s2)/2;
C_21_U = 0;                        C_22_U = 0;

G_1_U = (m1_U/2 + m2_U)*g*L1_U*c1 + (m2_U*g*L2_U*c12)/2;
G_2_U = (m2_U*g*L2_U*c12)/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


J = [ J_11, J_12;
      J_21, J_22];
  
D = [ D_11, D_12;
      D_21, D_22]*[x(3)^2; x(4)^2];

C = [ C_11, C_12;
      C_21, C_22]*[x(1)*x(2); x(2)*x(1)];

G = [ G_1; G_2];  
      
J_U = [ J_11_U, J_12_U;
      J_21_U, J_22_U];
  
D_U = [ D_11_U, D_12_U;
      D_21_U, D_22_U]*[x(3)^2; x(4)^2];

C_U = [ C_11_U, C_12_U;
      C_21_U, C_22_U]*[x(1)*x(2); x(2)*x(1)];      

G_U = [ G_1_U; G_2_U];    

  
% zeta = 0.6523;
% w_n = 20.44;
% 
% Kv = J*[ 2*zeta*w_n, 0;
%          0,         2*zeta*w_n]
% 
% Kp = J*[ w_n^2,  0;
%          0,      w_n^2]
  

X = -J_U\Kv*[x(3); x(4)] - J_U\Kp*[x(1); x(2)]-J_U\(D-D_U)...
    - J_U\(C-C_U) - J_U\(G-G_U);

dx = zeros(4,1);  % a column vector

dx(1) = x(3);
dx(2) = x(4);
dx(3) = X(1);
dx(4) = X(2);