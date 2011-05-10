function label=findHabitat(filepath)
%% Given an input image, classify it as one of the possible habitats

load './matfiles/classifiers.mat';
load './matfiles/dictionary_200.mat';
load './matfiles/model_names_no_mountains.mat';

addpath('./utils/libsvm-mat-3.0-1/');

%% PART 0 : Prepare variables to calculate the spatial pyramid features of the image
[pathstr filename ext] = fileparts(filepath);
imageFileList = {strcat(filename,ext)};
imageBaseDir = pathstr;
dataBaseDir = './matfiles/spatial_pyramid_data/';
maxImageSize = 1000;
gridSpacing = 8;
patchSize = 16;
dictionarySize = 200;
pyramidLevels = 3;
canSkip = 0;

%% PART 1 : Compute the spatial SIFT pyramid
GenerateSiftDescriptors(imageFileList,imageBaseDir,dataBaseDir,maxImageSize,gridSpacing,patchSize,canSkip);
BuildHistograms(imageFileList,dataBaseDir,'_sift.mat',dictionarySize,canSkip);
featureVector = CompilePyramid(imageFileList,dataBaseDir,sprintf('_texton_ind_%d.mat',dictionarySize),dictionarySize,pyramidLevels,canSkip);

% Classify the features using classifiers for all habitats
prob = zeros(size(model_names, 2),2);
pl = zeros(size(model_names, 2),1);
acc = zeros(size(model_names, 2),1);

for i=1:size(model_names, 2)
    [pl acc prob(i,:)] = svmpredict(1, featureVector,  classifiers{i}, '-b 1');
end;

[value position] = max(prob(:,1));

label = model_names{position};