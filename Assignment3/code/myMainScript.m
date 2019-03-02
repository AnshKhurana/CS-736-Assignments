%% Assignment 3, CT Imaging
%  CS736: Medical Image Computing, IIT Bombay (Spring 2019)
%  Dhruv Shah and Ansh Khurana
%%
% <Description>

warning('off', 'all');
clc; clear all; close all;
%% Question 1 
img = phantom(128);
% imshow(f);
%% Part (a)
% myIntegration is implemented in myImplementation.m
% The integration is the lower Darboux sum over the pixel values on a given
% line specifed by (t, \theta). The parameter \delta_s is configurable 
% and is chosen to be 1*pixel width.
% We have used bilinear

%% Part (b)
% Implementation of Radon transformation can be found in myRadonTrans.m
% 
% Instead of calling myIntegration over the different ranges of t and
% \theta, the computation has been vectorized.
% 

%% Part (c) 
% Computation of Radon transform for different parameters:

dt = 1;
dth = 1; 

ds1 = 0.5;
ds2 = 1;
ds3 = 3;

t_range = -90:dt:90;
theta_range =  0:dth:175;

Rf1 = myRadonTrans(img, t_range, theta_range, ds1);
iptsetpref('ImshowAxesVisible','on')

subplot(1,3, 1), imshow(Rf1, [],'Ydata', t_range, 'Xdata', theta_range, 'InitialMagnification','fit')
xlabel('\theta (degrees)')
ylabel('t')
title("Radon transform \Delta\theta = 1, \Deltat = 1, \Deltas = 0.5");
colormap(gca,hot), colorbar

Rf1 = myRadonTrans(img, t_range, theta_range, ds2);
iptsetpref('ImshowAxesVisible','on')

subplot(1,3, 2), imshow(Rf1, [],'Ydata', theta_range, 'Xdata', t_range, 'InitialMagnification','fit')
xlabel('\theta (degrees)')
ylabel('t')
title("Radon transform \Delta\theta = 1, \Deltat = 1, \Deltas = 1");
colormap(gca,hot), colorbar


Rf1 = myRadonTrans(img, t_range, theta_range, ds3);
iptsetpref('ImshowAxesVisible','on')

subplot(1,3,3), imshow(Rf1, [],'Ydata', theta_range, 'Xdata', t_range, 'InitialMagnification','fit')
xlabel('\theta (degrees)')
ylabel('t')
title("Radon transform \Delta\theta = 1, \Deltat = 1, \Deltas = 3");
colormap(gca,hot), colorbar

%% Part (d)

%% Part (e)

%% Question 2
clear all; 
figure;
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

%% Question 3
clear all; 
figure;
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