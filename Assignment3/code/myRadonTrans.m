function Rf = myRadonTrans(img, t_range, theta_range, ds)

C = size(theta_range, 2);
R = size(t_range, 2);

Rf = zeros(R,C);

step = ds;
% 
% st_v = sind(theta_range);
% ct_v = cosd(theta_range);
% 
% % theta_m = repmat(theta_range',1, C);
% % t_m = repmat(t_range, R, 1);
% % 
% % st_m = sin(theta_m);
% % ct_m = cos(theta_m);
% 
% 
% imR = size(img, 1);
% imC = size(img, 2);
% 
% 
% % Limits of integration for all t and theta
% upper_limit = imR;
% lower_limit = -imR;
% 
% 
% for s = lower_limit:step:upper_limit
% %     disp(s);
%     s_v = repmat(s, size(t_range,2), 1);
%     x_M = t_range' *ct_v - s_v*st_v;
%     y_M = t_range'* st_v + s_v*ct_v;
%     
%     x_M = x_M + C/2;
%     y_M = R/2 - y_M;
%   
%     xcond = (x_M >= 1)& (x_M <= C);
%     ycond = (y_M <= R) & (y_M >= 1);
%     
%     Vq = zeros(R, C);
%   
%     Vq(xcond & ycond) = interp2(img, x_M(xcond & ycond),y_M(xcond & ycond));
% %     disp(size(Vq));
%     Rf = Rf + Vq*step;
% end

%     
%     if (x > -C/2) && (x < C/2) && (y < R/2) && (y > -R/2)
%         c = x + C/2;
%         r = R/2 -y;
%         Vq = interp2(img,c,r);
%     else
%         Vq = 0;
%     end
%     disp(Vq);






% Non vectorized approach 
for t = 1:R
    for th = 1:C
        Rf(t, th) = myIntegration(img, t_range(t), theta_range(th), ds);
    end
end
