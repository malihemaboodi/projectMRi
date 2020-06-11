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
%% midpoint filter
A = im2double(J1);
fun = @(x) min(x(:)); 
B = nlfilter(A,[3 3],fun); 
figure
imshow(B)
fun = @(x) max(x(:)); 
B = nlfilter(A,[3 3],fun);
figure
imshow(B)
A = im2double(J2);
fun = @(x) min(x(:)); 
B = nlfilter(A,[3 3],fun); 
figure
imshow(B)
fun = @(x) max(x(:)); 
B = nlfilter(A,[3 3],fun);
figure
imshow(B)