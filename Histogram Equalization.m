% Dimensions of the image
rows = 128;
cols = 128;
img = zeros(rows, cols); % Initialize the image matrix
% Pixel intensity values
intensity_1 = 8;
intensity_2 = 64;
intensity_3 = 128;
% Define the quarters and half dimensions
quarter_rows = rows / 2;
quarter_cols = cols / 2;
img(1:quarter_rows, 1:quarter_cols) = intensity_1; % First quarter with intensity 8
img(1:quarter_rows, quarter_cols+1:end) = intensity_2; % Second quarter with intensity 64
img(quarter_rows+1:end, :) = intensity_3; % Remaining half with intensity 128
equalized_img = histeq(uint8(img)); % Perform histogram equalization
% Display the original image
figure;
subplot(2,3,1);
imshow(uint8(img));
title('Original Grayscale Image');
% Display the histogram of the original image
subplot(2,2,2);
imhist(uint8(img));
title('Histogram of Original Image');
% Display the equalized image
subplot(2,2,3);
imshow(equalized_img);
title('Equalized Image');
% Display the histogram of the equalized image
subplot(2,2,4);
imhist(equalized_img);
title('Histogram of Equalized Image');
% Print intensities to the command window
disp('Unique intensities in the original image:');
disp(original_intensities');
disp('Unique intensities in the equalized image:');
disp(equalized_intensities');
