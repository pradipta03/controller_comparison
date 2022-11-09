function dx = Double_Link_Function(t, x)


%% x - x(1):theta1, x(2):dot_theta1, x(3):theta2, x(4):dot_theta(2)

global m1 m2 L1 L2 g

theta = zeros(2,1);
theta(1) = x(1);   theta(2) = x(3);
 c1 = cos(theta(1));             s1 = sin(theta(1));
 c2 = cos(theta(2));             s2 = sin(theta(2));
c12 = cos(theta(1)+theta(2));   s12 = sin(theta(1)+theta(2));

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


dx = zeros(4,1);  % a column vector

dx(1) = x(2);
dx(3) = x(4);

J = [ J_11, J_12;
      J_21, J_22];

A =   [ D_12*x(4)^2 + C_11*x(2)*x(4) + C_12*x(4)*x(2) + G_1 ;
        D_21*x(2)^2 + G_2 ];

T = [ 0; 
      0];

X = -J\A + J\T;

dx(2) = X(1);
dx(4) = X(2);