clear all
close all
clc
I=imread('1.jpg');
figure
imshow(I)
I=rgb2gray(I);
%% gaussian
J1 = imnoise(I,'gaussian');
figure
imshow(J1)
%% salt & pepper
J2 = imnoise(I,'salt & pepper',0.02);
figure
imshow(J2)
%% median filter
BW1 = medfilt2(J1);
figure
subplot(121)
imshow(BW1)
title('medianfilter for gaussian noise')
BW2 = medfilt2(J2);
subplot(122)
imshow(BW2)
title('medianfilter for salt&papper noise')