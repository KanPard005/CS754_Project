A = 20 + 10 * randi([2 20], 3, 20);
A = A + repmat([-20 20], 3, 10);
patchsize = 200;
img = zeros(4 * patchsize, 5 * patchsize, 3);

for i = 0:3
    for j = 0:4
        A(:, j + 5*i + 1)
        img(patchsize*i+1: patchsize*(i+1), patchsize*j+1:patchsize*(j+1), :) = repmat(reshape(A(:, j + 5*i + 1), 1, 1, 3), patchsize, patchsize);
    end
end

scale = 1/50;
if ~exist('dataset', 'dir')
    mkdir('dataset');
end
num = 1000;
% for i = 1:num
%     noisy_img = ((1 - scale) * img + poissrnd(scale * img)) / 255;
%     imwrite(noisy_img, sprintf('dataset/%d.png', i));
% end
noisy_img = ((1 - scale) * img + poissrnd(scale * img)) / 255;
imshow(noisy_img);
imwrite(noisy_img, 'trial.png');
