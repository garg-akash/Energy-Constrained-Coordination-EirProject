function xdot = my_ode(tt,y)
    global alpha rho x_10 x_30;
    p = y(1:3,2);
    t = y(4:6,2);
    mu = y(7:9,2);
    if (battery_constraint(x_10(1,:),x_30(1),p(1,:),t(1))>0 || mu(1)>0)
        mudot(1) = battery_constraint(x_10(1,:),x_30(1),p(1,:),t(1));
    else
        mudot(1) = 0;
    end
    if (battery_constraint(x_10(2,:),x_30(2),p(2,:),t(2))>0 || mu(2)>0)
        mudot(2) = battery_constraint(x_10(2,:),x_30(2),p(2,:),t(2));
    else
        mudot(2) = 0;
    end
    if (battery_constraint(x_10(3,:),x_30(3),p(3,:),t(3))>0 || mu(3)>0)
        mudot(3) = battery_constraint(x_10(3,:),x_30(3),p(3,:),t(3));
    else
        mudot(3) = 0;
    end  
    dhdp = @(p_,x_10) (2*p_ - 2*x_10);
    pdot = [-(y(1)-y(2))-(y(1)-y(3))-dhdp(y(1,:),x_10(1))*mu(1),...
            -(y(2)-y(1))-(y(2)-y(3))-dhdp(y(2,:),x_10(2))*mu(2),...
            -(y(3)-y(1))-(y(3)-y(2))-dhdp(y(3,:),x_10(3))*mu(3)];

    dhdt = @(t_,x30) (-x30*tanh(t_/(2*alpha^(1/2)))^2);
    tdot = [-(t(1)-t(2))-(t(1)-t(3))-rho*t(1)-dhdt(t(1),x_30(1))*mu(1),...
            -(t(2)-t(1))-(t(2)-t(3))-rho*t(2)-dhdt(t(2),x_30(2))*mu(2),...
            -(t(3)-t(1))-(t(3)-t(2))-rho*t(3)-dhdt(t(3),x_30(3))*mu(3)];
    %mudot = zeros(1,3);

    xdot = [pdot';tdot';mudot'];
end