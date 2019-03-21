function DJK_matrix  = djk(y, w, mask, mean, bias)
bias = bias .* mask;
DJK_matrix(mask == 1) =  conv((y - bias*mean).^2, w);
