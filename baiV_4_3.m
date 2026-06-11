a = 0.2;    
b = 1.4;    
H = 3;      

[X, Y] = meshgrid(-6:0.005:6, -6:0.005:6); 
mask_cross = false(size(X));

for m = -4:4
    for n = -4:4
        if m == 0 || n == 0
            continue;
        end
        
        xc = n * b;
        yc = m * b;
        mask_cross((X - xc).^2 + (Y - yc).^2 <= a^2) = true;
    end
end

mask_dilated = conv2(double(mask_cross), ones(3), 'same') > 0;
boundary = mask_dilated & ~mask_cross;

Z = zeros(size(X));
Z(mask_cross) = H;         
Z(boundary) = 0;     

figure('Color', 'w');
surf(X, Y, Z, 'LineStyle', 'none');
colormap([0.2 0.2 0.7; 1 1 0]); % Nền xanh lam đậm, trụ màu vàng
title('Waveguide chữ thập (Mạng vuông)');
axis equal; grid on; view(3);
camlight('headlight'); lighting gouraud;