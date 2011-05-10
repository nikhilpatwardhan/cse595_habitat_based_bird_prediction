clear;
load '../matfiles/finalPyramids.mat';
load '../matfiles/finalPyramidLengths.mat';
load '../matfiles/model_names_no_mountains.mat';

p = 0.5;

numOfModels = size(model_names, 2);
labels = cell(1, numOfModels);

for i=1:numOfModels
   labels{i} = zeros(pyramidLengths{i}, 1);
end

classifiers = cell(1, numOfModels);

for i=1:numOfModels
    
    testLabels = labels;
    testLabels{i}(:) = 1;
    [ts, tl] = createTrainingSets(p, i, pyramids, pyramidLengths, testLabels);
    classifiers{i} = svmtrain(tl', ts', '-c 0.01 -g 0.5 -b 1');    
end  
  
save('../matfiles/classifiers.mat', 'classifiers');