clear;
clc;

% Values for trial1.png
% img = imread('note.png');
% patchsize = 150;
% alpha = 0.001;

% Values for note.png
img = imread('note.png');
patchsize = 20;
alpha = 1e-12;

size(img)
figure();
imshow(img);
title("Original image");
img = double(img);

edge_img = zeros(size(img, 1) - 1, size(img, 2) - 1);
for i=1:3
    Es = plot_channels(img(:,:,i), patchsize, alpha);
    edge_img = edge_img + Es;
end

figure();
imshow(edge_img);
title("Detected Edges");