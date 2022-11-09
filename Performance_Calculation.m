clear all;
clc

PO = 10;   %
t_s = 0.3; % sec


zeta = -log(PO/100)/sqrt(pi^2+(log(20/100))^2)

w_n = 4/(zeta*t_s)
2*zeta*w_n
w_n^2


m1 = 1; m2 = 1;
L1 = 1; L2 = 1;
g = 9.81;

J_11 = (m1*L1^2)/3 + m2*L1^2 + (m2*L2^2)/3 + m2*L1*L2;
J_12 = (m2*L2^2)/3 + (m2*L1*L2)/2;
J_21 = (m2*L2^2)/3 + (m2*L1*L2)/2;
J_22 = (m2*L2^2)/3;



J = [ J_11, J_12;
      J_21, J_22];


Kv = J*[ 2*w_n*zeta, 0;
         0,          2*w_n*zeta]

Kp = J*[ 417.7923,  0;
         0,      417.7923]