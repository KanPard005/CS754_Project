clear;
clc;

img = imread('trial1.png');
patchsize = 80;
alpha = 0.002;
size(img)
figure();
imshow(img);
img = double(img);

edge_img = zeros(size(img, 1) - 1, size(img, 2) - 1);
for i=1:3
    Es = plot_channels(img(:,:,i), patchsize, alpha);
    edge_img = edge_img + Es;
end

figure();
imshow(edge_img);