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
I = myIntegration(img, 0, 0, 1);
disp(I);

dt = 5;
dth = 5; 
ds = 1;

t_range = -90:dt:90;
theta_range =  0:dth:175;

Rf = myRadonTrans(img, t_range, theta_range, ds);

disp(Rf);


% Part b. 