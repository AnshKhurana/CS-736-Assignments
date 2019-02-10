%% Question 1 

load('../data/assignmentImageDenoisingPhantom.mat');
img = real(imageNoisy); iorg = imageNoiseless;

quad_res = @ (x, y) gradDesc(img, img, 'quadPrior', x, y);
huber_res = @ (x, y) gradDesc(img, img, 'huberPrior', x, y);
ada_res = @ (x, y) gradDesc(img, img, 'adaPrior', x, y);


% % Round1
% 
% alphas = [0, 0.1, 0.2, 0.4, 0.8, 1];
% gammas = [0, 0.1, 0.2, 0.4, 0.8, 1];
% [X, Y] = meshgrid(alphas, gammas);
% 
% 
% Z1 = zeros(length(alphas), length(gammas));
% Z2 = Z1;
% Z3 = Z2;
% 
% for i = 1:alphas(alphas)
%     for j = 1:alphas(gammas)
%         [q, a] = quad_res(alphas(i), gammas(j));
%         [hu, a] = huber_res(alphas(i), gammas(j));
%         [ada, a] = ada_res(alphas(i), gammas(j));
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
% gammas = [0, 0.1, 0.2, 0.4, 0.8, 1];
% 
% Z11 = zeros(length(alphas), length(gammas));
% 
% [X, Y] = meshgrid(alphas, gammas);
% 
% for i = 1:length(alphas)
%     for j = 1:length(gammas)
%         [q, a] = quad_res(alphas(i), gammas(j)); 
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
% gammas = [0, 0.05, 0.1, 0.15, 0.2,0.25];
% [X, Y] = meshgrid(alphas, gammas);
% Z22 = zeros(length(alphas), length(gammas));
% 
% 
% for i = 1:length(alphas)
%     for j = 1:length(gammas)
%         [hu, a] = huber_res(alphas(i), gammas(j)); 
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
% gammas = [0.03, 0.06, 0.1, 1.03];
% [X, Y] = meshgrid(alphas, gammas);
% 
% Z33 = zeros(length(alphas), length(gammas));
% for i = 1:length(alphas)
%     for j = 1:length(gammas)
%         [ada, a] = ada_res(alphas(i), gammas(j)); 
%         Z33(i, j) = norm(iorg-ada, 'fro')/norm(iorg, 'fro'); 
%        
%     end
% end
% 
% surf(X,Y,Z33);
% 

% Round 3


alphas = linspace(0.25, 0.35, 10);
gammas = linspace(0,1, 10);

Z111 = zeros(length(alphas), length(gammas));

[X, Y] = meshgrid(alphas, gammas);

for i = 1:length(alphas)
    for j = 1:length(gammas)
        [q, a] = quad_res(alphas(i), gammas(j)); 
        Z111(i, j) = norm(iorg-q, 'fro')/norm(iorg, 'fro'); 
       
    end
end


surf(X,Y,Z111);
figure;

alphas = linspace(0.4, 0.6, 10);
gammas = linspace(0.05, 0.15, 10);
[X, Y] = meshgrid(alphas, gammas);
Z222 = zeros(length(alphas), length(gammas));


for i = 1:length(alphas)
    for j = 1:length(gammas)
        [hu, a] = huber_res(alphas(i), gammas(j)); 
        Z222(i, j) = norm(iorg-hu, 'fro')/norm(iorg, 'fro'); 
       
    end
end


surf(X,Y,Z222);
figure;

alphas = linspace(0.7, 0.9, 10);
gammas = linspace(0.0, 0.6, 10);
[X, Y] = meshgrid(alphas, gammas);

Z333 = zeros(length(alphas), length(gammas));
for i = 1:length(alphas)
    for j = 1:length(gammas)
        [ada, a] = ada_res(alphas(i), gammas(j)); 
        Z333(i, j) = norm(iorg-ada, 'fro')/norm(iorg, 'fro'); 
       
    end
end

surf(X,Y,Z333);

