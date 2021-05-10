clear
clc;

=======
img = imread('datasetnew/1.png');
>>>>>>> b64d5735f877768fc4ea363fe0aeb7567561031b

patchsize = 10;

figure();
imshow(img);
title('Input image');

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
        intensities(k) = Imean;
        [mu1s(k), mu2s(k)] = get_parameters(patch,patchsize,patchsize);
       
        k=k+1; 
    end
end

[intensities, sortId] = sort(intensities, 'descend');
mu1s = mu1s(sortId);
mu2s = mu2s(sortId);

plotmu1s = [];
plotint = [];
plotmu2s = [];

x = 1000;
for i=1:size(intensities,2)
    if intensities(i) < x-2.5
        plotmu1s = [plotmu1s, mu1s(i)];
        plotmu2s = [plotmu2s, mu2s(i)];
        plotint = [plotint, intensities(i)];
        x = intensities(i);
    end
end

figure()
subplot(2,2,1)
p1 = scatter(plotint,plotmu1s,25,'filled');
hold on;
h1 = lsline;
h1.Color = 'r';
xlabel('r intensity')
ylabel('Skellam parameter(\mu^{(1)})');
title('Intensity vs skellam parameter in spatial domain')


subplot(2,2,2)
scatter(plotint,plotmu2s,25,'filled');
h2 = lsline;
h2.Color = 'r';
xlabel('r intensity')
ylabel('Skellam parameter(\mu^{(2)})');
title('Intensity vs skellam parameter in spatial domain')


%temporal 
n = 100;
tempimgs = zeros(size(imgr,1),size(imgr,2),n);
for i=1:n
    temp = imread(strcat('datasetnew/',int2str(i),'.png'));
    tempimgs(:,:,i+1) = temp(:,:,1);
end

x = 10;
y = 10;
temp_int = zeros(n,1);

for i=1:n
    temp_int(i) = tempimgs(x,y,i); 
end

[temp_int, sortIdx] = sort(temp_int, 'descend');
tempimgs = tempimgs(:,:,sortIdx);

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
%         temp_vars(i,j) = sum((vec-temp_meanint(i,j)).^2)/n-1;
        [temp_mu1s(i,j),temp_mu2s(i,j)] = get_temporal_param(vec);
    end
end


subplot(2,2,3)
scatter(temp_meanint(:),temp_mu1s(:),25,'filled');
hold on;
h3 = lsline;
h3.Color = 'r';
xlabel('r intensity')
ylabel('Skellam parameter(\mu^{(1)})');
title('Intensity vs skellam parameter in temporal domain')

subplot(2,2,4)
scatter(temp_meanint(:),temp_mu2s(:),25,'filled');
hold on;
h3 = lsline;
h3.Color = 'r';
xlabel('r intensity')
ylabel('Skellam parameter(\mu^{(2)})');
title('Intensity vs skellam parameter in temporal domain')

