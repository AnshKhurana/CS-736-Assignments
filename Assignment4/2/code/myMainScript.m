clear all; close all;

%% 

load('../data/assignmentSegmentBrainGmmEmMrf.mat');

img = imageData;
mask = imageMask;
K = 3;
%% Choice of \beta
beta = 0.35;

%% Label Initialization
%  The brain image shows three broad ranges of image intensities that can
%  be segmented naively via thresholding. Function initLabelGuess performs
%  a naive thresholding into 3 categories based on intensities.
lab = initLabelGuess(img, mask);
mu = zeros(1, K);
sigma = zeros(1, K);

%% GM Initialization
%  Given the initial class labels, their empirical mean and covariance are
%  used to initialize the components of the Gaussian mixture. This is also
%  the ML estimate of the mixture parameters in this setting.
for label = 1:K
    positions = lab == label;
    mu(1, label) = mean(img(positions));
    sigma(1, label) = std(img(positions));
end;

%% Segmentation using GMM+HMRF
disp('Optimal Beta')
[L, G] = imageSegEM(img, mask, K, lab, mu, sigma, beta);
disp('No MRF Prior')
[L0, G0] = imageSegEM(img, mask, K, lab, mu, sigma, 0);

%% Results
figure('Position', [100, 100, 400, 400]), imshow(img);
title('Corrupted Image (Original)')
visClasses(L, G, beta)
visClasses(L0, G0, 0)

%% Class means after segmentation
for label = 1:K
    positions = L == label;
    mu_opt(1, label) = mean(img(positions));
    sigma_opt(1, label) = std(img(positions));
end;
disp(mu_opt)