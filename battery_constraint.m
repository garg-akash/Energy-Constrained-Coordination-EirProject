function con = battery_constraint(x_10,x_30,p,t)
    global alpha;
    con = (x_10(1)-p(1))^2 + (x_10(2)-p(2))^2 - x_30*(t-2*sqrt(alpha)*tanh(t/(2*sqrt(alpha))));
end