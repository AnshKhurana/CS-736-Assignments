function lab = initLabelGuess(img, mask)

imgmin = min(img(:));
img = img - imgmin;
imgmax = max(img(:));

lab = zeros(size(img));

lab(mask == 1) = 1;
lab(and(img <= 2/3*imgmax, mask == 1)) = 2;
lab(and(img <= imgmax/3, mask == 1)) = 3;