function [val, grad] = quadPrior(image)


[Xr, Xl, Xb, Xt] = diffNeigh(image);
modXr = abs(Xr);
modXl = abs(Xl);
modXb = abs(Xb);
modXt= abs(Xt);

val = square(modXr) + square(modXl) + square(modXt) + square(modXb);
grad = 2 * modXr .* sign(Xr) + 2 * modXl .* sign(Xl) + 2 * modXt .* sign(Xt) + 2 * modXb.* sign(Xb);
