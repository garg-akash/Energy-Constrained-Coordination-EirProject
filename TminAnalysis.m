%This script is an add-on to analyse how distance covered affect min time required
syms Tmin real
battery_initial1=20; battery_initial2=40;
total_dist = 20; delta_dist = 0.1;
step_dist = 0:delta_dist:total_dist;
nSteps = size(step_dist,2);
%eqn = dx^2/(Tmin - 2*sqrt(alpha)*tanh(Tmin/(2*sqrt(alpha))))-battery_initial == 0;
Tmin_log1 = []; Tmin_log2 = [];
for i=1:nSteps
    dx = step_dist(i);
    eqn1 = dx^2/(Tmin - 2*sqrt(alpha)*tanh(Tmin/(2*sqrt(alpha))))-battery_initial1 == 0;
    S1 = vpasolve(eqn1,Tmin);
    Tmin_log1 = [Tmin_log1 S1];
    
    eqn2 = dx^2/(Tmin - 2*sqrt(alpha)*tanh(Tmin/(2*sqrt(alpha))))-battery_initial2 == 0;
    S2 = vpasolve(eqn2,Tmin);
    Tmin_log2 = [Tmin_log2 S2];
end
figure
grid on
hold on;
plot(step_dist(1:end-1),Tmin_log1,'linewidth',2,'color','blue'),hold on,
plot(step_dist(1:end-1),Tmin_log2,'--','linewidth',2,'color','red'),hold on,
xlabel('$X_{1T}-X_{10}$','Interpreter','latex');ylabel('$T_{min}$','Interpreter','latex')
legend('$X_{30}=20$','$X_{30}=40$','Interpreter','latex')