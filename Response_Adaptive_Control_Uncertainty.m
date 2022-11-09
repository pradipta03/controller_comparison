clear all;
clc

global m1 m2 L1 L2 g
global m1_U m2_U L1_U L2_U
global dot_PHI Kv Kp


% Calculated Parameter
m1 = 1; m2 = 1;
L1 = 1; L2 = 1;
g = 9.81;

L1_U = L1;  L2_U = L2;

dot_PHI = zeros(2,1);

%% x - x(1):error1, x(2):error2, x(3):dot_error1, x(4):dot_error2

% Initial Conditions
x_0 = [ deg2rad(1); deg2rad(1); 0; 0];
time = [0:0.01:1];

Kv = [ 90, 0;
         0, 80];
Kp = [ 2700, 0;
          0, 2500];

% for case1의 경우
m1_U = 1 + 0.1; m2_U = 1 + 0.1;
[t1, x_case1] = ode45(@Adpative_Control_Uncertainty, time, x_0);

figure(1)
plot(t1,rad2deg(x_case1(:,1)), 'b')
figure(2)
plot(t1,rad2deg(x_case1(:,2)), 'b')    

break;
% for case2의 경우
m1_U = 1 - 0.1; m2_U = 1 - 0.1;
[t2, x_case2] = ode45(@Adpative_Control_Uncertainty, time, x_0);


% for case3의 경우
m1_U = 1 + 0.2; m2_U = 1 + 0.2;
[t3, x_case3] = ode45(@Adpative_Control_Uncertainty, time, x_0);

% for case4의 경우
m1_U = 1 - 0.2; m2_U = 1 - 0.2;
g = 9.81;
[t4, x_case4] = ode45(@Adpative_Control_Uncertainty, time, x_0);

% for case5의 경우
m1_U = 1 + 0.3; m2_U = 1 + 0.3;
[t5, x_case5] = ode45(@Adpative_Control_Uncertainty, time, x_0);

% for case6의 경우
m1_U = 1 - 0.3; m2_U = 1 - 0.3;
[t6, x_case6] = ode45(@Adpative_Control_Uncertainty, time, x_0);


figure(1)
plot(t1,rad2deg(x_case1(:,1)), 'b', t2,rad2deg(x_case2(:,1)), 'r'...
    , t3,rad2deg(x_case3(:,1)), 'c', t4,rad2deg(x_case4(:,1)), 'y'...
    , t5,rad2deg(x_case5(:,1)), 'g', t6,rad2deg(x_case6(:,1)), 'k')
legend('case 1', 'case 2', 'case 3', 'case 4', 'case 5', 'case 6');


figure(2)
plot(t1,rad2deg(x_case1(:,2)), 'b', t2,rad2deg(x_case2(:,2)), 'r'...
    , t3,rad2deg(x_case3(:,2)), 'c', t4,rad2deg(x_case4(:,2)), 'y'...
    , t5,rad2deg(x_case5(:,2)), 'g', t6,rad2deg(x_case6(:,2)), 'k')
legend('case 1', 'case 2', 'case 3', 'case 4', 'case 5', 'case 6');

