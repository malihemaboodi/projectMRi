clear all
close all
clc
I=imread('1.jpg');
I=rgb2gray(I);
%% rician noise
J1 = double(I);
[sz1 sz2]=size(J1);
realchannel = normrnd(0,0.5,sz1,sz2) + J1; % 0.5= sathe noise goussian
imaginarychannel = normrnd(0,0.5,sz1,sz2);
J1 = sqrt(realchannel.^2 + imaginarychannel.^2); 
figure
subplot(131)
imshow(uint8(J1))
title('image with rician noise')
%% gaussian
J2= imnoise(I,'gaussian',0.001,0.001);
subplot(132)
imshow(J2)
title('image with goussian noise')
%% salt & pepper
J3 = imnoise(I,'salt & pepper',0.001);
subplot(133)
imshow(J3)
title('image with salt&papper noise')
%% meanfilter
h=fspecial('average',3);
BW1=imfilter(J1,h);
BW1=uint8(BW1);
figure
subplot(131)
imshow(BW1)
title('meanfilter for ricin noise')
BW2=imfilter(J2,h);
subplot(132)
imshow(BW2)
title('meanfilter for goussian noise')
BW3=imfilter(J3,h);
subplot(133)
imshow(BW3)
title('meanfilter for salt&papper noise')
[peaksnr_mean_r, snr_mean_r] = psnr(BW1,I);
RMSE_mean_r = sqrt( sum( (I(:)-BW1(:)).^2) / numel(I) );
[peaksnr_mean_g, snr_mean_g] = psnr(BW2,I);
RMSE_mean_g = sqrt( sum( (I(:)-BW2(:)).^2) / numel(I) );
[peaksnr_mean_s, snr_mean_s] = psnr(BW2,I);
RMSE_mean_s = sqrt( sum( (I(:)-BW3(:)).^2) / numel(I) );
%% median filter
BW1 = medfilt2(J1);
BW1=uint8(BW1);
figure
subplot(131)
imshow(BW1)
title('medianfilter for ricin noise')
BW2 = medfilt2(J2);
subplot(132)
imshow(BW2)
title('medianfilter for goussian noise')
BW3 = medfilt2(J3);
subplot(133)
imshow(BW3)
title('medianfilter for salt&papper noise')
[peaksnr_med_r, snr_med_r] = psnr(BW1,I);
RMSE_med_r = sqrt( sum( (I(:)-BW1(:)).^2) / numel(I) );
[peaksnr_med_g, snr_med_g] = psnr(BW2,I);
RMSE_med_g = sqrt( sum( (I(:)-BW2(:)).^2) / numel(I) );
[peaksnr_med_s, snr_med_s] = psnr(BW3,I);
RMSE_med_s = sqrt( sum( (I(:)-BW3(:)).^2) / numel(I) );
%% midpoint filter
A = im2double(J1);
fun = @(x) min(x(:)); 
B1 = nlfilter(A,[3 3],fun); 
fun = @(x) max(x(:)); 
B2 = nlfilter(A,[3 3],fun);
midpfilt_r=(B1+B2)/2;
midpfilt_r=uint8(midpfilt_r);
figure
subplot(131)
imshow(midpfilt_r)
title('midpoint filter for ricin noise')
A = im2double(J2);
fun = @(x) min(x(:)); 
B3 = nlfilter(A,[3 3],fun); 
fun = @(x) max(x(:)); 
B4 = nlfilter(A,[3 3],fun);
midpfilt_g=(B3+B4)/2;
subplot(132)
imshow(midpfilt_g)
title('midpoint filter for goussian noise')
midpfilt_g=uint8(midpfilt_g);
A = im2double(J3);
fun = @(x) min(x(:)); 
B5 = nlfilter(A,[3 3],fun); 
fun = @(x) max(x(:)); 
B6 = nlfilter(A,[3 3],fun);
midpfilt_s=(B5+B6)/2;
subplot(133)
imshow(midpfilt_s)
title('midpoint filter for salt&papper noise')
midpfilt_s=uint8(midpfilt_s);
[peaksnr_midp_r, snr_midp_r] = psnr(midpfilt_r,I);
RMSE_midp_r = sqrt( sum( (I(:)-midpfilt_r(:)).^2) / numel(I) );
[peaksnr_midp_g, snr_midp_g] = psnr(midpfilt_g,I);
RMSE_midp_g = sqrt( sum( (I(:)-midpfilt_g(:)).^2) / numel(I) );
[peaksnr_midp_s, snr_midp_s] = psnr(midpfilt_s,I);
RMSE_midp_s = sqrt( sum( (I(:)-midpfilt_s(:)).^2) / numel(I) );
%% proposed method for filtering
[a b]=size(I);
for i=1:a
    for j=1:b
        x1=J1(i,j);
        medValue_r(i,j) = median(x1(x1>0));
        x2=J2(i,j);
        medValue_g(i,j) = median(x2(x2>0));
        x3=J3(i,j);
        medValue_s(i,j) = median(x3(x3>0));
    end
end
for i=1:a
    for j=1:b
        x1=medValue_r(i,j);
        meanValue_r(i,j) = mean2(x1);
        image_r=meanValue_r/b;
        x2=medValue_g(i,j);
        meanValue_g(i,j) = mean2(x2);
        image_g=meanValue_g/b;
        x3=medValue_s(i,j);
        meanValue_s(i,j) = mean2(x3);
        image_s=meanValue_s/b;
    end
end
figure
subplot(131)
imshow(image_r)
title('denoised image for rician noise')
image_r=uint8(image_r);
subplot(132)
imshow(image_g)
title('denoised image for goussian noise')
image_g=uint8(image_g);
subplot(133)
imshow(image_s)
title('denoised image for salt&papper noise')
image_s=uint8(image_s);
[peaksnr_prposed_r, snr_prposed_r] = psnr(image_r,I);
RMSE_prposed_r = sqrt( sum( (I(:)-image_r(:)).^2) / numel(I) );
[peaksnr_prposed_g, snr_prposed_g] = psnr(image_g,I);
RMSE_prposed_g= sqrt( sum( (I(:)-image_g(:)).^2) / numel(I) );
[peaksnr_prposed_s, snr_prposed_s] = psnr(image_s,I);
RMSE_prposed_s = sqrt( sum( (I(:)-image_s(:)).^2) / numel(I) );