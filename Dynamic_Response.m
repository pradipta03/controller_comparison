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

%% x - x(1):theta1, x(2):dot_theta1, x(3):theta2, x(4):dot_theta(2)

% Initial Conditions
x_0 = [ 0; 0; 0; 0];
time = [0 3];

[t, x] = ode45(@Double_Link_Function, time, x_0);


%load Double_Pendulum_1_sec.txt
load Double_Pendulum_3_sec.txt
% figure(1)
% plot(t,rad2deg(x(:,1)),'b', Double_Pendulum_3_sec(:,1), Double_Pendulum_3_sec(:,2), 'r')
% 
% figure(2)
% plot(t,rad2deg(x(:,3)),'b', Double_Pendulum_3_sec(:,1), Double_Pendulum_3_sec(:,3), 'r')

% figure(3)
% plot(t,x(:,2),'b', Double_Pendulum_3_sec(:,1), Double_Pendulum_3_sec(:,4), 'r')
% 
% figure(4)
% plot(t,x(:,4),'b', Double_Pendulum_3_sec(:,1), Double_Pendulum_3_sec(:,5), 'r')

% load theta_1.txt
% load theta_2.txt
% load dot_theta_1.txt
% load dot_theta_2.txt

% figure(1)
% plot(t,rad2deg(x(:,1)),'b', theta_1(:,1), theta_1(:,2), 'r')
% 
% figure(2)
% plot(t,rad2deg(x(:,3)+x(:,1)),'b', theta_2(:,1), theta_2(:,2), 'r')
% 
% figure(3)
% plot(t,-x(:,2),'b', dot_theta_1(:,1), dot_theta_1(:,2), 'r')
