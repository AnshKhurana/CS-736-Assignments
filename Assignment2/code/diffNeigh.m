function [ Xr, Xl, Xb, Xt ] = diffNeigh( image)
    Xt = (image - circshift(image, +1, 1));
    Xb = (image - circshift(image, -1, 1));
    Xr = (image - circshift(image, +1, 2));
    Xl = (image - circshift(image, -1, 2));
