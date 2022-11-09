function dx = PD_Control_Trajectory(t, x)


%% x - x(1):theta1, x(2):dot_theta1, x(3):theta2, x(4):dot_theta2

global m1 m2 L1 L2 g Index_Cnt

Index_Cnt = Index_Cnt + 1;

if Index_Cnt > 101
    Index_Cnt = 101
endif

load Desired_Motion.txt;

theta = zeros(2,1);
theta(1) = x(1);   theta(2) = x(3);
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
    D_21, D_22]*[x(2)^2; x(4)^2];

% C matrix
C_11 = -m2*L1*L2*s2/2;
C_12 = -m2*L1*L2*s2/2;
C_21 = 0;
C_22 = 0;
C = [C_11, C_12; 
    C_21, C_22]*[x(1)*x(3); x(3)*x(1)];

% G matrix
G_1 = (m1/2 + m2)*g*L1*c1 + (m2*g*L2*c12)/2;
G_2 = (m2*g*L2*c12)/2;
G = [G_1;
    G_2];


zeta = 0.6523;
w_n = 20.44;

Kv = J*[ 2*zeta*w_n, 0;
         0,         2*zeta*w_n];

Kp = J*[ w_n^2,  0;
         0,      w_n^2];

     
% ddot_Angle = [ 0; 
%                0];
ddot_Angle = [ Desired_Motion(Index_Cnt, 4); 
                Desired_Motion(Index_Cnt, 7)];

Error     = [ 0;
              0];
dot_Error = [ 0;
              0];           
     
ddot_Angle = [ Desired_Motion(Index_Cnt, 4); 
                Desired_Motion(Index_Cnt, 7)];
% Error     = [ deg2rad(Desired_Motion(Index_Cnt, 2)) - x(1);
%               deg2rad(Desired_Motion(Index_Cnt, 5)) - x(3)];
% dot_Error = [ Desired_Motion(Index_Cnt, 3) - x(2);
%               Desired_Motion(Index_Cnt, 6) - x(4)];          
     
T = ddot_Angle + Kv*dot_Error + Kp*Error;

         
% solving equation
X = T - J\( D + C  );


dx = zeros(4,1);  % A column vector
dx(1) = x(2);
dx(3) = x(4);
dx(2) = X(1);
dx(4) = X(2);
