clear;
clc;

img = double(imread('trial1.png'));
patchsize = 200;
patch = img(1:200, 1:200, 3);

get_plots(img(1:patchsize, 1:patchsize, 1));

frac = 0.0;
thresh = [0.5 0.75 0.8 0.9 0.95 0.99 0.995 0.999];
idx = 1;
i = 0;

[mu_1, mu_2] = get_parameters(patch(:,:,1), size(patch, 1), size(patch, 2));

fprintf("Value of alpha \t | \t I_A\n");

e = exp(-(mu_1 + mu_2));
while idx <= size(thresh, 2)
    i = i+1;
    term2 = (mu_1 / mu_2) ^ (i / 2);
    term3 = besseli(i, 2 * sqrt(mu_1 * mu_2));
    term = e * term2 * term3;
    frac = frac + term;

    term2 = (mu_1 / mu_2) ^ ((-i+1) / 2);
    term3 = besseli(i-1, 2 * sqrt(mu_1 * mu_2));
    term = e * term2 * term3;
    frac = frac + term;
    
    if frac >= thresh(idx)
        fprintf("%f \t | \t %d\n", thresh(idx), i);
        idx = idx + 1;
    end
end