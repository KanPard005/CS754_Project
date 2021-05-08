function I_A = get_acceptance(mu_1, mu_2, alpha)
    i = 0;
    frac = 0.0;
    e = exp(-(mu_1 + mu_2));
    while frac < 1 - alpha
        i = i+1;
        term2 = (mu_1 / mu_2) ^ (i / 2);
        term3 = besseli(i, 2 * sqrt(mu_1 * mu_2));
        term = e * term2 * term3;
        frac = frac + term;

        term2 = (mu_1 / mu_2) ^ ((-i+1) / 2);
        term3 = besseli(i-1, 2 * sqrt(mu_1 * mu_2));
        term = e * term2 * term3;
        frac = frac + term;
    end
    I_A = i-1;
end