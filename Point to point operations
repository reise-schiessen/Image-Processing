clc;
clear all;
close all;
I = imread('girl.jpg'); % Load the image
I = im2double(I); % Convert to double for mathematical operations
equalized_img = histeq(I); % Perform histogram equalization
negative_image = 1 - I; % Image Negative
% Power Law Transformation
gamma = 1.5; % Example value of gamma
C = 1; % Constant
power_law_image = C * (I .^ gamma);
% Logarithmic Transformation
c = 1 / log(1 + max(I(:))); % Scaling constant
log_image = c * log(1 + I);
%Display original image
figure;
subplot(2,2,1);
imshow(I);
title('Original Image');
% Display the negative image
subplot(2,2,2);
imshow(negative_image);
title('Negative Image');
% Display the power law transformed image
subplot(2,2,3);
imshow(power_law_image);
title(['Power Law Transformation (\gamma = ', num2str(gamma), ')']);
% Display the logarithmic transformed image
subplot(2,2,4);
imshow(log_image);
title('Logarithmic Transformation');
%Display original image
figure;
subplot(2,2,1);
imshow(I);
title('Original Image');
% Display the histogram of the original image
subplot(2,2,2);
imhist(I,128);
title('Histogram of Original Image');
% Display the equalized image
subplot(2,2,3);
imshow(equalized_img);
title('Equalized Image');
% Display the histogram of the equalized image
subplot(2,2,4);
imhist(equalized_img,128);
title('Histogram of Equalized Image');
