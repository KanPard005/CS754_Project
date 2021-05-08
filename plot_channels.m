function Es = plot_channels(channel, string, patchsize)
    skellam = [];
    means = [];
    difference = [];
    alpha = 0.05;
    Es = zeros(size(channel, 1) - 1, size(channel, 2) - 1);
    Ones = zeros(size(channel, 1) - 1, size(channel, 2) - 1);
    for k=0:2*size(channel, 1)/patchsize-1
        for l=0:2*size(channel, 2)/patchsize-1
            i = patchsize / 2 * k;
            j = patchsize / 2 * l;
    % for i=0:size(channel, 1)-patchsize 
    %     for j=0:size(channel, 2)-patchsize
            patch = channel(i+1: min(size(channel, 1), i+patchsize), j+1: min(size(channel, 2), patchsize+j));
            [mu_1, mu_2] = get_param(patch, size(patch, 1), size(patch, 2));
            % I_A = get_acceptance(mu_1, mu_2, alpha);
            % I_A
            I_A = 5;
            difference = [difference mu_1-mu_2];
            if abs(mu_1-mu_2) <= 0.4 && rand < 0.05
                skellam = [skellam mu_1];
                means = [means mean(mean(patch))];
            end
            % patch = channel(i+1: min(size(channel, 1), i+patchsize+1), j+1: min(size(channel, 2), patchsize+j+1));
            [ex, ey] = get_e(patch, I_A);
            Es(i+1: min(size(Es, 1), i+patchsize-1), j+1: min(size(Es, 2), patchsize+j-1)) = ex + ey;
            Ones(i+1: min(size(Ones, 1), i+patchsize-1), j+1: min(size(Ones, 2), patchsize+j-1)) = ones(size(ex));
        end
        if rem(i, 100) == 0
            fprintf("%d done\n", i);
        end
    end
    Es = Es ./ Ones;

    % figure();
    % histogram(difference);
    % title(string);

    % figure();
    % size(skellam)
    % scatter(means, skellam);
    % title(string);
end
