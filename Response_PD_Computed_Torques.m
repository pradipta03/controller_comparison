clear all;
clc

% global J_11 J_12 J_21 J_22
% global D_12 D_21
% global C_1
% global G_1 G_2
global m1 m2 L1 L2 g

m1 = 1; m2 = 1;
L1 = 1; L2 = 1;
g = 9.81;

%% x - x(1):error1, x(2):dot_error1, x(3):error2, x(4):dot_error2

% Initial Conditions
x_0 = [ deg2rad(1); 0; deg2rad(1); 0];
time = [0 1];

[t, x] = ode45(@PD_Computed_Torques, time, x_0);


figure(1)
plot(t,rad2deg(x(:,1)))

figure(2)
plot(t,rad2deg(x(:,3)))
