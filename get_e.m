function [ex, ey] = get_e(patch, I_A)
    actual = patch(1:size(patch, 1)-1, 1:size(patch, 2)-1);
    right = patch(1:size(patch, 1)-1, 2:size(patch, 2));
    down = patch(2:size(patch, 1), 1:size(patch, 2)-1);
    
    ex = max(0, abs(actual - right) - I_A) / I_A;
    ey = max(0, abs(actual - down) - I_A) / I_A;
end

