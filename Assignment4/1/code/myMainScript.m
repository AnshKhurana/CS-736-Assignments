%% Assignment 4, Image Segmentaion
%  CS736: Medical Image Computing, IIT Bombay (Spring 2019)
%  Dhruv Shah and Ansh Khurana
%
% 

warning('off', 'all');
clc; clear all; close all;

%% Question 1
load("../data/assignmentSegmentBrain.mat");
% imshow(imageData);
figure;
% imshow(imageMask);
% Constants
K = 3; 
% Tunable parameters - 
q = 4;
weight_sigma = 0.5;
w = fspecial('gaussian', 3,  weight_sigma);
y = cropImage(imageData, imageMask);

[means, bias, memberships, cost_log, bias_removed, residual_image] = FCM(imageData, q, K, imageMask, w);



