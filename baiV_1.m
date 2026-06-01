dx = 0.1; dy = 0.1;
x = -6 : dx : 6;
y = -8 : dy : 8;
H = 2;

[X, Y] = meshgrid(x, y);
[theta, r] = cart2pol(X, Y);

Z_a1 = zeros(size(Y)); 
Z_a2 = zeros(size(Y));
Z_a1(r <= 1.6) = H;
Z_a2(r >= 1 & r <= 1.8) = H;

Z_b = zeros(size(X));
box1 = (X >= -6 & X <= -4) & (Y >= -8 & Y <= -2);
box2 = (X >= -4 & X <= -1) & (Y >= -6 & Y <= -2);
box3 = (X >= -3 & X <= -1) & (Y >= -6 & Y <= 8);
Z_b(box1 | box2 | box3) = H;

subplot(1, 3, 1);
mesh(X, Y, Z_a1);
title('Hình (a) - Trụ đặc');
xlabel('x'); ylabel('y'); zlabel('z');

subplot(1, 3, 2);
mesh(X, Y, Z_a2);
title('Hình (a) - Trụ rỗng');
xlabel('x'); ylabel('y'); zlabel('z');

subplot(1, 3, 3);
mesh(X, Y, Z_b); 
title('Hình (b)');
xlabel('x'); ylabel('y'); zlabel('z');
