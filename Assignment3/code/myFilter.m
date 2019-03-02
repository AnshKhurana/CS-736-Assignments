function filt_rad = myFilter(imrad, type, window)
% Filter Radon Transform
% type: 'Ram-Lak', 'Shepp-Logan' or 'Cosine'
% imrad: m X n real matrix corresponding to radon transform of a 2D image

if (nargin < 2)
    type = 'Ram-Lak';
    window = 1;
end

fft_n = 1024;
filt = 2 * (0:(fft_n/2)) / fft_n;
w = 2 * pi * (0:size(filt, 2)-1) / fft_n;
L = window;

if strcmp(type, 'Ram-Lak')
    % Do nothing
elseif strcmp(type, 'Shepp-Logan')
    filt(2:end) = filt(2:end) .* (sin(w(2:end)/(2*L))./(w(2:end)/(2*L)));
elseif strcmp(type, 'Cosine')
    filt(2:end) = filt(2:end) .* cos(w(2:end)/(2*L));
end

filt(w > pi*L) = 0; % Window
filt = [filt'; filt(end-1:-1:2)'];

filt_imrad = fft(imrad, fft_n) .* repmat(filt, [1, size(imrad, 2)]);
filt_rad = ifft(filt_imrad);
filt_rad(size(imrad, 1)+1:end, :) = []; % Truncate projections