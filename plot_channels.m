function Es = plot_channels(channel, string, patchsize)
    skellam = [];
    means = [];
    difference = [];
    alpha = 0.05;
    Es = zeros(size(channel, 1) - 1, size(channel, 2) - 1);
    for i=0:size(channel, 1)/patchsize-1
        for j=0:size(channel, 2)/patchsize-1
            patch = channel(patchsize*i+1: patchsize*(i+1), patchsize*j+1: patchsize*(j+1));
            [mu_1, mu_2] = get_param(patch, patchsize, patchsize);
            I_A = get_acceptance(mu_1, mu_2, alpha);
            difference = [difference mu_1-mu_2];
            if abs(mu_1-mu_2) <= 0.4 && rand < 0.05
                skellam = [skellam mu_1];
                means = [means mean(mean(patch))];
            end
            patch = channel(patchsize*i+1: min(size(channel, 1), patchsize*(i+1)+1), patchsize*j+1: min(size(channel, 2), patchsize*(j+1)+1));
            [ex, ey] = get_e(patch, I_A);
            Es(patchsize*i+1: min(size(Es, 1), patchsize*(i+1)), patchsize*j+1: min(size(Es, 2), patchsize*(j+1))) = ex + ey;
        end
    end

    figure();
    histogram(difference);
    title(string);

    figure();
    size(skellam)
    scatter(means, skellam);
    title(string);
end
