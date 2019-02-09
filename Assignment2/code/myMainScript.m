%% Assignment 2, Image Denoising
%  CS736: Medical Image Computing, IIT Bombay (Spring 2019)
%  Dhruv Shah and Ansh Khurana
%%
% 
% Info
% 

clc; clear all; close all;
%% 
load('../data/assignmentImageDenoisingPhantom.mat');
img = real(imageNoisy); iorg = imageNoiseless;

[x_rec_quad, logger_q] = gradDesc(img, img, 'quadPrior');
[x_rec_huber, logger_h] = gradDesc(img, img, 'huberPrior');
[x_rec_ada, logger_a] = gradDesc(img, img, 'adaPrior');


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