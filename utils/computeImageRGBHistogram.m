function [hist] = computeImageRGBHistogram(I,nBins)
%% This function computes the normalized RGB histogram for an image

rHist = double(imhist(I(:,:,1), nBins));
gHist = double(imhist(I(:,:,2), nBins));
bHist = double(imhist(I(:,:,3), nBins));

hist = [rHist;gHist;bHist];

% Normalize so that the sum of all elements becomes 1
hist = hist/norm(hist,1);
