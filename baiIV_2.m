x = -10:0.05:10;
dx = 0.05;
N = length(x);

t0 = 0; t_end = 12; dt = 0.0001;
t = t0:dt:t_end;
num_steps = length(t);

V0 = 50; a = 0.8;
V = zeros(1, N);
V(x >= 0 & x <= a) = V0;

A0 = 1; w0 = 0.5; b = 2; k0 = 1.5;
Psi = A0 * exp(-(x+b).^2 / w0^2) .* exp(1i * k0 * x);

save_step = 800;
num_saves = floor(num_steps / save_step) + 1;
data_Psi = zeros(num_saves, N);
data_Psi(1, :) = abs(Psi).^2;
save_idx = 2;

f_Psi = @(psi) -1i * (-0.5 * dao_ham2(psi, dx) + V .* psi);

for n = 1:(num_steps-1)
    k1 = f_Psi(Psi);
    k2 = f_Psi(Psi + 0.5*dt*k1);
    k3 = f_Psi(Psi + 0.5*dt*k2);
    k4 = f_Psi(Psi + dt*k3);
   
    Psi = Psi + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
   
    Psi(1) = 0; 
    Psi(end) = 0;
   
    if mod(n, save_step) == 0
        data_Psi(save_idx, :) = abs(Psi).^2;
        save_idx = save_idx + 1;
    end
end

figure;
T_mesh = (0:(save_idx-2)) * save_step * dt; 
[X, T] = meshgrid(x, T_mesh);
waterfall(X, T, data_Psi(1:save_idx-1, :));
xlabel('Vị trí x'); ylabel('Thời gian t'); zlabel('Mật độ xác suất |\Psi(x,t)|^2');
title('Động lực học sóng electron qua rào thế');
colormap jet;


function d2f = dao_ham2(f, dx)
    d2f = zeros(size(f));
    d2f(2:end-1) = (f(3:end) - 2*f(2:end-1) + f(1:end-2)) / (dx^2);
end
