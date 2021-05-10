%I is the intensity vector consisting of list of intensities at a certain
%pixel
function [mu_1, mu_2] = get_temporal_param(I)
    n = size(I,2);
    added = [I 0];
    shifted = [0 I];
    diff = added-shifted;
    diff = diff(2:n);

    mu_s = mean(diff);
    var_s = var(diff);
    
    mu_1 = (mu_s + var_s)/2;
    mu_2 = (var_s - mu_s)/2;
end