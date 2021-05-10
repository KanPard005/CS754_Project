clear
clc;

img = imread('dataset/1.png');

patchsize = 10;


figure();
subplot(2,3,1);
imshow(img);

size(img)
img = double(img);
imgr = img(1:size(img, 1),1:size(img, 2),1);

totalpatches = size(imgr,1)*size(imgr,2) / (patchsize*patchsize);
vars = zeros(1,totalpatches);
intensities = zeros(1,totalpatches);
mu1s = zeros(1,totalpatches);
mu2s = zeros(1,totalpatches);

k=1;

for i=0:size(imgr,1)/patchsize-1
    for j=0:size(imgr,2)/patchsize-1
        patch = imgr(patchsize*i+1: patchsize*(i+1), patchsize*j+1: patchsize*(j+1));
        Imean = sum(sum(patch))/(patchsize*patchsize);
        var = sum(sum((patch - Imean).^2))/(patchsize*patchsize-1);
        
        vars(k) = var;
        intensities(k) = Imean;
        [mu1s(k), mu2s(k)] = get_parameters(patch,patchsize,patchsize);
       
        k=k+1; 
    end
end

subplot(2,3,2);
scatter(intensities,vars,25,'filled');
% ylim([0,100]);

subplot(2,3,3)
scatter(intensities,mu1s,25,'filled');
% ylim([0,50]);



%%temporal 
% n = 100;
% tempimgs = zeros(size(imgr,1),size(imgr,2),n);
% for i=2:n
%     temp = imread(strcat('../KanadSibasis_ColorChecker/',int2str(i),'.jpg'));
%     tempimgs(:,:,i+1) = temp(1:2100,1:4600,1);
% end
% 
% x = 10;
% y = 10;
% temp_int = zeros(n,1);
% for i=1:n
%     temp_int(i) = tempimgs(x,y,i); 
% end
% 
% [temp_int, sortIdx] = sort(temp_int, 'descend');
% tempimgs = tempimgs(:,:,sortIdx);
% 
% subplot(2,3,4)
% scatter([1:n],temp_int,25,'filled');
% 
% temp_vars= zeros(size(tempimgs,1),size(tempimgs,2));
% temp_meanint = zeros(size(tempimgs,1),size(tempimgs,2));
% temp_mu1s = zeros(size(tempimgs,1),size(tempimgs,2));
% temp_mu2s = zeros(size(tempimgs,1),size(tempimgs,2));
% 
% for i=1:size(tempimgs,1)
%     for j=1:size(tempimgs,2)
%         vec = zeros(1,n);
%         vec = reshape(tempimgs(i,j,:),[1,n]);
%         temp_meanint(i,j) = mean(vec);
%         temp_vars(i,j) = sum((vec-temp_meanint(i,j)).^2)/n-1;
%         [temp_mu1s(i,j),temp_mu2s(i,j)] = get_temporal_param(vec);
%     end
% end
% 
% subplot(2,3,5)
% scatter(temp_meanint(:),temp_vars(:),25,'filled');
% 
% subplot(2,3,6)
% scatter(temp_meanint(:),temp_mu1s(:),25,'filled');
% 
% 
% 
% 


