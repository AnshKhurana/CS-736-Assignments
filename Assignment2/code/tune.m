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

quad_res = @ (x, y) gradDesc(img, img, 'quadPrior', x, y);
huber_res = @ (x, y) gradDesc(img, img, 'huberPrior', x, y);
ada_res = @ (x, y) gradDesc(img, img, 'adaPrior', x, y);


% % Round1
% 
% alphas = [0, 0.1, 0.2, 0.4, 0.8, 1];
% lambdas = [0, 0.1, 0.2, 0.4, 0.8, 1];
% [X, Y] = meshgrid(alphas, lambdas);
% 
% 
% Z1 = zeros(length(alphas), length(lambdas));
% Z2 = Z1;
% Z3 = Z2;
% 
% for i = 1:length(alphas)
%     for j = 1:length(lambdas)
%         [q, a] = quad_res(alphas(i), lambdas(j));
%         [hu, a] = huber_res(alphas(i), lambdas(j));
%         [ada, a] = ada_res(alphas(i), lambdas(j));
%         
%         Z1(i, j) = norm(iorg-q, 'fro')/norm(iorg, 'fro'); 
%         Z2(i, j) = norm(iorg-hu, 'fro')/norm(iorg, 'fro'); 
%         Z3(i, j) = norm(iorg-ada, 'fro')/norm(iorg, 'fro'); 
%     end
% end
% 
% surf(X,Y,Z1);
% figure;
% surf(X,Y,Z2);
% figure;
% surf(X,Y,Z3);
% figure;
% 
% Round2
% 
% alphas = [0.1, 0.15, 0.2, 0.25, 0.3, 0.35];
% lambdas = [0, 0.1, 0.2, 0.4, 0.8, 1];
% 
% Z11 = zeros(length(alphas), length(lambdas));
% 
% [X, Y] = meshgrid(alphas, lambdas);
% 
% for i = 1:length(alphas)
%     for j = 1:length(lambdas)
%         [q, a] = quad_res(alphas(i), lambdas(j)); 
%         Z11(i, j) = norm(iorg-q, 'fro')/norm(iorg, 'fro'); 
%        
%     end
% end
% 
% 
% surf(X,Y,Z11);
% figure;
% 
% alphas = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6];
% lambdas = [0, 0.05, 0.1, 0.15, 0.2,0.25];
% [X, Y] = meshgrid(alphas, lambdas);
% Z22 = zeros(length(alphas), length(lambdas));
% 
% 
% for i = 1:length(alphas)
%     for j = 1:length(lambdas)
%         [hu, a] = huber_res(alphas(i), lambdas(j)); 
%         Z22(i, j) = norm(iorg-hu, 'fro')/norm(iorg, 'fro'); 
%        
%     end
% end
% 
% 
% surf(X,Y,Z22);
% figure;
% 
% alphas = [0.6, 0.7, 0.8, 0.9];
% lambdas = [0.03, 0.06, 0.1, 1.03];
% [X, Y] = meshgrid(alphas, lambdas);
% 
% Z33 = zeros(length(alphas), length(lambdas));
% for i = 1:length(alphas)
%     for j = 1:length(lambdas)
%         [ada, a] = ada_res(alphas(i), lambdas(j)); 
%         Z33(i, j) = norm(iorg-ada, 'fro')/norm(iorg, 'fro'); 
%        
%     end
% end
% 
% surf(X,Y,Z33);
% 

% Round 3


alphas = linspace(0.25, 0.35, 10);
lambdas = linspace(0,1, 10);

Z11 = zeros(length(alphas), length(lambdas));

[X, Y] = meshgrid(alphas, lambdas);

for i = 1:length(alphas)
    for j = 1:length(lambdas)
        [q, a] = quad_res(alphas(i), lambdas(j)); 
        Z11(i, j) = norm(iorg-q, 'fro')/norm(iorg, 'fro'); 
       
    end
end


surf(X,Y,Z11);
figure;

alphas = linspace(0.4, 0.6, 10);
lambdas = linspace(0.05, 0.15, 10);
[X, Y] = meshgrid(alphas, lambdas);
Z22 = zeros(length(alphas), length(lambdas));


for i = 1:length(alphas)
    for j = 1:length(lambdas)
        [hu, a] = huber_res(alphas(i), lambdas(j)); 
        Z22(i, j) = norm(iorg-hu, 'fro')/norm(iorg, 'fro'); 
       
    end
end


surf(X,Y,Z22);
figure;

alphas = linspace(0.7, 0.9, 10);
lambdas = linspace(0.0, 0.6, 10);
[X, Y] = meshgrid(alphas, lambdas);

Z33 = zeros(length(alphas), length(lambdas));
for i = 1:length(alphas)
    for j = 1:length(lambdas)
        [ada, a] = ada_res(alphas(i), lambdas(j)); 
        Z33(i, j) = norm(iorg-ada, 'fro')/norm(iorg, 'fro'); 
       
    end
end

surf(X,Y,Z33);

