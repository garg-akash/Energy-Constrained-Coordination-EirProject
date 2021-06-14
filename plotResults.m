%% Some nice colors
Red       = [0.8500   0.3250   0.0980];
Yellow   = [0.929    0.694    0.125 ];
Blue     = [0        0.4470   0.7410];  
Violet   = [0.4940   0.1840   0.5560];
Green    = [0.4660   0.6740   0.1880];
Cyan     = [0.3010   0.7450   0.9330];
Bordeaux = [0.6350   0.0780   0.1840]; 
Silver = 1/255*[200,200,200];
%%
figure
grid on
hold on;
plot(pt(:,1),'--','linewidth',2,'color','blue'),hold on,
plot(pt(:,2),'linewidth',2,'color','green'),hold on,
plot(pt(:,3),'--','linewidth',2,'color','red'),hold on,
xlabel('Simulation Time');ylabel('Meeting Point')
legend('$P_1$','$P_2$','$P_3$','Interpreter','latex')

figure
grid on
hold on;
plot(pzoom,pt(1:size(pzoom,2),1),'--','linewidth',2,'color','blue'),hold on,
plot(pzoom,pt(1:size(pzoom,2),2),'linewidth',2,'color','green'),hold on,
plot(pzoom,pt(1:size(pzoom,2),3),'--','linewidth',2,'color','red'),hold on,
xlabel('Simulation Time');ylabel('Meeting Point')
legend('$P_1$','$P_2$','$P_3$','Interpreter','latex')

figure
grid on
hold on;
plot(tt(:,1),'--','linewidth',2,'color','blue'),hold on,
plot(tt(:,2),'linewidth',2,'color','green'),hold on,
plot(tt(:,3),'--','linewidth',2,'color','red'),hold on,
xlabel('Simulation Time');ylabel('Meeting Time')
axis([0 3500 0 110]);
legend('$\tau_1$','$\tau_2$','$\tau_3$','Interpreter','latex')

figure
grid on
hold on;
plot(tzoom,tf(1)*ones(size(tzoom)),'--','linewidth',2,'color','blue'),hold on,
plot(tzoom,tf(2)*ones(size(tzoom)),'linewidth',2,'color','green'),hold on,
plot(tzoom,tf(3)*ones(size(tzoom)),'--','linewidth',2,'color','red'),hold on,
xlabel('Simulation Time');ylabel('Meeting Time')
axis([3440 3500 min(tf)-0.02 max(tf)+0.02]);
legend('$\tau_1$','$\tau_2$','$\tau_3$','Interpreter','latex')