function filt_rad = myFilter(imrad, type, window)
% Filter Radon Transform
% type: 'Ram-Lak', 'Shepp-Logan' or 'Cosine'
% imrad: m X n real matrix corresponding to radon transform of a 2D image

if (nargin < 2)
    type = 'Ram-Lak';
    window = 0.5;
end

w = floor(size(imrad, 1) / 2);
wmax = w; % Observed; confirm
L = floor(wmax * window);
lin = [1:w]; filt = lin;
if strcmp(type, 'Ram-Lak')
    filt(1:L) = 1;
    filt(L+1:w) = 0;
elseif strcmp(type, 'Shepp-Logan')
    filt(1:L) = sin(0.5 * pi * [1:L] / L) ./ (0.5 * pi * [1:L] / L);
    filt(L+1:w) = 0;
elseif strcmp(type, 'Cosine')
    filt(1:L) = cos(0.5 * pi * [1:L] / L);
    filt(L+1:w) = 0;
end

lin = lin.*filt;
if numel(lin)*2 == size(imrad, 1)
    disp('Error'); return;
    % lin = [lin lin(end:-1:1)];
elseif numel(lin)*2 == size(imrad, 1)-1
    lin = [0 lin lin(end:-1:1)];
end

filt_imrad = fft(imrad) .* repmat(lin', [1, size(imrad, 2)]);
filt_rad = ifft(filt_imrad);