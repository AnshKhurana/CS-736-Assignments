% Tuning for Q2
clc; clear all; close all;

%% Question 2

load('../data/assignmentImageDenoisingBrainNoisy.mat');
img = real(imageNoisy);
% Tuning huber prior
huber_res = @ (x, y) gradDesc(img, img, 'huberPrior', x, y);
imagesc(img);
title("The original noisy image");
figure; 

alphas =  linspace(0, 1, 6);
gammas =  linspace(0, 1, 6);

for i = 1:length(alphas)
    for j = 1:length(gammas)
        img_temp = huber_res(alphas(i), gammas(j));
        ind = 6 * (i - 1) + j;
        subplot(6, 6, ind);
        imagesc(img_temp); caxis([-0.3, 1.3]);
        title("alpha =" + num2str(alphas(i)) + " gamma =" + num2str(gammas(j)));
       
    end
end
sgtitle("Round1 Huber prior");
figure;

alphas =  linspace(0.2, 0.8, 6);
gammas =  linspace(0.2, 1, 6);

for i = 1:length(alphas)
    for j = 1:length(gammas)
        img_temp = huber_res(alphas(i), gammas(j));
        ind = 6 * (i - 1) + j;
        subplot(6, 6, ind);
        imagesc(img_temp); caxis([-0.3, 1.3]);
        title("alpha =" + num2str(alphas(i)) + " gamma =" + num2str(gammas(j)));
       
    end
end
sgtitle("Round2 Huber prior");



figure;

alphas =  linspace(0.2, 0.8, 4);
gammas =  linspace(0.2, 1, 4);

for i = 1:length(alphas)
    for j = 1:length(gammas)
        img_temp = huber_res(alphas(i), gammas(j));
        ind = 4 * (i - 1) + j;
        subplot(4, 4, ind);
        imagesc(img_temp); caxis([-0.3, 1.3]);
        title("alpha =" + num2str(alphas(i)) + " gamma =" + num2str(gammas(j)));
       
    end
end
sgtitle("Round3 Huber prior");


