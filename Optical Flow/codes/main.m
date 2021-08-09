clear all; clc;
% im1=imread('cube1.png');
% im2=imread('cube2.png');
lambda =5;
windowSize =5;
ite=100;

% LucasKanade(im1, im2, windowSize);


% Excercise 1 : The Basics 3.
% im1=imread('dt_001.jpg');           %Hamburg
% im2=imread('dt_002.jpg');           %Hamburg
% LucasKanade(im1, im2, windowSize);

% im1=imread('pepsi0.pgm');           %Pepsi
% im2=imread('pepsi1.pgm');           %Pepsi
% LucasKanade(im1, im2, windowSize);

%  im1=imread('taxi01.pgm');           %taxi
%  im2=imread('taxi02.pgm');           %taxi
%  LucasKanade(im1, im2, windowSize);

im1=imread('frame07.png');           %Yosemite
 im2=imread('frame08.png');           %Yosemite
 LucasKanade(im1, im2, windowSize);

 
