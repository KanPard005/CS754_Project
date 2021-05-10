img = double(imread('trial1.png'));
patchsize = 20;
[H, W, C] = size(img);

skellam = [];
for i = 1: patchsize: H
    for j = 1: patchsize: W
        iend = min(i + patchsize, H);
        jend = min(i + patchsize, W);
        patch = img(i: iend, j: jend, :);
        values = zeros(3, 1);
        for k = 1:C
            [mu_1 mu_2] = get_parameters(patch(:, :, k), size(patch, 1), size(patch, 2));
            values(k, 1) = mu_1 - mu_2;
        end
        skellam = [skellam values];
    end
end

figure();
hold on;
for i = 1:C
    [n, x] = hist(skellam(i, :), 40);
    plot(x, n);
end
legend('R channel', 'G channel', 'B channel');
xlabel('\mu_1 - \mu_2');
ylabel('Number of patches');