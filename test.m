clear;
clc;

img = imread('multi_illumination_test_mip2_jpg/everett_kitchen5/dir_0_mip2.jpg');
% img = imread('multi_illumination_test_mip2_jpg/everett_dining1/dir_0_mip2.jpg');
% patchsize = 16;
patchsize = 10;
size(img)
figure();
imshow(img);
img = double(img);

color = ["red" "green" "blue"];
edge_img = zeros(size(img, 1) - 1, size(img, 2) - 1);
for i=1:3
    Es = plot_channels(img(:,:,i), color(i), patchsize);
    edge_img = edge_img + Es;
end

figure();
imshow(edge_img);
% e = exp(-(mu_1 + mu_2));
% for i=1:size(val, 2)
%     term2 = (mu_1 / mu_2) ^ (val(i) / 2);
%     % term2 = 1;
%     term3 = besseli(val(i), 2 * sqrt(mu_1 * mu_2));
%     val(i) = e * term2 * term3;
% end

% figure(2);
% hold on;
% histogram(diff(:));
% val = val * (h - 1) * (w - 1);
% plot(xax, val);