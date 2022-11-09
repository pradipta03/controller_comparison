clear all;
clc

global m1 m2 L1 L2 g
global Kv Kp

m1 = 1; m2 = 1;
L1 = 1; L2 = 1;
g = 9.81;

%% x - x(1):error1, x(2):error2, x(3):dot_error1, x(4):dot_error2

% Initial Conditions
x_0 = [ deg2rad(1); deg2rad(1); 0; 0];
time = [0 1];

Kv = [ 70, 0;
         0, 50];
Kp = [ 2700, 0;
          0, 2000];
      
[t, x] = ode45(@PD_Control, time, x_0);


figure(1)
plot(t,rad2deg(x(:,1)))
axis([0,1,-0.1,1.2]);

figure(2)
plot(t,rad2deg(x(:,2)))
axis([0,1,-0.1,1.2]);