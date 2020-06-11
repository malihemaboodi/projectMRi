clear all
close all
clc
I=imread('1.jpg');
figure
imshow(I)
I=rgb2gray(I);
I = im2double(I);
%% gaussian
J1 = imnoise(I,'gaussian',0,0.02);
figure
imshow(J1)
%% salt & pepper
J2 = imnoise(I,'salt & pepper',0.02);
figure
imshow(J2)
%% meanfilter
h=fspecial('average',3);
BW1=imfilter(J1,h);
figure
subplot(121)
imshow(BW1)
title('meanfilter for gaussian noise')
h=fspecial('average',3);
BW2=imfilter(J2,h);
subplot(122)
imshow(BW2)
title('meanfilter for salt&papper noise')
r = snr(I,BW1);
[peaksnr, snr] = psnr(BW1,I);
r = sqrt( sum( (I(:)-BW1(:)).^2) / numel(I) );
