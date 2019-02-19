clear all; close all;

imsize = 256;
img = phantom(imsize);
theta = [0:3:177];

imrad = radon(img, theta);

imdec_BP = iradon(imrad, theta, 'linear', 'None', 1, imsize);
% imagesc(imdec_BP)

modes = {'Ram-Lak', 'Cosine', 'Shepp-Logan'};

%% Verifying against Matlab implementations

for filt_type = modes
    imfilt = myFilter(imrad, char(filt_type), 1);
    imdec_ours = iradon(imfilt, theta, 'linear', 'None', 1, imsize);
    imdec_matlab = iradon(imrad, theta, 'linear', char(filt_type), 1, imsize);
    figure;
    subplot(1, 2, 1); imagesc(imdec_ours); colorbar;
    title(strcat(char(filt_type), '(Ours)'));
    subplot(1, 2, 2); imagesc(imdec_matlab); colorbar;
    title(strcat(char(filt_type), '(Matlab)'));
end

%% Part (a)

figure('Position', [100, 100, 1000, 400]);
subplot(1, 2, 1); imagesc(img);
title('Original');
subplot(1, 2, 2); imagesc(iradon(imrad, theta, 'linear', 'None', 1, imsize));
title('Unfiltered Back Projection')

for filt_type = modes
    imfilt1 = myFilter(imrad, char(filt_type), 1);
    imdec_ours1 = iradon(imfilt1, theta, 'linear', 'None', 1, imsize);
    imfilt2 = myFilter(imrad, char(filt_type), 0.5);
    imdec_ours2 = iradon(imfilt2, theta, 'linear', 'None', 1, imsize);
    figure('Position', [100, 100, 1000, 400]);
    subplot(1, 2, 1); imagesc(imdec_ours1);
    title(strcat(char(filt_type), '(L = w_{max})'));
    subplot(1, 2, 2); imagesc(imdec_ours2);
    title(strcat(char(filt_type), '(L = w_{max} / 2)'));
end

%% Part (b)

g1 = fspecial('gaussian', 11, 1);
g5 = fspecial('gaussian', 51, 5);

img1 = conv2(img, g1, 'same');
img5 = conv2(img, g5, 'same');

imrad1 = radon(img1, theta);
imrad5 = radon(img5, theta);

imfilt = myFilter(imrad, 'Ram-Lak', 1);
imfilt1 = myFilter(imrad1, 'Ram-Lak', 1);
imfilt5 = myFilter(imrad5, 'Ram-Lak', 1);

imdec = iradon(imfilt, theta, 'linear', 'None', 1, imsize);
imdec1 = iradon(imfilt1, theta, 'linear', 'None', 1, imsize);
imdec5 = iradon(imfilt5, theta, 'linear', 'None', 1, imsize);

rrmse_0 = rrmse(img, imdec);
rrmse_1 = rrmse(img, imdec1);
rrmse_5 = rrmse(img, imdec5);

%% Part (c)

fft_n = 1024;
logger = zeros([fft_n/2, 3]);
for i = 1:fft_n/2
    frac = i * 2 / fft_n;
    
    imfilt = myFilter(imrad, 'Ram-Lak', frac);
    imfilt1 = myFilter(imrad1, 'Ram-Lak', frac);
    imfilt5 = myFilter(imrad5, 'Ram-Lak', frac);

    imdec = iradon(imfilt, theta, 'linear', 'None', 1, imsize);
    imdec1 = iradon(imfilt1, theta, 'linear', 'None', 1, imsize);
    imdec5 = iradon(imfilt5, theta, 'linear', 'None', 1, imsize);

    logger(i, 1) = rrmse(img, imdec);
    logger(i, 2) = rrmse(img, imdec1);
    logger(i, 3) = rrmse(img, imdec5);
end

plot([2/fft_n:2/fft_n:1], logger, 'LineWidth', 1.5);
legend('Noiseless', '\sigma=1', '\sigma=5')
xlabel('L / w_{max}');
ylabel('RRMSE')