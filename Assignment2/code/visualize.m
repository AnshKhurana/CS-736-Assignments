% Tuning for Q2
clc; clear all; close all;

%% Question 2

load('../data/assignmentImageDenoisingBrainNoisy.mat');
img = real(imageNoisy);
% Tuning quad prior
quad_res = @ (x) gradDesc(img, img, 'quadPrior', x, 1);
imagesc(img);
title("The original noisy image");
figure; 
% % Round 1
% figure('Position', [100, -50, 500, 700]);
% alphas = linspace(0, 1, 11);
% 
% for i = 1:length(alphas)
%     img_temp = quad_res(alphas(i));
% %     subplot(4, 3, i);
%     imagesc(img_temp); caxis([-0.3, 1.3]);
%     title("alpha =" + num2str(alphas(i)));
%     figure('Position', [100, -50, 500, 700]);
%     
% end
% sgtitle("Round1 quad prior");
% % Round 2

alphas = linspace(0.3, 0.7, 11);

for i = 1:length(alphas)
    img_temp = quad_res(alphas(i));
%     subplot(4, 3, i);
    imagesc(img_temp); caxis([-0.3, 1.3]);
    title("alpha =" + num2str(alphas(i)));
    figure;
    
end