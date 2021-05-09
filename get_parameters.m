function [mu_1, mu_2] = get_parameters(patch, h, w)
added = [patch zeros(h, 1)];
added = [added; zeros(1, w + 1)];

shifted = [zeros(h, 1) patch];
shifted = [zeros(1, w + 1); shifted];

diff = shifted - added;
diff = diff(2:h, 2:w);

mu_s = mean(mean(diff));
var_s = var(diff(:), 1);

mu_1 = (mu_s + var_s) / 2;
mu_2 = (var_s - mu_s) / 2;
end