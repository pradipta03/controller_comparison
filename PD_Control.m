function dx = PD_Control(t, x)


%% x - x(1):error1, x(2):error2, x(3):dot_error1, x(4):dot_error2

global m1 m2 L1 L2 g
global Kv Kp

theta = zeros(2,1);
theta(1) = x(1);   theta(2) = x(2);
 c1 = cos(theta(1));             s1 = sin(theta(1));
 c2 = cos(theta(2));             s2 = sin(theta(2));
c12 = cos(theta(1)+theta(2));   s12 = sin(theta(1)+theta(2));

% J matrix
J_11 = (m1*L1^2)/3 + m2*L1^2 + (m2*L2^2)/3 + m2*L1*L2*c2;
J_12 = (m2*L2^2)/3 + (m2*L1*L2*c2)/2;
J_21 = (m2*L2^2)/3 + (m2*L1*L2*c2)/2;
J_22 = (m2*L2^2)/3;
J = [ J_11, J_12;
      J_21, J_22];

% D matrix
D_11 = 0;
D_12 = -(m2*L1*L2*s2)/2;
D_21 =  (m2*L1*L2*s2)/2;
D_22 = 0;
D = [D_11, D_12; 
    D_21, D_22]*[x(3)^2; x(4)^2];

% C matrix
C_11 = -m2*L1*L2*s2/2;
C_12 = -m2*L1*L2*s2/2;
C_21 = 0;
C_22 = 0;
C = [C_11, C_12; 
    C_21, C_22]*[x(1)*x(2); x(2)*x(1)];

% G matrix
G_1 = (m1/2 + m2)*g*L1*c1 + (m2*g*L2*c12)/2;
G_2 = (m2*g*L2*c12)/2;
G = [G_1;
    G_2];

% Linearized matrix  of G
Lin_G_1 = (m1/2 + m2)*g*L1 + (m2*g*L2)/2;
Lin_G_2 = (m2*g*L2)/2;
Lin_G = [Lin_G_1;
        Lin_G_2];

% zeta = 0.6523;
% w_n = 20.44;
% 
% Kv = J*[ 2*zeta*w_n, 0;
%          0,         2*zeta*w_n]
% 
% Kp = J*[ w_n^2,  0;
%          0,      w_n^2]
  
% solving equation
%X = -J\Kv*[x(3); x(4)] - J\Kp*[x(1); x(2)]  + J\G + J\D + J\C;
X =  -J\Kv*[x(3); x(4)] - J\Kp*[x(1); x(2)] + J\G + J\D + J\C;


dx = zeros(4,1);  % A column vector
dx(1) = x(3);
dx(2) = x(4);
dx(3) = X(1);
dx(4) = X(2);
