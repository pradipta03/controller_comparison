clear all;
clc

global m1 m2 L1 L2 g

m1 = 1; m2 = 1;
L1 = 1; L2 = 1;
g = 9.81;

%% x - x(1):error1, x(2):dot_error1, x(3):error2, x(4):dot_error2

% Initial Conditions
x_0 = [ deg2rad(1); 0; deg2rad(1); 0];
time = [0 1];

[t1, x_PD] = ode45(@PD_Control, time, x_0);
[t2, x_PD_Computed_Torques] = ode45(@PD_Computed_Torques, time, x_0);

figure(1)
plot(t1,rad2deg(x_PD(:,1)), 'b', t2,rad2deg(x_PD_Computed_Torques(:,1)), 'r')

figure(2)
plot(t1,rad2deg(x_PD(:,3)), 'b', t2,rad2deg(x_PD_Computed_Torques(:,3)), 'r')
