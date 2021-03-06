clear;
clc;

img = imread('datasetnew/1.png');

figure();
subplot(1,3,1)
imshow(img);
img = double(img);
title('Color checker from Shi-gheller dataset')

imgr = img(:,:,1);
subplot(1,3,2)
histogram(imgr,40);
xlabel('r intensity')
ylabel('number of pixels')
title('Intensity distribution in r channel')

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
xlabel('difference of r intensity')
ylabel('number of pixels')
title('Intensity difference distribution in r channel')
