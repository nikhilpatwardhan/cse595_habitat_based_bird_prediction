function [label confidence]=findHabitat(filepath)
%% Given an input image, classify it as one of the possible habitats

load './matfiles/classifiers.mat';
load './matfiles/spatial_pyramid_data/dictionary_200.mat';
load './matfiles/groupIndices.mat';

addpath('./utils/libsvm-mat-3.0-2/');

%% PART 0 : Prepare variables to calculate the spatial pyramid features of the image
[pathstr filename ext] = fileparts(filepath);
imageFileList = {strcat(filename,ext)};
imageBaseDir = pathstr;
dataBaseDir = './matfiles/spatial_pyramid_data/';
maxImageSize = 1000;
gridSpacing = 8;
patchSize = 16;
dictionarySize = 200;
pyramidLevels = 4;
canSkip = 0;

%% PART 1 : Compute the spatial SIFT pyramid
%% If the input image is more than 400 pixels wide, it will be resized and
%% overwritten with width = 400 pixels.
I = imread(filepath);
w = size(I,2);
if w > 400
    scale = 400/w;
    I = imresize(I,scale);
    imwrite(I,filepath);
end;

GenerateSiftDescriptors(imageFileList,imageBaseDir,dataBaseDir,maxImageSize,gridSpacing,patchSize,canSkip);
BuildHistograms(imageFileList,dataBaseDir,'_sift.mat',dictionarySize,canSkip);
featureVector = CompilePyramid(imageFileList,dataBaseDir,sprintf('_texton_ind_%d.mat',dictionarySize),dictionarySize,pyramidLevels,canSkip);

% Classify the features using classifiers for all habitats
prob = zeros(size(model_names, 2),2);

for i=1:size(model_names, 2)
    [pl acc prob(i,:)] = svmpredict(1, featureVector,  classifiers{i}, '-b 1');
end;

[value position] = max(prob(:,1));

% Report a habitat only if the maximum probability is more than 0.1
if value < 0.1
    label = -1;
    confidence = 0;
elseif value < 0.2
    confidence = 'Low';
    label = model_names{position};
elseif value < 0.3
    confidence = 'Medium';
    label = model_names{position};
elseif value < 0.4
    confidence = 'High';
    label = model_names{position};
else
    confidence = 'Very High';
    label = model_names{position};
end;