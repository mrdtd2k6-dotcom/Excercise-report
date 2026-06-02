x = -15 : 0.05 : 15;
y = -10 : 0.05 : 10;

[X, Y] = meshgrid(x, y); 
H = 2;
W = 1.2;


%(a):
bus = abs(Y + 3.5) <= W/2 & abs(X) <= 8;
R_grid = sqrt(X.^2 + (Y - 0.5).^2);
ring = R_grid >= (3.5 - W) & R_grid <= 3.5;
a = bus | ring;

%(b):
Yc_b = 3 * sin(X * pi / 6); 
Yc_b(X < -3) = -3; Yc_b(X > 3) = 3;
b = abs(Y - Yc_b) <= W/2 & abs(X) <= 8;

%(c):
Yc_c_top = ones(size(X)) * 0.8;
Yc_c_top(X < -4) = 4;
Yc_c_top(X > 4) = 4;
mask_left = X >= -4 & X < -2;
Yc_c_top(mask_left) = 0.8 + 1.6 * (-X(mask_left) - 2);
mask_right = X > 2 & X <= 4;
Yc_c_top(mask_right) = 0.8 + 1.6 * (X(mask_right) - 2);
Yc_c_bot = -Yc_c_top;
c = (abs(Y - Yc_c_top) <= W/2 | abs(Y - Yc_c_bot) <= W/2) & abs(X) <= 8;

%(d):
Yc_d_top = zeros(size(X));
Yc_d_top(abs(X) <= 3) = 3; 
mask_split = X > -6 & X < -3; 
Yc_d_top(mask_split) = X(mask_split) + 6;
mask_comb = X > 3 & X < 6;    
Yc_d_top(mask_comb) = -X(mask_comb) + 6;
Yc_d_bot = -Yc_d_top;
d = (abs(Y - Yc_d_top) <= W/2 | abs(Y - Yc_d_bot) <= W/2) & abs(X) <= 9;


masks = {a, b, c, d};
titles = {'(a)', '(b)', '(c)', '(d)'};

for i = 1:4
    mask = masks{i};
    
    mask_dilated = conv2(double(mask), ones(3), 'same') > 0;
    boundary = mask_dilated & ~mask;
    
    Z = NaN(size(X));
    Z(mask) = H;         
    Z(boundary) = 0;     

    subplot(2, 2, i);
    mesh(X, Y, Z);
   
    title(titles{i});
    view(-35, 45);
    grid on;
    
    camlight('headlight'); 
    lighting gouraud; 
end
