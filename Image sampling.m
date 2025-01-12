clc;
clear all;
close all;
I = imread('girl.jpg');
I = im2double(I);
zoom_factor = 2;
[rows, cols] = size(I);
% Perform pixel replication (nearest neighbor interpolation) - User-defined method
new_rows = rows * zoom_factor;
new_cols = cols * zoom_factor;
zoomed_nn = zeros(new_rows, new_cols);
for i = 1:new_rows
for j = 1:new_cols
orig_i = ceil(i / zoom_factor);
orig_j = ceil(j / zoom_factor);
zoomed_nn(i, j) = I(orig_i, orig_j);
end
end
% Zoom the image using built-in MATLAB function (nearest neighbor)
zoomed_nn_builtin = imresize(I, zoom_factor, 'nearest');
% Compute MSE for Nearest Neighbor
mse_nn = mean((zoomed_nn(:) - zoomed_nn_builtin(:)).^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the zoomed image for bilinear interpolation
zoomed_bilinear = zeros(new_rows, new_cols);
% Bilinear Interpolation
for i = 1:new_rows
for j = 1:new_cols
% Calculate the corresponding coordinates in the original image
orig_i = (i - 1) / zoom_factor + 1;
orig_j = (j - 1) / zoom_factor + 1;
%Find the surrounding pixels
i1 = floor(orig_i); i2 = min(i1 + 1, rows);
j1 = floor(orig_j); j2 = min(j1 + 1, cols);
% Interpolation weights
r1 = orig_i - i1;
r2 = orig_j - j1;
% Bilinear Interpolation formula
zoomed_bilinear(i, j) = (1-r1)*(1-r2)*I(i1, j1) + r1*(1-r2)*I(i2, j1) + ...
(1-r1)*r2*I(i1, j2) + r1*r2*I(i2, j2);
end
end
% Use MATLAB's built-in function
zoomed_bilinear_builtin = imresize(I, zoom_factor, 'bilinear');
% Compute MSE for Bilinear Interpolation
mse_bilinear = mean((zoomed_bilinear(:) - zoomed_bilinear_builtin(:)).^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the downsample factor
downsample_factor = 2;
% Pixel Deletion
pixel_deletion = I(1:downsample_factor:end, 1:downsample_factor:end);
% Use MATLAB's built-in function for downsampling
pixel_deletion_builtin = imresize(I, 1/downsample_factor, 'nearest');
% Compute MSE for Pixel Deletion
mse_deletion = mean((pixel_deletion(:) - pixel_deletion_builtin(:)).^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(4,2,1.5);
imshow(I);
title('Original Image');
subplot(4,2,3);
imshow(zoomed_nn);
title('Zoomed Image - Nearest Neighbor (User-defined)');
subplot(4,2,4);
imshow(zoomed_nn_builtin);
title('Zoomed Image - Nearest Neighbor (MATLAB built-in)');
% Display the zoomed image
subplot(4,2,5);
imshow(zoomed_bilinear);
title('Zoomed Image - Bilinear Interpolation (User-defined)');
% Display the MATLAB zoomed image
subplot(4,2,6);
imshow(zoomed_bilinear_builtin);
title('Zoomed Image - Bilinear Interpolation (MATLAB built-in)');
% Display the image after pixel deletion
subplot(4,2,7);
imshow(pixel_deletion);
title('Image After Pixel Deletion (User-defined)');
% Display the MATLAB downsampled image
subplot(4,2,8);
imshow(pixel_deletion_builtin);
title('Image After Pixel Deletion (MATLAB built-in)');
% Display MSE results
fprintf('MSE between user-defined and MATLAB Nearest Neighbor: %.4f\n', mse_nn);
fprintf('MSE between user-defined and MATLAB Bilinear Interpolation: %.4f\n', mse_bilinear);
fprintf('MSE between user-defined and MATLAB Pixel Deletion: %.4f\n', mse_deletion);
