w0 = 2;             
tspan = [0 30];     

ode_star = @(t, y) [y(2); -w0^2 * sin(y(1))]; 
ode_2star = @(t, y) [y(2); -w0^2 * y(1)];     

theta0_large = [pi/3; 0]; 
[t1, y1] = ode45(ode_star, tspan, theta0_large);

figure(1);
plot(t1, y1(:,1), 'b', 'LineWidth', 1.5);
title('Đồ thị \theta(t) cho phương trình (*) - Góc lớn \theta_0 = \pi/3');
xlabel('Thời gian t (s)'); ylabel('Góc \theta (rad)');
grid on;


theta0_small = [pi/30; 0];

[t2_star, y2_star] = ode45(ode_star, tspan, theta0_small);
[t2_2star, y2_2star] = ode45(ode_2star, tspan, theta0_small);

figure(2);
plot(t2_star, y2_star(:,1), 'b-', 'LineWidth', 1.5); hold on;
plot(t2_2star, y2_2star(:,1), 'r--', 'LineWidth', 1.5);
title('So sánh phương trình (*) và (**) - Góc nhỏ \theta_0 = \pi/30');
xlabel('Thời gian t (s)'); ylabel('Góc \theta (rad)');
legend('(*)', '(**)');
grid on;