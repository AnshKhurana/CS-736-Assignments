%% Assignment 2, Image Denoising
%  CS736: Medical Image Computing, IIT Bombay (Spring 2019)
%  Dhruv Shah and Ansh Khurana
%%
% 
% Info
% 

clc; clear all; close all;
%% Question 1 

load('../data/assignmentImageDenoisingPhantom.mat');
img = real(imageNoisy); iorg = imageNoiseless;

% Part a. 
Initial_RRMSE = norm(iorg-img, 'fro')/norm(iorg, 'fro')

% Part b.

fprintf("The tuned parameters for quad prior: ");
alpha_q = 0.29
fprintf("The tuned parameters for Huber prior: ");
alpha_hu = 0.6
gamma_hu = 0.10
fprintf("The tuned parameters for Adaptive-Discontinuity prior: ");
alpha_ada = 0.69
gamma_ada = 0.05


[x_rec_quad, logger_q] = gradDesc(img, img, 'quadPrior', alpha_q, 0.1);
[x_rec_huber, logger_h] = gradDesc(img, img, 'huberPrior', alpha_hu, 0.1);
[x_rec_ada, logger_a] = gradDesc(img, img, 'adaPrior', alpha_ada, 0.1);


%%
figure('Position', [100, -50, 500, 700]);
subplot(3, 2, 1);
imagesc(iorg); caxis([-0.3, 1.3]);
title('Original Noiseless')
subplot(3, 2, 3);
imagesc(img); caxis([-0.3, 1.3]);
title({'Original Noisy', strcat('RRMSE: ', num2str(norm(iorg-img, 'fro')/norm(iorg, 'fro')))});
subplot(3, 2, 4);
imagesc(x_rec_quad); caxis([-0.3, 1.3]);
title({'Quadratic Loss', strcat('RRMSE: ', num2str(norm(iorg-x_rec_quad, 'fro')/norm(iorg, 'fro')))});
subplot(3, 2, 5);
imagesc(x_rec_huber); caxis([-0.3, 1.3]);
title({'Huber Loss', strcat('RRMSE: ', num2str(norm(iorg-x_rec_huber, 'fro')/norm(iorg, 'fro')))});
subplot(3, 2, 6);
imagesc(x_rec_ada); caxis([-0.3, 1.3]);
title({'Adaptive Loss', strcat('RRMSE: ', num2str(norm(iorg-x_rec_ada, 'fro')/norm(iorg, 'fro')))});
%% Question 2
load('../data/assignmentImageDenoisingBrainNoisy.mat');
img = real(imageNoisy);

fprintf("The tuned parameters for quad prior: ");
alpha_q = 0.59
fprintf("The tuned parameters for Huber prior: ");
alpha_hu = 
gamma_hu = 
fprintf("The tuned parameters for Adaptive-Discontinuity prior: ");
alpha_ada = 
gamma_ada = 

[x_rec_quad, logger_q] = gradDesc(img, img, 'quadPrior', 0.5, 0.1);
[x_rec_huber, logger_h] = gradDesc(img, img, 'huberPrior', 0.5, 0.1);
[x_rec_ada, logger_a] = gradDesc(img, img, 'adaPrior', 0.5, 0.1);

figure('Position', [100, -50, 500, 700]);
subplot(2, 2, 1);
imagesc(img); caxis([-0.3, 1.3]);
title({'Original Noisy'});
subplot(2, 2, 2);
imagesc(x_rec_quad); caxis([-0.3, 1.3]);
title({'Quadratic Loss'});
subplot(2, 2, 3);
imagesc(x_rec_huber); caxis([-0.3, 1.3]);
title({'Huber Loss'});
subplot(2, 2, 4);
imagesc(x_rec_ada); caxis([-0.3, 1.3]);
title({'Adaptive Loss'});


