function [grayImage] = importGrey(inputImage)
%This function imports the image and converts to grayscale
image = imread(inputImage);
grayImage = rgb2gray(image);
end

