clear;
clc;
n=200;
img1 = imread('datasetnew/1.png');
allimgs = zeros(size(img1,1),size(img1,2),3,n);

for i=1:n
    load = imread(sprintf('datasetnew/%d.png', i));
    double(load);
    allimgs(:,:,:,i) = load;
end

meanimgs = mean(allimgs,4);
mu1imgs = zeros(size(img1));
mu2imgs = zeros(size(img1));
acceptance = zeros(size(img1));

alpha = [0.00001];

for al=1:1
    for x=1:size(allimgs,1)
        for y=1:size(allimgs,2)
            for channel=1:3
                intensity_vec = reshape(allimgs(x,y,channel,:),[1,n]);
                [mu1imgs(x,y,channel), mu2imgs(x,y,channel)] = get_temporal_param(intensity_vec);
                acceptance(x,y,channel) = get_acceptance(mu1imgs(x,y,channel), mu2imgs(x,y,channel),alpha(al));
            end
        end 
    end
    
    figure()
    subplot(1,2,1);
    testimg = imread('bkg.png');
    imshow(testimg);
    title('Input Image')
    detected = ((meanimgs-acceptance) > testimg) | (testimg > (meanimgs+acceptance));
    subplot(1,2,2);
    imshow(detected(:,:,1)+detected(:,:,2)+detected(:,:,3));
    title('Detected background');
end



