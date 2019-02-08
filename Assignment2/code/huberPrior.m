function [val, grad] = huberPrior(image, gamma)

[Xr, Xl, Xb, Xt] = diffNeigh(image);



