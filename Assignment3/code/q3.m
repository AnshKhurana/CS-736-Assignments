clear all; close all;
% We arbitrarily choose the Shepp-Logan filter for FBP.
filt_type = 'Shepp-Logan';
t0_cand = [1:180];
theta_range = 150;
logger = zeros(numel(t0_cand), 2);

%% Part (a, b), Dataset myPhantom

load('../data/myPhantom.mat');
img = imageAC;
imsize = size(img, 1); % Assumed square

for t0 = t0_cand
    thetas = mod([t0:t0+theta_range], 180);
    imrad = radon(img, thetas);
    imfilt = myFilter(imrad, filt_type, 1);
    imdec = iradon(imfilt, thetas, 'linear', 'None', 1, imsize);
    logger(t0, 1) = rrmse(img, imdec);
end

[minval_phantom, min_t0_phantom] = min(logger(:, 1)); % min_t0 = 105;
figure, plot(logger(:, 1));
xlabel('\theta_0 Candidates')
ylabel('RRMSE')

thetas = mod([min_t0_phantom:min_t0_phantom+theta_range], 180);
imrad = radon(img, thetas);
imfilt = myFilter(imrad, filt_type, 1);
imdec = iradon(imfilt, thetas, 'linear', 'None', 1, imsize);

figure, imagesc(imdec);
title(strcat('Best Reconstruction of myPhantom with \theta_0=', num2str(min_t0_phantom), ' RRMSE=', num2str(minval_phantom)));

%% Part (a, b), Dataset Chest

load('../data/CT_Chest.mat');
img = imageAC;
imsize = size(img, 1); % Assumed square

for t0 = t0_cand
    thetas = mod([t0:t0+theta_range], 180);
    imrad = radon(img, thetas);
    imfilt = myFilter(imrad, filt_type, 1);
    imdec = iradon(imfilt, thetas, 'linear', 'None', 1, imsize);
    logger(t0, 2) = rrmse(img, imdec);
end

[minval_chest, min_t0_chest] = min(logger(:, 2)); % min_t0 = 35;
figure, plot(logger(:, 2));
xlabel('\theta_0 Candidates')
ylabel('RRMSE')

thetas = mod([min_t0_chest:min_t0_chest+theta_range], 180);
imrad = radon(img, thetas);
imfilt = myFilter(imrad, filt_type, 1);
imdec = iradon(imfilt, thetas, 'linear', 'None', 1, imsize);

figure, imagesc(imdec);
title(strcat('Best Reconstruction of CT_Chest with \theta_0=', num2str(min_t0_chest), ' RRMSE=', num2str(minval_chest)));