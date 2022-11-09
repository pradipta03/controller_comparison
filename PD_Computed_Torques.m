function dx = PD_Computed_Torques(t, x)


%% x - x(1):error1, x(2):dot_error1, x(3):error2, x(4):dot_error2

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


dx = zeros(4,1);  % a column vector

dx(1) = x(2);
dx(3) = x(4);

J = [ J_11, J_12;
      J_21, J_22];
  
zeta = 0.6523;
w_n = 20.44;

Kv = J*[ 2*zeta*w_n, 0;
         0,         2*zeta*w_n];

Kp = J*[ w_n^2,  0;
         0,      w_n^2];
Kv(1,2) = 0; Kv(2,1) = 0;
Kp(1,2) = 0; Kp(2,1) = 0;
Kp
Kv     
      
X = -J\Kv*[x(2); x(4)] - J\Kp*[x(1); x(3)];

dx(2) = X(1);
dx(4) = X(2);