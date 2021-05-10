function Es = plot_channels(channel, patchsize, alpha)
    skellam = [];
    means = [];
    difference = [];
    Es = zeros(size(channel, 1) - 1, size(channel, 2) - 1);
    Ones = zeros(size(channel, 1) - 1, size(channel, 2) - 1);
    for k=0:2*size(channel, 1)/patchsize-1
        for l=0:2*size(channel, 2)/patchsize-1
            i = patchsize / 2 * k;
            j = patchsize / 2 * l;
            patch = channel(i+1: min(size(channel, 1), i+patchsize), j+1: min(size(channel, 2), patchsize+j));
            [mu_1, mu_2] = get_parameters(patch, size(patch, 1), size(patch, 2));
            I_A = 10;
%             I_A = get_acceptance(mu_1, mu_2, alpha);
            [ex, ey] = get_e(patch, I_A);
            Es(i+1: min(size(Es, 1), i+patchsize-1), j+1: min(size(Es, 2), patchsize+j-1)) = ex + ey;
            Ones(i+1: min(size(Ones, 1), i+patchsize-1), j+1: min(size(Ones, 2), patchsize+j-1)) = ones(size(ex));
        end
        if rem(i, 100) == 0
            fprintf("%d done\n", i);
        end
    end
    Es = Es ./ Ones;

end
