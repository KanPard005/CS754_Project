clear;
clc;

img = imread('Sample.jpg');
% img = imread('multi_illumination_test_mip2_jpg/everett_dining1/dir_0_mip2.jpg');
% patchsize = 16;
patchsize = 60;
size(img)
figure();
imshow(img);
img = double(img);

color = ["red" "green" "blue"];
edge_img = zeros(size(img, 1) - 1, size(img, 2) - 1);
for i=1:3
    Es = plot_channels(img(:,:,i), patchsize);
    edge_img = edge_img + Es;
end

figure();
imshow(edge_img);