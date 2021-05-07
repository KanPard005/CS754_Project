function [mu_1, mu_2] = get_param(patch, h, w)
added = [patch zeros(h, 1)];
added = [added; zeros(1, w + 1)];

shifted = [zeros(h, 1) patch];
shifted = [zeros(1, w + 1); shifted];

diff = added - shifted;
diff = diff(2:h, 2:w);

mu_s = mean(mean(diff));
varmat = (diff - mu_s) .^ 2;
var_s = sum(sum(varmat)) / ((w - 1) * (h - 1) - 1);
% var_s = var(diff, 0, 'all');

mu_1 = (mu_s + var_s) / 2;
mu_2 = (var_s - mu_s) / 2;
end