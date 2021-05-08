clear;
clc;

img = imread('multi_illumination_test_mip2_jpg/everett_kitchen5/dir_0_mip2.jpg');

figure();
subplot(1,3,1)
imshow(img);
img = double(img);

imgr = img(:,:,1);
subplot(1,3,2)
histogram(imgr,40);

[h,w] = size(imgr);
added = [imgr zeros(h, 1)];
added = [added; zeros(1, w + 1)];

shifted = [zeros(h, 1) imgr];
shifted = [zeros(1, w + 1); shifted];

diff = added - shifted;
diff = diff(2:h, 2:w);

subplot(1,3,3)
histogram(diff)
xlim([-10,10]);