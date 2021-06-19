clc
clear all
close all
global rho alpha x_10 x_30;
rho = 0.01;
alpha = 5;
x_10 = [10,20,30]'; %initial position of robots
x_20 = [100,100,100]'; %initial meeting time of robots
x_30 = [30,30,5]'; %initial battery level of robots

p = optimvar('p',3,1);
t = optimvar('t',3,1,'LowerBound',0);
prob = optimproblem;
prob.Objective = 0.5*rho*t(1)^2 + (p(1)-p(2))^2 + (t(1)-t(2))^2 ...
                + (p(1)-p(3))^2 + (t(1)-t(3))^2 + ...
                0.5*rho*t(2)^2 + (p(2)-p(1))^2 + (t(2)-t(1))^2 ...
                + (p(2)-p(3))^2 + (t(2)-t(3))^2 + ...
                0.5*rho*t(3)^2 + (p(3)-p(1))^2 + (t(3)-t(1))^2 ...
                    + (p(3)-p(2))^2 + (t(3)-t(2))^2;
prob.Constraints.cons1 = battery_constraint(x_10(1),x_30(1),p(1),t(1)) <= 0;
prob.Constraints.cons2 = battery_constraint(x_10(2),x_30(2),p(2),t(2)) <= 0;
prob.Constraints.cons3 = battery_constraint(x_10(3),x_30(3),p(3),t(3)) <= 0;
x0.p = x_10;
x0.t = x_20;
sol = solve(prob,x0);
pf = sol.p;
tf = sol.t;

% T_total = 35;
% Ts = 0.001;
% ts = 0:Ts:T_total;
% numSteps = size(ts,2);
% for i = 1:3
%     v1(i) = 2*(x_10(i)-pf(i))/(tf(i)-2*sqrt(alpha)*tanh(tf(i)/(2*sqrt(alpha))));
%     v2(i) = -sqrt(alpha)*tanh(tf(i)/(2*sqrt(alpha)))*v1(i);
%     c1(i) = 1/2*exp(-tf(i)/sqrt(alpha))*(v2(i)-v1(i)*sqrt(alpha));
%     c2(i) = 1/2*exp(tf(i)/sqrt(alpha))*(v2(i)+v1(i)*sqrt(alpha));
% end
% 
% for k = 1:numSteps
% for i = 1:3
%     u(i) = -1/(2*alpha)*( c1(i)*exp(ts(k)/sqrt(alpha)) + c2(i)*exp(-ts(k)/sqrt(alpha)) );
% end
% end

bc1 = battery_constraint(x_10(1),x_30(1),x_10(1),x_20(1));
bc2 = battery_constraint(x_10(2),x_30(2),x_10(2),x_20(2));
bc3 = battery_constraint(x_10(3),x_30(3),x_10(3),x_20(3));
tspan = linspace(0,1000,3500);
% [t_,y] = ode45(@my_ode,tspan,[x_10;x_20;[bc1;bc2;bc3]]);
[t_,y] = ode45(@my_ode,linspace(0,400,3500),[x_10;x_20;zeros(3,1)]);
pt = y(:,1:3);
tt = y(:,4:6);

pzoom = linspace(0,2,30);
tzoom = linspace(3440,3500,60);

plotResults;
TminAnalysis; %to analyse how distance covered affect min time required