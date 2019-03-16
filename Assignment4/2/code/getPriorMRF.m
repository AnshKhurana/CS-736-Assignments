function prior = getPriorMRF(lab, comp, i, j, mask, beta)

disp = 0;
if mask(i-1, j) == 1
    disp = disp + (lab(i-1, j) ~= comp);
end
if mask(i+1, j) == 1
    disp = disp + (lab(i+1, j) ~= comp);
end
if mask(i, j-1) == 1
    disp = disp + (lab(i, j-1) ~= comp);
end
if mask(i, j+1) == 1
    disp = disp + (lab(i, j+1) ~= comp);
end

prior = exp (-beta * disp);
