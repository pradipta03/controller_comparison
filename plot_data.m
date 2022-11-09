clear all
clc;

load Desired_Motion.txt

figure(1)
plot(Desired_Motion(:,1), Desired_Motion(:,2),'b', Desired_Motion(:,1), Desired_Motion(:,5),'r')
legend('theta 1', 'theta 2')

figure(2)
plot(Desired_Motion(:,1), Desired_Motion(:,3),'b', Desired_Motion(:,1), Desired_Motion(:,6),'r')
legend('dot theta 1', 'dot theta 2')