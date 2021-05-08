clear
clc;

img = imread('multi_illumination_test_mip2_jpg/everett_kitchen5/dir_0_mip2.jpg');
img = double(img);
patchsize = 10;
imgr = img(:,:,1);

totalpatches = size(imgr,1)*size(imgr,2)/(100*patchsize*patchsize);
vars = zeros(1,totalpatches);
intensities = zeros(1,totalpatches);

k=1;

for i=0:10:size(imgr,1)/patchsize-1
    for j=0:10:size(imgr,2)/patchsize-1
        patch = imgr(patchsize*i+1: patchsize*(i+1), patchsize*j+1: patchsize*(j+1));
        Imean = sum(sum(patch))/(patchsize*patchsize);
        var = sum(sum((patch - Imean).^2))/(patchsize*patchsize-1);
        
        vars(k) = var;
        intensities(k) = Imean;
       
        k=k+1; 
    end
end

figure();
scatter(intensities,vars,25,'filled');
ylim([0,100]);