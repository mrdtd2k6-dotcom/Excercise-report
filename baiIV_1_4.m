I     = 0.02;     
m     = 0.25;     
R     = 0.33;     
alpha = 0.001;    
g     = 9.8;      

dt    = 0.001;            
t     = 0:dt:80;          
N     = length(t);        
theta = zeros(1, N);      

theta0_deg = 6;
theta(1)   = deg2rad(theta0_deg); 
theta(2)   = theta(1); 


for i = 2:(N-1)
    dtheta = (theta(i) - theta(i-1)) / dt;
    ddtheta = -(alpha/I)*dtheta - (m*g*R/I)*theta(i);
    theta(i+1) = 2*theta(i) - theta(i-1) + (dt^2)*ddtheta;
end

figure;
plot(t, rad2deg(theta), 'b-', 'LineWidth', 1.2);
title('Mô phỏng dao động tắt dần của con lắc vật lý');
xlabel('Thời gian t (s)');
ylabel('Góc lệch \theta (độ)');
grid on;