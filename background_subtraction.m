clc;
clear;
n=71;
img1 = imread('birds/frame_1.jpg');
allimgs = zeros(size(img1,1),size(img1,2),n);

for i=1:n
    load = imread(sprintf('birds/frame_%d.jpg', i));
    double(load);
    allimgs(:,:,i) = load;
end

meanimgs = zeros(size(img1));
mu1imgs = zeros(size(img1));
mu2imgs = zeros(size(img1));
acceptance = zeros(size(img1));

alpha = 0.0001;
dev = [40 50 60 70 80];

for al=1:5
    for x=1:size(allimgs,1)
        for y=1:size(allimgs,2)
            for channel=1:1  
                totalvec = reshape(allimgs(x,y,:),[1,n]);
                m = mode(totalvec);
                intensity_vec = totalvec((totalvec<(m+dev(al))) & (totalvec>(m-dev(al))));
                [mu1imgs(x,y), mu2imgs(x,y)] = get_temporal_param(intensity_vec);
                acceptance(x,y) = get_acceptance(mu1imgs(x,y), mu2imgs(x,y),alpha);
                meanimgs(x,y) = mean(intensity_vec);
            end
        end 
    end
    
    figure()
    subplot(1,2,1)
    testimg = imread('birds/frame_1.jpg');
    imshow(testimg);
    detected = ((meanimgs-acceptance) > testimg) | (testimg > (meanimgs+acceptance));
    subplot(1,2,2)
    imshow(detected);
    title('%i',al);
    al
%     (sum(sum((detected-GT(:,:,1)).^2)))/(size(detected,1)*size(detected,2)-1)
    
end



