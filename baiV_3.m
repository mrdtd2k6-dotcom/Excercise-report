a = 0.2;    
b = 1.4;    
H = 3;      

[X, Y] = meshgrid(-6:0.05:6, -6:0.05:6); 

mask_sq = false(size(X));
mask_tri = false(size(X));
mask_hex = false(size(X));

% (a) Mạng vuông
for m = -5:5
    for n = -5:5
        mask_sq((X - n*b).^2 + (Y - m*b).^2 <= a^2) = true; 
    end
end

% (b) Mạng tam giác
for m = -5:5
    yc = m * b * sqrt(3)/2; 
    for n = -5:5
        xc = n * b + mod(m, 2) * (b/2);
        mask_tri((X - xc).^2 + (Y - yc).^2 <= a^2) = true;
    end
end

% (c) Mạng lục giác
for m = -4:4
    yc1 = m * b * 3/2; 
    yc2 = yc1 + b;
    for n = -4:4
        xc = n * b * sqrt(3) + mod(m, 2) * (b * sqrt(3)/2); 
        mask_hex((X - xc).^2 + (Y - yc1).^2 <= a^2) = true;
        mask_hex((X - xc).^2 + (Y - yc2).^2 <= a^2) = true;
    end
end

masks = {mask_sq, mask_tri, mask_hex};
titles = {'(a) Mạng vuông', '(b) Mạng tam giác', '(c) Mạng lục giác'};

for i = 1:3
    mask = masks{i};
    
    mask_dilated = conv2(double(mask), ones(3), 'same') > 0;
    boundary = mask_dilated & ~mask;
    
    Z = NaN(size(X));
    Z(mask) = H;         
    Z(boundary) = 0;     
    
    subplot(1, 3, i);
    mesh(X, Y, Z);
    title(titles{i});
    
    grid on;
    
    camlight('headlight'); 
    lighting gouraud; 
end