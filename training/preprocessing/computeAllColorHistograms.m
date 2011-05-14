% Loop through all images to find their Color Histograms
clear;
clc;

load '../../matfiles/groupIndices.mat';

addpath('../../utils');

baseDir = '../../data/images/';
list = dir(strcat(baseDir,'*.jpg'));
nBins = 64;

allColorHistograms = zeros(nBins*3,length(list));

for i=1:length(list)
    fname = list(i).name;
    disp(fname);
    
    I = imread(strcat(baseDir,fname));
    if (size(I,3) ~= 3)
        fprintf('Error reading file %s. File appears to be grayscale.',strcat(baseDir,fname));
    end;
    
    allColorHistograms(:,i) = computeImageRGBHistogram(I,nBins);
end;

% Transpose
allColorHistograms = allColorHistograms';

newHist = cell(1,length(categorySize));
for i=1:length(categorySize)-1
    startRow = groupIndices(i);
    endRow = groupIndices(i+1)-1;
    newHist{i} = allColorHistograms(startRow:endRow,:);
end;
newHist{i+1} = allColorHistograms(endRow+1:length(allColorHistograms),:);

save('../../matfiles/allColor.mat','allColorHistograms','newHist');
