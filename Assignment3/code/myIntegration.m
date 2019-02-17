function I = myIntegration(img, t, theta, step)
% Returns the integral of interpolated values along the line L(t, theta)
% Calculating the lower Darboux sum for convenience

[Y, X] = size(img);
O = [X/2, Y/2]; %Origin

st = sin(theta);
ct = cos(theta);

upper_limit = 1/ct * (Y/2 - 1 - t*st);
lower_limit = 1/ct * (-Y/2 - t*st);

I = 0;
for s = lower_limit:step:upper_limit
%     disp(s);
    qx = t*ct - s*st + X/2;
    qy = Y/2 -(t*st + s*ct);
    Vq = interp2(img,qx,qy);
    I = I + Vq*step;
end


    
