a = 0.25;    
b = 1.0;     
H = 3;       
[X, Y] = meshgrid(-6:0.01:6, -6:0.01:6);


mask = false(size(X));
for m = -8:8
    for n = -8:8
        if m == 0 || (n == 0 && m <= 0)
            continue
        end
        xc = n * b; 
        yc = m * b;
        mask((X - xc).^2 + (Y - yc).^2 <= a^2) = true;
    end
end
mask_dilated = conv2(double(mask), ones(3), 'same') > 0;
boundary = mask_dilated & ~mask;
Z = zeros(size(X));
Z(mask) = H; 
Z(boundary) = 0;

surf(X, Y, Z, 'LineStyle', 'none');
colormap(gca, [0.2 0.2 0.7; 1 1 0]);
axis equal; axis([-6 6 -6 6 0 H]); grid on; view(3);
camlight('headlight'); lighting gouraud;
