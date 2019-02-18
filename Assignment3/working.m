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
