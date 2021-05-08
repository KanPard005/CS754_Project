clear
clc;

img = imread('multi_illumination_test_mip2_jpg/everett_kitchen5/dir_0_mip2.jpg');

patchsize = 10;


figure();
subplot(2,3,1);
imshow(img);

img = double(img);
imgr = img(:,:,1);

totalpatches = size(imgr,1)*size(imgr,2)/(100*patchsize*patchsize);
vars = zeros(1,totalpatches);
intensities = zeros(1,totalpatches);
mu1s = zeros(1,totalpatches);
mu2s = zeros(1,totalpatches);

k=1;

for i=0:10:size(imgr,1)/patchsize-1
    for j=0:10:size(imgr,2)/patchsize-1
        patch = imgr(patchsize*i+1: patchsize*(i+1), patchsize*j+1: patchsize*(j+1));
        Imean = sum(sum(patch))/(patchsize*patchsize);
        var = sum(sum((patch - Imean).^2))/(patchsize*patchsize-1);
        
        vars(k) = var;
        intensities(k) = Imean;
        [mu1s(k), mu2s(k)] = get_param(patch,patchsize,patchsize);
       
        k=k+1; 
    end
end

subplot(2,3,2);
scatter(intensities,vars,25,'filled');
ylim([0,100]);

subplot(2,3,3)
scatter(intensities,mu1s,25,'filled');
ylim([0,50]);



%%temporal 
n = 25;
tempimgs = zeros(size(imgr,1),size(imgr,2),n);
for i=0:n-1
    temp = imread(strcat('multi_illumination_test_mip2_jpg/everett_kitchen5/dir_',int2str(i),'_mip2.jpg'));
    tempimgs(:,:,i+1) = temp(:,:,1);
end

x = 120;
y = 150;
temp_int = zeros(n,1);
for i=1:n
    temp_int(i) = tempimgs(x,y,i); 
end

subplot(2,3,4)
scatter([1:n],temp_int,25,'filled');

temp_vars= zeros(size(tempimgs,1),size(tempimgs,2));
temp_meanint = zeros(size(tempimgs,1),size(tempimgs,2));
temp_mu1s = zeros(size(tempimgs,1),size(tempimgs,2));
temp_mu2s = zeros(size(tempimgs,1),size(tempimgs,2));

for i=1:size(tempimgs,1)
    for j=1:size(tempimgs,2)
        vec = zeros(1,n);
        vec = reshape(tempimgs(i,j,:),[1,n]);
        temp_meanint(i,j) = mean(vec);
        temp_vars(i,j) = sum((vec-temp_meanint(i,j)).^2)/n-1;
        [temp_mu1s(i,j),temp_mu2s(i,j)] = get_temporal_param(vec);
    end
end

subplot(2,3,5)
scatter(temp_meanint(:),temp_vars(:),25,'filled');

subplot(2,3,6)
scatter(temp_meanint(:),temp_mu1s(:),25,'filled');






