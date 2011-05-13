% Loop through all images to find their Color Histograms
load '../../matfiles/groupIndices.mat';

baseDir = '../../data/images/';
list = dir(strcat(baseDir,'*.jpg'));
nBins = 32;

allColorHistograms = zeros(nBins*3,length(list));

for i=1:length(list)
    fname = list(i).name;
    
    I = imread(strcat(baseDir,fname));
    if (size(I,3) ~= 3)
        fprintf('Error reading file %s. File appears to be grayscale.',strcat(baseDir,fname));
    end;
    
    allColorHistograms(:,i) = computeImageRGBHistogram(I,nBins);
end;

% Crude attempt at normalizing (Dividing by maximum element in each column
% (file)
for i=1:length(list)
    allColorHistograms(:,i) = allColorHistograms(:,i)/max(allColorHistograms(:,i));
end;

% Transpose
allColorHistograms = allColorHistograms';

newHist = cell(1,length(categorySize));
for i=1:length(categorySize)
    if (i==1)
        newHist{i} = allColorHistograms(i:categorySize{i},:);
    else
        newHist{i} = allColorHistograms(categorySize{i-1}+1:categorySize{i-1}+categorySize{i},:);
    end;
end;

save('../../matfiles/allColor.mat','allColorHistograms','newHist');
