function I = myIntegration(img, t, theta, step)
% Returns the integral of interpolated values along the line L(t, theta)
% Calculating the lower Darboux sum for convenience

[R, C] = size(img);

st = sind(theta);
ct = cosd(theta);

upper_limit = R;
lower_limit = -R;

I = 0;
for s = lower_limit:step:upper_limit
%     disp(s);
    x = t*ct - s*st;
    y = t*st + s*ct;
    c = x + C/2;
    r = R/2 -y;
    if (c >= 1) && (c <= C) && (r <= R) && (r >= 1)   
        Vq = interp2(img,c,r);
    else
        Vq = 0;
    end
%     disp(Vq);
    I = I + Vq*step;
end


    
