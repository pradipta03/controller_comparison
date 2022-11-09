clear all;
clc

global m1 m2 L1 L2 g Index_Cnt

m1 = 1; m2 = 1;
L1 = 1; L2 = 1;
g = 9.81;

%% x - x(1):error1, x(2):dot_error1, x(3):error2, x(4):dot_error2

% Initial Conditions
%x_0 = [ deg2rad(1); 0; deg2rad(1); 0];
%time = [0 1];
load Desired_Motion.txt;
time = Desired_Motion(:,1);

x_0 = [ deg2rad(Desired_Motion(1,2)); Desired_Motion(1,3);...
        deg2rad(Desired_Motion(1,5)); Desired_Motion(1,6)];

Index_Cnt = 0;

[t, x] = ode45(@PD_Control_Trajectory, time, x_0);


figure(1)
plot(t,rad2deg(x(:,1)),'b', t, Desired_Motion(:,2),'r')

break;
figure(2)
plot(t,rad2deg(x(:,3)))
axis([0,1,-3,1.5]);