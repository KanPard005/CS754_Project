function get_plots(patch)
    patch = double(patch);
    shift = [zeros(size(patch, 1), 1) patch];
    shift = [zeros(1, size(shift, 2)); shift];
    diff = shift(2:size(shift, 1)-1, 2:size(shift, 2)-1) - patch(2:size(patch, 1), 2:size(patch, 2));
    mu_s = mean(diff(:));
    var_s = var(diff(:), 1);
    mu_1 = (mu_s + var_s) / 2;
    mu_2 = (- mu_s + var_s) / 2;
    figure();
    x = [-7:1:7];
    skellam = exp(-(mu_1 + mu_2)) * power((mu_1 / mu_2), x/2) .* besseli(abs(x), 2 * sqrt(mu_1 * mu_2));
    hold on;
    histogram(diff(:));
    plot(x, skellam * size(diff, 1) * size(diff, 2));
    plot(x, normpdf(x) * size(diff, 1) * size(diff, 2));
    legend('Histrogram', 'Skellam distr.', 'Gaussian distr.');
    xlabel('Intensity difference');
    ylabel('Frequency');
end