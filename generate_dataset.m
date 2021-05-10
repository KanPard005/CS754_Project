A = [115 194 98 87 133 214 80 193 94 157 56 70 175 231 187 243 200 160 122 85;
     82 150 122 108 128 126 91 90 60 188 61 148 54 199 86 243 200 160 122 85;
     68 130 157 67 177 44 166 99 108 64 150 73 60 31 149 242 200 160 121 85];
patchsize = 40;
img = zeros(4 * patchsize, 5 * patchsize, 3);

for i = 0:3
    for j = 0:4
        A(:, j + 5*i + 1)
        img(patchsize*i+1: patchsize*(i+1), patchsize*j+1:patchsize*(j+1), :) = repmat(reshape(A(:, j + 5*i + 1), 1, 1, 3), patchsize, patchsize);
    end
end

scale = 1/50;
if ~exist('datasetnew', 'dir')
    mkdir('datasetnew');
end
noisy_img = ((1 - scale) * img + poissrnd(scale * img)) / 255;
imwrite(noisy_img, sprintf('trial1.png', i));
% num = 200;
% for i = 1:num
%     noisy_img = ((1 - scale) * img + poissrnd(scale * img)) / 255;
%     imwrite(noisy_img, sprintf('datasetnew/%d.png', i));
% end
